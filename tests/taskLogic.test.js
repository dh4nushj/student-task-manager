const { describe, it } = require("node:test");
const assert = require("node:assert/strict");
const { addTask } = require("../taskLogic");

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
