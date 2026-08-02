# Terraform Drift Detection Automation using Jenkins

## 📌 Project Overview

This project implements an automated **Terraform Drift Detection pipeline** using **Jenkins CI/CD**.

The purpose of this pipeline is to identify any manual or unauthorized infrastructure changes made outside Terraform and notify the team through email alerts.

---

## 🛠️ Technologies Used

- **Terraform** - Infrastructure as Code (IaC)
- **Jenkins** - CI/CD Pipeline Automation
- **AWS EC2** - Cloud Infrastructure
- **AWS S3** - Terraform Remote State Backend
- **AWS DynamoDB** - Terraform State Locking
- **GitHub** - Source Code Management
- **Gmail SMTP** - Email Notifications

---

## 🔍 Drift Detection Logic

Terraform plan exit codes are used to identify infrastructure changes:

| Exit Code | Status |
|-----------|--------|
| 0 | No Changes |
| 1 | Terraform Error |
| 2 | Infrastructure Drift Detected |

When drift is detected, Jenkins marks the build as **UNSTABLE** and sends an email notification.

---

## 📂 Project Structure

```
.
├── Jenkins
│   └── Jenkinsfile
│
├── Terraform
│   ├── main.tf
│   ├── provider.tf
│   ├── backend.tf
│   └── variables.tf
│
└── README.md
```

---

## 🎯 Key Highlights

- Automated Terraform drift monitoring
- Jenkins-based CI/CD workflow
- AWS remote state management
- Terraform plan artifact archiving
- Automated email notifications
- Infrastructure change visibility without manual checks

---

## 🚀 Future Enhancements

- Scheduled daily drift checks
- Slack / Teams notifications
- Terraform security scanning integration
- Automated approval workflow for infrastructure changes

---

## 👨‍💻 Author

**Srikarasubhadev**

## 🔄 Project Workflow
```
                Developer
                    |
                    |
                    v
              GitHub Repository
                    |
                    |
                    v
             Jenkins Pipeline Trigger
                    |
                    |
                    v
          +-----------------------+
          |  Terraform Workflow   |
          +-----------------------+
                    |
                    |
        +-------------------------+
        | Terraform Init          |
        | - Initialize Backend   |
        | - Download Providers   |
        +-------------------------+
                    |
                    v
        +-------------------------+
        | Terraform Validate      |
        | - Check Configuration  |
        | - Validate Syntax      |
        +-------------------------+
                    |
                    v
        +-------------------------+
        | Terraform Plan          |
        | - Compare State         |
        | - Detect Drift          |
        +-------------------------+
                    |
                    v
          Terraform Exit Code Check

                    |
        +-----------+------------+
        |                        |
        v                        v

 Exit Code 0              Exit Code 2
 No Changes               Drift Detected

        |                        |
        v                        v

 Jenkins SUCCESS          Jenkins UNSTABLE

        |                        |
        |                        |
        +-----------+------------+
                    |
                    v

          Generate Terraform Reports

          - plan.log
          - full-plan.log
          - summary.log

                    |
                    v

          Archive Reports in Jenkins

                    |
                    v

          Email Notification

          SUCCESS:
          No Drift Detected

          ALERT:
          Infrastructure Drift Found

          FAILURE:
          Pipeline Execution Failed

```

---

## Workflow Explanation

1. **Code Commit**
   - Terraform configuration and Jenkinsfile are maintained in GitHub.
   - Any pipeline execution pulls the latest code from the repository.

2. **Jenkins Pipeline Execution**
   - Jenkins starts the automated workflow.
   - The pipeline performs Terraform operations sequentially.

3. **Terraform Initialization**
   - Connects to the remote backend.
   - Initializes Terraform providers and state configuration.

4. **Terraform Validation**
   - Ensures Terraform files are syntactically correct and valid.

5. **Terraform Plan & Drift Detection**
   - Terraform compares:
     - Current AWS infrastructure state
     - Terraform configuration
     - Stored Terraform state
   
   - Any manual infrastructure changes are identified as drift.

6. **Report Generation**
   - Terraform execution details are captured into log files.
   - Reports are archived in Jenkins for review.

7. **Notification**
   - Jenkins sends email notifications based on the pipeline result:
     - ✅ No Drift Detected → SUCCESS notification
     - ⚠️ Drift Detected → UNSTABLE alert
     - ❌ Pipeline Failure → FAILURE notification

---

## Drift Detection Flow

```
Terraform Code
       |
       |
       v
Terraform State (S3 Backend)
       |
       |
       v
AWS Infrastructure
       |
       |
       v
terraform plan comparison
       |
       |
       +----------------+
       |                |
       v                v

No Difference       Difference Found

SUCCESS             UNSTABLE

                     |
                     v

              Email Alert Sent

```


---------------------------------------------------------------------------------------------------------------------------
# Overall workflow for TF Automation project for multiple environment

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
