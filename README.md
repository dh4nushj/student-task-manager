# Student Task Manager

A lightweight, zero-dependency task manager built for students to organise assignments, deadlines, and study goals — all in vanilla HTML, CSS, and JavaScript.

## ✨ Features

- **Add tasks** — quickly capture what you need to do
- **Live task list** — see every task rendered instantly
- **Responsive UI** — works on desktop, tablet, and mobile
- **No build step** — open `index.html` in any browser and go

## 🛠 Tech Used

| Layer       | Technology                               |
| ----------- | ---------------------------------------- |
| Markup      | HTML 5                                   |
| Styling     | Vanilla CSS (dark glassmorphism theme)   |
| Logic       | Vanilla JavaScript (ES6+)               |
| Testing     | Node.js built-in `node:test` + `assert` |
| CI          | GitHub Actions                           |

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-org>/student-task-manager.git
   cd student-task-manager
   ```
2. Open `index.html` in your browser — no install or build required.

## 🧪 How to Run Tests

```bash
npm test
```

This executes all test files inside `tests/` using Node's built-in test runner (Node 18+).

## 👥 Team Members

| Name | USN | Role | 
|------|-----|------|
| Dhanush J | 1RF24IS030 | Project Lead and Lead Developer (repository setup, application, CI workflow) |
| Dhruv Ajay Hangal | 1RF24IS031 | Project Manager (issues, milestones, project board)  |
| Jeevan V | 1RF24IS045 | QA / Testing (unit tests, code review) |
| Dharshan K | 1RF24IS048 | Documentation and Presentation (README, PPT, report) |

## ⚙️ GitHub Workflow

The project uses **GitHub Actions** for continuous integration.

- **Workflow file:** `.github/workflows/ci.yml`
- **Triggers:** `push` and `pull_request` to the `main` branch
- **Steps:** Checkout → Setup Node 20 → `npm test`

## 🔮 Future Improvements

- [ ] Delete tasks
- [ ] Mark tasks as complete
- [ ] Filter by status (all / active / completed)
- [ ] Input validation (reject empty task text)
- [ ] Persist tasks in `localStorage`
- [ ] Due-date support with calendar picker
- [ ] Drag-and-drop reordering
