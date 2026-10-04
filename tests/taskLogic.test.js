const { describe, it } = require("node:test");
const assert = require("node:assert/strict");
const { addTask, toggleTask } = require("../taskLogic");

describe("addTask", () => {
  it("should return a new array with one task when starting from an empty list", () => {
    const result = addTask([], "Read chapter 5");

    assert.equal(result.length, 1);
    assert.deepStrictEqual(result[0], {
      id: 1,
      text: "Read chapter 5",
      completed: false,
    });
  });

  it("should append to existing tasks with an incremented id", () => {
    const existing = [{ id: 1, text: "Buy notebooks", completed: false }];
    const result = addTask(existing, "Submit assignment");

    assert.equal(result.length, 2);
    assert.equal(result[1].id, 2);
    assert.equal(result[1].text, "Submit assignment");
    assert.equal(result[1].completed, false);
  });

  it("should not mutate the original array", () => {
    const original = [{ id: 1, text: "Attend lecture", completed: false }];
    const result = addTask(original, "Review notes");

    assert.equal(original.length, 1);
    assert.equal(result.length, 2);
    assert.notStrictEqual(result, original);
  });
});

describe("toggleTask", () => {
  it("should toggle completed to true and back to false", () => {
    const tasks = [{ id: 1, text: "Write essay", completed: false }];

    const toggled = toggleTask(tasks, 1);
    assert.equal(toggled[0].completed, true);

    const toggledBack = toggleTask(toggled, 1);
    assert.equal(toggledBack[0].completed, false);
  });

  it("should not mutate the original array and should leave other tasks unchanged", () => {
    const tasks = [
      { id: 1, text: "Task A", completed: false },
      { id: 2, text: "Task B", completed: false },
    ];

    const result = toggleTask(tasks, 2);

    // original unchanged
    assert.equal(tasks[1].completed, false);
    assert.notStrictEqual(result, tasks);

    // only target task toggled
    assert.equal(result[0].completed, false);
    assert.equal(result[1].completed, true);
    assert.equal(result[0].text, "Task A");
  });
});
