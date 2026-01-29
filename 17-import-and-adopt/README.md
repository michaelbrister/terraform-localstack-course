
# Lab 17 — Import and Adopt Existing Infrastructure (No Recreation)

## Scenario
A bucket and DynamoDB table already exist (created out-of-band). Your job is to bring them under Terraform without replacing them.

## Outcomes
- Use terraform import correctly
- Make plan converge (no perpetual diffs)
- Explain drift vs desired state

## Timebox
- Beginner: 90–150 minutes
- Experienced: 45–90 minutes

## Steps

1. Create resources out-of-band in LocalStack:
   - `aws s3 mb s3://tf-course-imported-bucket`
   - Create a DynamoDB table via AWS CLI (or use a second bucket if preferred).
2. Write Terraform config that matches those resources (names must match).
3. Run `terraform import` for each resource.
4. Run `terraform plan` and make it converge (adjust tags/settings if needed).
5. Apply and confirm plan is clean afterward.


## Deliverables

- Terraform config files
- `terraform import` commands used (record them)
- A clean plan after convergence


## Grading rubric

Pass if:
- No destroy/create for imported resources
- Learner can explain why import does not “read config automatically”
