play = {}

metatable = {
   __call = function(self)
    local play = {
    draw_done = {},
    draw = {},
    hearts = {},
    tiles = {},
    clovers = {},
    pikes = {},
    one = {},
    two = {},
    three = {},
    four = {},
    five  = {},
    six = {},
    seven  = {}
   
    }
    setmetatable(play, metatable)
    return play
     end
}

setmetatable(play, metatable)
  -- Make state stacks to put in history array
function deepCopyPlayArea(orig)
  local copy = {}
  for key, stack in pairs(orig) do
    copy[key] = {}
    for i, card in ipairs(stack) do
      local newCard = {}
      for k, v in pairs(card) do
        newCard[k] = v
      end
      setmetatable(newCard, getmetatable(card)) -- preserve class methods
      table.insert(copy[key], newCard)
    end
  end
  return copy
end