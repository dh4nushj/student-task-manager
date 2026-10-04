/**
 * taskLogic.js — Pure functions for task management.
 * No DOM code lives here.
 */

/**
 * Add a task to the list.
 * @param {Array} tasks  – current task array (not mutated)
 * @param {string} text  – task description (empty strings allowed)
 * @returns {Array}       – new array with the appended task
 */
function addTask(tasks, text) {
  const id = tasks.length === 0 ? 1 : Math.max(...tasks.map((t) => t.id)) + 1;
  return [...tasks, { id, text, completed: false }];
}

// Dual export: Node (module.exports) / Browser (window)
if (typeof module !== "undefined" && module.exports) {
  module.exports = { addTask };
} else {
  window.TaskLogic = { addTask };
}
