resource "kubernetes_persistent_volume_v1" "cluster_database_peristent_volume" {
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
      storage = "${var.database_block_volume_size_gb}Gi"
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


resource "kubernetes_persistent_volume_claim_v1" "cluster_database_persistent_volume_claim" {
  metadata {
    name = var.database_block_volume_name
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
    volume_name = kubernetes_persistent_volume_v1.cluster_database_peristent_volume.metadata[0].name
    resources {
      requests = {
        storage = "${var.database_block_volume_size_gb}Gi"
      }
    }
  }
}

resource "kubernetes_secret_v1" "secret_oci_cli_config" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    namespace = "tools"
    name = "secret-oci-config"
  }
  data = {
    "config" = "${file("./oci-cli/config")}"
    "file_name" = "config"
    "mount_path" = "/oracle/.oci/config"
  }
}

resource "kubernetes_secret_v1" "secret_oci_cli_api_key_pem" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    namespace = "tools"
    name = "secret-oci-api-key-pem"
  }
  data = {
    "oci_api_key.pem" = "${file("./oci-cli/oci_api_key.pem")}"
    "file_name" = "oci_api_key.pem"
    "mount_path" = "/oracle/.oci/oci_api_key.pem"
  }
}


# https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/clicontainer.htm
resource "kubernetes_cron_job_v1" "cron_job_volume_persistance" {
  metadata {
    name = "oci-cli-cron-job"
    namespace  = "tools"
  }
  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 2
    schedule                      = "0 1 * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 15
        template {
          metadata {}
          spec {
            automount_service_account_token = "false"
            container {
              name    = "oci-cli"
              image   = "ghcr.io/oracle/oci-cli:latest"
              command = ["/bin/sh", "-c", "date; echo Hello from the Kubernetes cluster; export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True; oci os bucket list --compartment-id ocid1.compartment.oc1..aaaaaaaaxcm5pbn77eazwycnzlc5ldme3gzwgpczs35ssi52hceoz7nybxyq"]
              volume_mount {
                name       = kubernetes_secret_v1.secret_oci_cli_config.metadata[0].name
                mount_path = kubernetes_secret_v1.secret_oci_cli_config.data.mount_path
                sub_path   = kubernetes_secret_v1.secret_oci_cli_config.data.file_name
              }
              volume_mount {
                name       = kubernetes_secret_v1.secret_oci_cli_api_key_pem.metadata[0].name
                mount_path = kubernetes_secret_v1.secret_oci_cli_api_key_pem.data.mount_path
                sub_path   = kubernetes_secret_v1.secret_oci_cli_api_key_pem.data.file_name
              }
            }
            volume {
              name = kubernetes_secret_v1.secret_oci_cli_config.metadata[0].name
              secret {
                secret_name = kubernetes_secret_v1.secret_oci_cli_config.metadata[0].name
                items {
                  key = kubernetes_secret_v1.secret_oci_cli_config.data.file_name
                  path = kubernetes_secret_v1.secret_oci_cli_config.data.file_name
                }
              }
            }
            volume {
              name = kubernetes_secret_v1.secret_oci_cli_api_key_pem.metadata[0].name
              secret {
                secret_name = kubernetes_secret_v1.secret_oci_cli_api_key_pem.metadata[0].name
                items {
                  key = kubernetes_secret_v1.secret_oci_cli_api_key_pem.data.file_name
                  path = kubernetes_secret_v1.secret_oci_cli_api_key_pem.data.file_name
                }
              }
            }
          }
        }
      }
    }
  }
}


# https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/clicontainer.htm
resource "kubernetes_job_v1" "job_volume_persistance" {
  metadata {
    name = "oci-cli-job"
    namespace  = "tools"
  }
  wait_for_completion = true
  timeouts {
    create = "2m"
    update = "2m"
  }
  spec {
    ttl_seconds_after_finished = 15
    template {
      metadata {}
      spec {
        automount_service_account_token = "false"
        container {
          name    = "oci-cli"
          image   = "ghcr.io/oracle/oci-cli:latest"
          command = ["/bin/sh", "-c", "date; echo Hello from the Kubernetes cluster; export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True; oci os bucket list --compartment-id ocid1.compartment.oc1..aaaaaaaaxcm5pbn77eazwycnzlc5ldme3gzwgpczs35ssi52hceoz7nybxyq"]
          volume_mount {
            name       = kubernetes_secret_v1.secret_oci_cli_config.metadata[0].name
            mount_path = kubernetes_secret_v1.secret_oci_cli_config.data.mount_path
            sub_path   = kubernetes_secret_v1.secret_oci_cli_config.data.file_name
          }
          volume_mount {
            name       = kubernetes_secret_v1.secret_oci_cli_api_key_pem.metadata[0].name
            mount_path = kubernetes_secret_v1.secret_oci_cli_api_key_pem.data.mount_path
            sub_path   = kubernetes_secret_v1.secret_oci_cli_api_key_pem.data.file_name
          }
        }
        volume {
          name = kubernetes_secret_v1.secret_oci_cli_config.metadata[0].name
          secret {
            secret_name = kubernetes_secret_v1.secret_oci_cli_config.metadata[0].name
            items {
              key = kubernetes_secret_v1.secret_oci_cli_config.data.file_name
              path = kubernetes_secret_v1.secret_oci_cli_config.data.file_name
            }
          }
        }
        volume {
          name = kubernetes_secret_v1.secret_oci_cli_api_key_pem.metadata[0].name
          secret {
            secret_name = kubernetes_secret_v1.secret_oci_cli_api_key_pem.metadata[0].name
            items {
              key = kubernetes_secret_v1.secret_oci_cli_api_key_pem.data.file_name
              path = kubernetes_secret_v1.secret_oci_cli_api_key_pem.data.file_name
            }
          }
        }
      }
    }
  }
}