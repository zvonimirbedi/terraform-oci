resource "kubernetes_persistent_volume_v1" "cluster_databases_peristent_volume" {
  metadata {
    name = data.oci_core_volumes.cluster_database_volume.volumes[0].id
    labels = {
      "failure-domain.beta.kubernetes.io/region" = var.region
      "failure-domain.beta.kubernetes.io/zone" = replace(data.oci_core_volumes.cluster_database_volume.volumes[0].availability_domain, "/.*:/","")
    }
    annotations = {
      "ociAvailabilityDomain" = replace(data.oci_core_volumes.cluster_database_volume.volumes[0].availability_domain, "/.*:/","")
      "ociCompartment" = data.oci_identity_compartments.cluster_compartment.compartments[0].id
      "ociProvisionerIdentity" = "ociProvisionerIdentity"
      "ociVolumeID" = data.oci_core_volumes.cluster_database_volume.volumes[0].id
      "pv.kubernetes.io/provisioned-by" = "oracle.com/oci"
    }
  }
  spec {
    capacity = {
      storage = "${var.databases_block_volume_size_gb}Gi"
    }
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key = "failure-domain.beta.kubernetes.io/zone"
            operator = "In"
            values = [replace(data.oci_core_volumes.cluster_database_volume.volumes[0].availability_domain, "/.*:/","")]
          }
        }
      }
    }
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name = "oci"
    access_modes = ["ReadWriteOnce"]
    volume_mode = "Filesystem"
    persistent_volume_source {
      flex_volume {
        driver = "oracle/oci"
        fs_type = "ext4"
      }
    }
  }
}


resource "kubernetes_persistent_volume_claim_v1" "cluster_databases_persistent_volume_claim" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    name = data.oci_core_volumes.cluster_database_volume.volumes[0].display_name
    namespace = "databases"
    annotations = {
      "pv.kubernetes.io/bind-completed" = "yes"
      "pv.kubernetes.io/bound-by-controller" = "yes"
      "volume.beta.kubernetes.io/storage-provisioner" = "oracle.com/oci"
      "volume.kubernetes.io/storage-provisioner" = "oracle.com/oci"
    }
  }
  spec {
    storage_class_name = "oci"
    access_modes = ["ReadWriteOnce"]
    volume_name = kubernetes_persistent_volume_v1.cluster_databases_peristent_volume.metadata[0].name
    resources {
      requests = {
        storage = "${var.databases_block_volume_size_gb}Gi"
      }
    }
  }
}

# https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/clicontainer.htm
resource "kubernetes_cron_job_v1" "cronjob_bucket_to_volume_databases" {
  metadata {
    name = "cronjob-bucket-to-volume-databases"
    namespace  = "databases"
  }
  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 1
    schedule                      = "0 1 * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        # suspend                    = true
        backoff_limit              = 1
        ttl_seconds_after_finished = 35
        template {
          metadata {}
          spec {
            automount_service_account_token = "false"
            container {
              name    = "oci-cli"
              image   = "rclone/rclone"
              command = [
                "/bin/sh", "-c", 
                <<-EOT
                  date 
                  echo Starting job for storing data from Cloud Bucket to Kubernetes Persistant Volume
                  export RCLONE_CONFIG_AWS_STORAGE_TYPE='${var.STORAGE_TYPE}'
                  export RCLONE_CONFIG_AWS_STORAGE_ACCESS_KEY_ID='${var.STORAGE_ACCESS_KEY_ID}'
                  export RCLONE_CONFIG_AWS_STORAGE_SECRET_ACCESS_KEY='${var.STORAGE_SECRET_ACCESS_KEY}'
                  export RCLONE_CONFIG_AWS_STORAGE_REGION='${var.STORAGE_REGION}'
                  rclone sync AWS_STORAGE:${var.STORAGE_BUCKET_NAME}/databases /databases
                EOT
                ]
              
              volume_mount {
                name       = "databases"
                mount_path = "/databases"
              }
            }

            volume {
              name = "databases"
              persistent_volume_claim {
                claim_name = kubernetes_persistent_volume_claim_v1.cluster_databases_persistent_volume_claim.metadata[0].name
              }
            }
          }
        }
      }
    }
  }
}

resource "null_resource" "trigger_cronjob_bucket_to_volume_databases" {
  depends_on = [kubernetes_cron_job_v1.cronjob_bucket_to_volume_databases]
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      kubectl create job cronjob-bucket-to-volume-databases --from=cronjob/cronjob-bucket-to-volume-databases -n databases
      kubectl wait --timeout=3600s --for=condition=Complete job/cronjob-bucket-to-volume-databases -n databases      
    EOT
  }
}


# https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/clicontainer.htm
resource "kubernetes_cron_job_v1" "cronjob_volume_to_bucket_databases" {
  metadata {
    name = "cronjob-volume-to-bucket-databases"
    namespace  = "databases"
  }
  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 1
    schedule                      = "0 1 * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        # suspend                    = true
        backoff_limit              = 1
        ttl_seconds_after_finished = 35
        template {
          metadata {}
          spec {
            automount_service_account_token = "false"
            container {
              name    = "oci-cli"
              image   = "rclone/rclone"
              command = [
                "/bin/sh", "-c", 
                <<-EOT
                  date 
                  echo Starting job for storing data from Kubernetes Persistant Volume to Cloud Bucket 
                  export RCLONE_CONFIG_AWS_STORAGE_TYPE='${var.STORAGE_TYPE}'
                  export RCLONE_CONFIG_AWS_STORAGE_ACCESS_KEY_ID='${var.STORAGE_ACCESS_KEY_ID}'
                  export RCLONE_CONFIG_AWS_STORAGE_SECRET_ACCESS_KEY='${var.STORAGE_SECRET_ACCESS_KEY}'
                  export RCLONE_CONFIG_AWS_STORAGE_REGION='${var.STORAGE_REGION}'
                  rclone sync /databases AWS_STORAGE:${var.STORAGE_BUCKET_NAME}/databases
                EOT
                ]
              
              volume_mount {
                name       = "databases"
                mount_path = "/databases"
              }
            }

            volume {
              name = "databases"
              persistent_volume_claim {
                claim_name = kubernetes_persistent_volume_claim_v1.cluster_databases_persistent_volume_claim.metadata[0].name
              }
            }
          }
        }
      }
    }
  }
}

resource "null_resource" "cronjob_volume_to_bucket_databases" {
  depends_on = [kubernetes_cron_job_v1.cronjob_volume_to_bucket_databases]
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      kubectl create job cronjob-volume-to-bucket-databases --from=cronjob/cronjob-volume-to-bucket-databases -n databases
      kubectl wait --timeout=3600s --for=condition=Complete job/cronjob-volume-to-bucket-databases -n databases      
    EOT
    when        = destroy
  }
}
