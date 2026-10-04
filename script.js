/* script.js — DOM wiring only; all logic lives in taskLogic.js */

(function () {
  "use strict";

  const { addTask } = window.TaskLogic;

  // State
  let tasks = [];

  // DOM refs
  const form = document.getElementById("task-form");
  const input = document.getElementById("task-input");
  const list = document.getElementById("task-list");
  const emptyState = document.getElementById("empty-state");

  /**
   * Re-render the entire task list from state.
   */
  function render() {
    list.innerHTML = "";

    tasks.forEach((task) => {
      const li = document.createElement("li");
      li.className = "task-item";
      li.dataset.id = task.id;

      li.innerHTML = `
        <span class="task-item__indicator" aria-hidden="true"></span>
        <span class="task-item__text">${escapeHTML(task.text)}</span>
      `;

      list.appendChild(li);
    });

    emptyState.classList.toggle("empty-state--hidden", tasks.length > 0);
  }

  /**
   * Basic HTML-escape to prevent XSS when rendering user input.
   */
  function escapeHTML(str) {
    const div = document.createElement("div");
    div.textContent = str;
    return div.innerHTML;
  }

  // Event listeners
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    tasks = addTask(tasks, input.value);
    input.value = "";
    input.focus();
    render();
  });

  // Initial render
  render();
})();
