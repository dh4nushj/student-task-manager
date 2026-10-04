# setup-github.ps1
# Creates labels, milestone, and issues using the GitHub CLI (gh).
# Run from the root of an existing GitHub repo that has a remote set up.

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── 1. Labels ────────────────────────────────────────────────
$labels = @(
    @{ name = "feature";        color = "5319E7"; description = "New feature or functionality" },
    @{ name = "bug";            color = "D73A4A"; description = "Something isn't working" },
    @{ name = "enhancement";    color = "A2EEEF"; description = "Improvement to existing feature" },
    @{ name = "documentation";  color = "0075CA"; description = "Documentation updates" },
    @{ name = "testing";        color = "BFD4F2"; description = "Test-related changes" },
    @{ name = "high-priority";  color = "B60205"; description = "Needs immediate attention" }
)

Write-Host "`n=== Creating labels ===" -ForegroundColor Cyan
foreach ($l in $labels) {
    gh label create $l.name --color $l.color --description $l.description --force
    Write-Host "  ✔ $($l.name)" -ForegroundColor Green
}

# ── 2. Milestone ─────────────────────────────────────────────
Write-Host "`n=== Creating milestone ===" -ForegroundColor Cyan
gh api repos/{owner}/{repo}/milestones -f title="v1.0" -f state=open -f description="First stable release" 2>$null
Write-Host "  ✔ v1.0" -ForegroundColor Green

# ── 3. Issues (order matters — sequential creation) ──────────
Write-Host "`n=== Creating issues ===" -ForegroundColor Cyan

$issues = @(
    @{
        title  = "Create basic UI and task creation"
        body   = @"
## Description
Build the initial HTML/CSS/JS scaffold with a form that lets users add tasks to a visible list.

## Acceptance Criteria
- [ ] `index.html` contains a text input and an "Add Task" button
- [ ] Submitting the form appends a new task to the displayed list
- [ ] The UI is responsive and works on mobile viewports
- [ ] `addTask()` pure function lives in `taskLogic.js` with unit tests
"@
        labels = "feature"
    },
    @{
        title  = "Implement task deletion"
        body   = @"
## Description
Allow users to remove a task from the list by clicking a delete button on each task item.

## Acceptance Criteria
- [ ] Each task row displays a delete/remove button
- [ ] Clicking delete removes the task from state and re-renders the list
- [ ] `deleteTask(tasks, id)` pure function added to `taskLogic.js`
- [ ] Unit tests cover deleting an existing task and deleting a non-existent id
"@
        labels = "feature"
    },
    @{
        title  = "Implement task completion toggle"
        body   = @"
## Description
Let users mark a task as completed (or undo it) by clicking on the task or a checkbox.

## Acceptance Criteria
- [ ] Clicking a task toggles its `completed` property
- [ ] Completed tasks have a visual strikethrough / dimmed style
- [ ] `toggleTask(tasks, id)` pure function added to `taskLogic.js`
- [ ] Unit tests verify toggling on and toggling off
"@
        labels = "feature"
    },
    @{
        title  = "Add task filtering: all / active / completed"
        body   = @"
## Description
Provide filter buttons so users can view all tasks, only active tasks, or only completed tasks.

## Acceptance Criteria
- [ ] Three filter buttons rendered: All, Active, Completed
- [ ] Selecting a filter re-renders the list to show only matching tasks
- [ ] `filterTasks(tasks, status)` pure function added to `taskLogic.js`
- [ ] The active filter button is visually highlighted
- [ ] Unit tests cover each filter mode
"@
        labels = "feature"
    },
    @{
        title  = "Fix: empty tasks can be submitted"
        body   = @"
## Description
Currently `addTask()` accepts empty strings, allowing blank tasks to appear in the list. This should be rejected.

## Acceptance Criteria
- [ ] Submitting an empty or whitespace-only string does **not** add a task
- [ ] A visible validation message is shown to the user
- [ ] `addTask()` returns the original array unchanged for invalid input
- [ ] Unit tests cover empty string, whitespace-only, and valid input
"@
        labels = "bug,high-priority"
    },
    @{
        title  = "Fix mobile layout"
        body   = @"
## Description
On narrow viewports (< 400px) the input and button overlap and the card padding is too tight.

## Acceptance Criteria
- [ ] Form stacks vertically on screens narrower than 480px
- [ ] Card padding adjusts for small screens
- [ ] No horizontal scrollbar appears on any tested mobile viewport
- [ ] Tested on Chrome DevTools (iPhone SE, Pixel 5)
"@
        labels = "bug"
    },
    @{
        title  = "Add input validation messages"
        body   = @"
## Description
Show user-friendly inline messages when input is invalid (e.g., empty task) instead of silently ignoring.

## Acceptance Criteria
- [ ] A styled message appears below the input when validation fails
- [ ] The message disappears when the user starts typing again
- [ ] Accessible: message is linked to the input via `aria-describedby`
"@
        labels = "enhancement"
    },
    @{
        title  = "Add more unit tests"
        body   = @"
## Description
Increase test coverage for all pure functions in `taskLogic.js`.

## Acceptance Criteria
- [ ] Tests exist for `addTask`, `deleteTask`, `toggleTask`, and `filterTasks`
- [ ] Edge cases covered: empty array, invalid id, duplicate calls
- [ ] All tests pass via ``npm test``
- [ ] CI pipeline stays green
"@
        labels = "testing"
    }
)

$num = 1
foreach ($issue in $issues) {
    $labelArgs = @("--label", $issue.labels)
    gh issue create `
        --title $issue.title `
        --body  $issue.body `
        @labelArgs `
        --assignee "@me" `
        --milestone "v1.0"
    Write-Host "  ✔ #$num — $($issue.title)" -ForegroundColor Green
    $num++
}

# ── 4. Close issue #1 ───────────────────────────────────────
Write-Host "`n=== Closing issue #1 ===" -ForegroundColor Cyan
gh issue close 1 --comment "Completed in initial commit"
Write-Host "  ✔ Issue #1 closed" -ForegroundColor Green

Write-Host "`n done" -ForegroundColor Yellow
