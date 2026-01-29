
# Predict-the-Plan Quizzes (Instructor or Self-Paced)

These quizzes train learners to reason like the exam: predict behavior before running Terraform.

## Quiz format
- Show a diff (code change)
- Ask learners to predict plan outcome:
  - add/change/destroy
  - replacement?
  - why?

## Example 1: Change bucket name string
Change:
- bucket = "tf-course-dev-logs"
to:
- bucket = "tf-course-dev-logs2"

Prediction:
- Replacement (S3 bucket names are immutable; provider forces recreate)

## Example 2: Reorder list with count
Prediction:
- Replacement due to index identity changes

## Example 3: Add a new key to for_each map
Prediction:
- Only one new resource created

## Example 4: Add optional dynamic block conditionally
Prediction:
- Resource updated in place (if supported), no replacement
