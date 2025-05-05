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


