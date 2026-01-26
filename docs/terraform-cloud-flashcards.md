# Terraform Cloud Flashcards (Q/A)

1. Q: What is a Terraform Cloud workspace?
   A: A unit that contains state, variables, and run history; where plans/applies occur.

2. Q: What is a speculative plan?
   A: A plan for review (often on PR) that does not apply changes.

3. Q: What does state locking prevent?
   A: Concurrent operations corrupting state (two applies at once).

4. Q: Remote state vs remote execution?
   A: Remote state stores state remotely; remote execution runs Terraform remotely.

5. Q: What is a variable set?
   A: A shared group of variables applied to multiple workspaces.

6. Q: Why use VCS-driven workflow?
   A: Reviewable plans on PR; auditable applies on merge.

7. Q: What is Sentinel?
   A: HashiCorp policy-as-code that enforces rules on runs.

8. Q: Do sensitive variables avoid state storage?
   A: No—sensitive affects display/logging, not whether it's in state.

9. Q: Common environment strategy in TFC?
   A: Separate workspaces per environment (dev/stage/prod).

10. Q: Who should have apply access?
    A: Fewer people; least privilege.
