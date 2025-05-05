-- Nathan Skinner
-- CMPM 121 
-- 4-28-2025

io.stdout:setvbuf("no")
require "playarea"
require "vector"
require "card"
require "sort"
require "toDraw"
require "history"

function love.load()
  -- Set beginning settings
  math.randomseed(os.time())
  screenWidth = 960
  screenHeight = 960
  love.window.setMode(screenWidth, screenHeight)
  love.graphics.setBackgroundColor(0.2, 0.7, 0.2, 1)
  back = love.graphics.newImage("Assets/back.png")

  -- Make table for what's grabbed
  grabbed = {}

  -- Create offsets for each card's position 
  offsetIndex = {
    ["draw"] = 20,
    ["one"] = 200,
    ["two"] = 300,
    ["three"] = 400,
    ["four"] = 500,
    ["five"] = 600,
    ["six"] = 700,
    ["seven"] = 800,
  }
  
  --Set up tables to help with for loops in the future
  xkeys = { "one", "two", "three", "four", "five", "six", "seven" }
  drawable = { "draw", "one", "two", "three", "four", "five", "six", "seven", "hearts", "tiles", "clovers", "pikes" }
  tosave = { "draw_done", "draw", "one", "two", "three", "four", "five", "six", "seven", "hearts", "tiles", "clovers", "pikes" }
  scoreyIndex = { ["hearts"] = 130, ["tiles"] = 230, ["clovers"] = 330, ["pikes"] = 430}
  ykeys = { "hearts", "tiles", "clovers", "pikes" }
  wincon = false
  start()
end

function love.update()
  moveCards()
end

function love.draw()
  drawUi()
  --Go through all tables where cards should be visible
  for f = #drawable, 1, -1 do
    local stack = state[drawable[f]]
    for i = 1, #stack do
      stack[i]:draw()
    end
  end
  --Make cards follow mouse
  for i = #grabbed, 1, -1 do
    grabbed[i]:draw()
  end
end

function love.mousepressed(x, y, button)
  --Insert cards into grabbed
  for f = #drawable, 1, -1 do
    local stack = state[drawable[f]]
    for i = 1, #stack do
      -- If in these should not be grabbed in stacks
      if drawable[f] == "draw" or drawable[f] == "hearts" or drawable[f] == "tiles" or drawable[f] == "clovers" or drawable[f] == "pikes" then  
        if stack[i]:isMouseOver(x, y) == true then
          table.insert(grabbed, stack[#stack])
        end
      else
         -- If in these should be grabbed in stacks
        if stack[i]:isMouseOver(x, y) and stack[i].face == true then
          for j = i, #stack do
            table.insert(grabbed, stack[j])
          end
        end
      end
    end
  end
end

function love.mousereleased(x, y, button)
  -- Current gets name of table player is attempting to drag into than insert
  for i = 1, #grabbed do
    current = sort(love.mouse.getX(), love.mouse.getY())
    cardInsert(grabbed[i], current)
  end 
  -- Empty out grabbed
  grabbed = {}

  -- Draw 3 button
  if love.mouse.getX() < 100 and love.mouse.getY() < 150 then
    drawthree()
  end

  -- Undo button
  if x >= 10 and x <= 90 and y >= screenHeight - 100 and y <= screenHeight - 70 then
    undo()
    return
  -- Reset button
  elseif x >= 10 and x <= 90 and y >= screenHeight - 60 and y <= screenHeight - 30 then
    start()
    return
  end
  --Check if player wins then update cards
  checkWin()
  cardPositionUpdate()
end

function moveCards()
  -- If card is grabbed than move with mouse cursor
  for i = 1, #grabbed do
    local card = grabbed[i]
    card.position = Vector(love.mouse.getX() - 25, love.mouse.getY() - 25)
  end
end

function shuffle(tbl)
  -- randomize cards
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
end

function drawthree()
  -- If deck is empty, then empty out draw_done
  if #deck == 0 then
    deck = state.draw_done
    state.draw_done = {}
  end

  -- Empty out draw into draw_done
  for i = #state.draw, 1, -1 do
    table.insert(state.draw_done, state.draw[i])
  end
  state.draw = {}

  -- Draw 3 cards from the top of the deck
  local drawCount = math.min(3, #deck)
  for i = 1, drawCount do
    local card = deck[1]
    card.table = "draw"
    table.insert(state.draw, card)
    table.remove(deck, 1)
  end
end

function start()
  -- Make game state
  state = play()

  -- Make table for history of game state
  history = {}

  -- Create cards
  deck = {}
  suits = { "hearts", "tiles", "clovers", "pikes" }
  ranks = { "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King" }

  for _, suit in ipairs(suits) do
    for _, rank in ipairs(ranks) do
      local imagePath = "Assets/" .. suit .. "_" .. rank .. ".png"
      local image = love.graphics.newImage(imagePath)
      local card = CardClass:new(suit, rank, image)
      table.insert(deck, card)
    end
  end

  shuffle(deck)

  -- Draw cards into tables
  for i = 1, 7 do
    local stack = state[xkeys[i]]
    for f = 1, i do
      table.insert(stack, deck[1])
      deck[1].face = false
      deck[1].table = xkeys[i]
      table.remove(deck, 1)
    end
  end

  cardPositionUpdate()
end

-- Will update position based on table that contains card
function cardPositionUpdate()
  for f = #drawable, 1, -1 do
    local stack = state[drawable[f]]
    for i = #stack, 1, -1 do
      stack[i]:findPosition()
    end
  end
  checkFace()
end

-- Will flip a card if in front
function checkFace()
  for f = #xkeys, 1, -1 do
    local stack = state[xkeys[f]]
    if #stack == 0 then
      return
    end
    stack[#stack].face = true
  end
end

function checkWin()
   -- if there are 52 cards in score spots you win!
  if #state.hearts + #state.tiles + #state.clovers + #state.pikes >= 52 then
    wincon = true
  end
end

function save(orig)
   -- Makes an array of game state history
  table.insert(history, deepCopyPlayArea(state))
end

function undo()
   -- Become last game state and delete previous from history (thank god no redo feature)
   -- Didnt add undo logic to draw button because could be used to cheat however there are still ways to exploit the undo button
  if #history > 0 then
    state = table.remove(history)
    cardPositionUpdate()
  end
end
