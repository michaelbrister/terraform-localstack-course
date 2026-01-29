
# Instructor Notes (Practical facilitation)

## Teaching approach for non-programmers
1) Start with **mental models** (state is Terraform’s memory)
2) Force learners to **predict the plan**
3) Repeat: “Terraform describes *what*, not *how*”
4) Use short loops: explain → demo → hands-on → debrief

## Common beginner struggles
- Confusing state with configuration
- Fear of “destroy” (teach safe sandbox habits)
- Misunderstanding `count` vs `for_each`
- Not reading plan output carefully
- Overusing dynamic blocks

## How to teach plan reading
Ask learners to answer:
- What resources will be created?
- Will anything be replaced?
- Why does Terraform think it must replace?
- What values are unknown until apply?

## Pace recommendations
- If class includes non-programmers: double the time for labs 01–03.
- Make console drills (08) a daily warm-up (10 min/day).

## Assessment (simple)
- Must complete labs 01–07 without help
- Must complete drills 01–06 within time
- Must explain remote state and locking
- Must complete one refactor with moved block successfully

## “Red flag” behaviors
- Applying without reading plan
- Using count for long-lived resources
- Using force-unlock without understanding locks
- Editing state by hand
