# LocalStack Bootstrap — Docker & Docker Compose Setup

This guide helps you get **Docker**, **Docker Compose**, and **LocalStack** running on your machine so you can complete the Terraform labs in this course.

You do **not** need prior container experience to follow this guide.

---

## What is Docker? (Quick Primer)

**Docker** is a tool that lets you run applications in lightweight, isolated environments called **containers**.

Think of a container as:
- a mini computer
- with its own filesystem
- its own dependencies
- but sharing your machine’s operating system

Why this matters for this course:
- LocalStack (a local AWS emulator) runs inside a Docker container
- You do NOT need to install AWS services locally
- Everything runs consistently across machines

---

## What is Docker Compose?

**Docker Compose** lets you:
- define containers using a config file
- start everything with a single command
- avoid long `docker run` commands

In this course:
- You may see both `docker run` and `docker compose`
- Either is acceptable
- Compose is preferred for repeatability

---

## Step 1 — Install Docker

### macOS (Apple Silicon & Intel)

1. Download Docker Desktop for Mac  
   https://www.docker.com/products/docker-desktop/
2. Install and open Docker Desktop
3. Wait until Docker reports **Docker Engine is running**

Verify:

```bash
docker version
docker compose version
```

---

### Windows (Windows 10/11)

Docker requires **WSL2**.

```powershell
wsl --install
```

Reboot if prompted.

Download Docker Desktop for Windows:  
https://www.docker.com/products/docker-desktop/

Verify:

```bash
docker version
docker compose version
```

---

## Step 2 — Start LocalStack

### Option A — docker run

```bash
docker run --rm -it \
  -p 4566:4566 \
  -p 4510-4559:4510-4559 \
  localstack/localstack
```

---

### Option B — Docker Compose (Recommended)

```yaml
version: "3.8"
services:
  localstack:
    image: localstack/localstack:latest
    ports:
      - "4566:4566"
      - "4510-4559:4510-4559"
    environment:
      - SERVICES=s3,dynamodb,iam,lambda,sqs,sns,logs,cloudwatch,events,sts
      - AWS_DEFAULT_REGION=us-east-1
```

Start:

```bash
docker compose up
```

---

## Step 3 — Configure AWS CLI Credentials

```bash
aws configure set aws_access_key_id test
aws configure set aws_secret_access_key test
aws configure set region us-east-1
```

---

## Step 4 — Verify

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

---

## Mental Model

Docker → LocalStack → Terraform → Fake AWS

Safe, local, repeatable.
