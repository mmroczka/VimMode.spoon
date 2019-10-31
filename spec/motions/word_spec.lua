local Buffer = require("lib/buffer")
local Selection = require("lib/selection")
local Word = require("lib/motions/word")

describe("Word", function()
  describe("#getRange", function()
    it("handles simple words", function()
      local selection = Selection:new(0, 0)
      local buffer = Buffer:new("cat dog mouse", selection)
      local word = Word:new()

      assert.are.same(
        {
          start = 0,
          finish = 5,
          mode = "exclusive",
          direction = "characterwise"
        },
        word:getRange(buffer)
      )
    end)

    it("stops on punctuation", function()
      local selection = Selection:new(0, 0)
      local buffer = Buffer:new("ab-cd-ef", selection)
      local word = Word:new()

      assert.are.same(
        {
          start = 0,
          finish = 3,
          mode = "exclusive",
          direction = "characterwise"
        },
        word:getRange(buffer)
      )
    end)
  end)

  describe("#getMovements", function()
    it("returns the key sequence to move by word", function()
      local selection = Selection:new(0, 0)
      local buffer = Buffer:new("cat dog mouse", selection)
      local word = Word:new()

      assert.are.same(
        {
          {
            modifiers = { 'alt' },
            character = 'right'
          }
        },
        word:getMovements(buffer)
      )
    end)
  end)
end)