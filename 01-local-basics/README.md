# Lab 01 — Terraform Local State Basics (S3 + LocalStack)

## What this lab teaches you

This lab introduces the **core Terraform workflow** using:

- **Local state** (default Terraform behavior)
- A **single AWS resource**
- **LocalStack** as a safe AWS emulator

By completing this lab, you will understand:

- What Terraform *state* is and why it matters
- How `init`, `plan`, `apply`, and `destroy` work together
- How Terraform maps configuration → real infrastructure
- How **outputs** expose values from Terraform

This knowledge is foundational for **Terraform Associate exams** and real-world use.

---

## Infrastructure created by this lab

This configuration creates **one S3 bucket**:

```hcl
resource "aws_s3_bucket" "demo" {
  bucket = "tf-course-local-demo"

  tags = {
    Name = "local-demo"
  }
}
```

Terraform will:
- Create the bucket in LocalStack
- Record it in a local state file (`terraform.tfstate`)
- Track it for future changes or destruction

---

## Understanding Terraform outputs

```hcl
output "bucket" {
  value       = aws_s3_bucket.demo.bucket
  description = "Name of the S3 bucket created by this Terraform configuration"
}
```

### What is an output?
An output is a **named value Terraform exposes after apply**.

Outputs are used to:
- Display useful information to humans
- Pass values between modules
- Provide inputs to CI/CD pipelines or scripts

### What should go in `description`?
A good output description answers:

- **What is this value?**
- **Why would someone care about it?**
- **When would it be used?**

Good examples:
- “Name of the S3 bucket created by this configuration”
- “ARN of the SNS topic used for notifications”
- “DynamoDB table name used for Terraform state locking”

Bad examples:
- `""` (empty)
- “bucket”
- “output”

> Exam tip: descriptions are not required, but **clear descriptions are a best practice** and expected in professional Terraform code.

---

## Terraform workflow (step by step)

### 1. Format the configuration

```bash
terraform fmt
```

Ensures consistent formatting.

---

### 2. Initialize Terraform

```bash
terraform init
```

- Downloads providers
- Prepares the working directory
- Initializes local state

Expected:
```
Terraform has been successfully initialized!
```

---

### 3. Validate the configuration

```bash
terraform validate
```

Checks syntax and references (no API calls).

Expected:
```
Success! The configuration is valid.
```

---

### 4. Create a plan

```bash
terraform plan -out tfplan
```

Shows what Terraform *will* change without applying it.

Expected:
```
Plan: 1 to add, 0 to change, 0 to destroy.
```

---

### 5. Apply the plan

```bash
terraform apply -auto-approve
```

Creates the S3 bucket and updates state.

Expected:
```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

---

## Viewing outputs

```bash
terraform output
```

Expected:
```
bucket = "tf-course-local-demo"
```

Outputs let you confirm important values without inspecting state directly.

---

## Verifying with AWS CLI (optional)

```bash
aws --endpoint-url=http://localhost:4566 s3 ls | grep tf-course-local-demo
```

Confirms the bucket exists in LocalStack.

---

## Cleanup

```bash
terraform destroy -auto-approve
```

Deletes the bucket and clears state.

Expected:
```
Destroy complete! Resources: 1 destroyed.
```

---

## Key takeaways

- Terraform state tracks real infrastructure
- Outputs expose useful information from state
- LocalStack allows safe experimentation
- The Terraform workflow is consistent across environments

This lab forms the foundation for every Terraform workflow that follows.
