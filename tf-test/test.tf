

# https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/clicontainer.htm
resource "kubernetes_cron_job_v1" "wordpress_volume_to_bucket" {
  metadata {
    name = "wordpress-volume-to-bucket"
    namespace  = "tools"
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
                  mkdir -p /wordpress_backup/
                  tar -zcvf /wordpress_backup/wordpress_backup.tar.gz /wordpress/
                  export RCLONE_CONFIG_AWS_STORAGE_TYPE='${var.STORAGE_TYPE}'
                  export RCLONE_CONFIG_AWS_STORAGE_ACCESS_KEY_ID='${var.STORAGE_ACCESS_KEY_ID}'
                  export RCLONE_CONFIG_AWS_STORAGE_SECRET_ACCESS_KEY='${var.STORAGE_SECRET_ACCESS_KEY}'
                  export RCLONE_CONFIG_AWS_STORAGE_REGION='${var.STORAGE_REGION}'

                  rclone sync /wordpress_backup/ AWS_STORAGE:${var.STORAGE_BUCKET_NAME}/wordpress_backup/
                  sleep 200
                EOT
                ]
              
              volume_mount {
                name       = "wordpress"
                mount_path = "/wordpress"
              }
            }

            volume {
              name = "wordpress"
              persistent_volume_claim {
                claim_name = "wordpress-volume"
              }
            }
          }
        }
      }
    }
  }
}

resource "null_resource" "wordpress_volume_to_bucket" {
  depends_on = [kubernetes_cron_job_v1.wordpress_volume_to_bucket]
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      kubectl create job wordpress-volume-to-bucket --from=cronjob/wordpress-volume-to-bucket -n tools
      kubectl wait --timeout=3600s --for=condition=Complete job/wordpress-volume-to-bucket -n tools      
    EOT
    when        = destroy
  }
}

