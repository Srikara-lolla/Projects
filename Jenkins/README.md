---------------------------------------------------------------------------------------------------------------------------
# Overall workflow for TF Automation project

               Daily Cron
                    │
                    ▼
          Checkout Terraform Code
                    │
                    ▼
          Assume AWS IAM Role
                    │
                    ▼
             terraform init
                    │
                    ▼
       Select/Create Workspace
                    │
                    ▼
            terraform fmt
                    │
                    ▼
          terraform validate
                    │
                    ▼
      terraform plan -detailed-exitcode
                    │
          ┌─────────┼──────────┐
          │         │          │
      Exit=0    Exit=2     Exit=1
          │         │          │
     No Drift    Drift      Error
          │         │          │
          │    Generate Report │
          │         │          │
          │    Upload to S3    │
          │         │          │
          └──────┬──┴──────────┘
                 ▼
           Send Email/Slack
                 │
                 ▼
           Archive Artifacts
                 │
                 ▼
            Clean Workspace

---------------------------------------------------------------------------------------------------------------------------------
