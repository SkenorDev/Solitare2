require "vector"

CardClass = {}
CardClass.__index = CardClass

function CardClass:new(suit, rank,image)
  local card = setmetatable({}, CardClass)
  card.suit = suit
  card.rank = rank
  card.position = Vector(-100, 0)
  card.image = image
  card.face=true
  card.size = Vector(65, 90)
  card.scale = 0.1
  card.table = nil
  backImage = love.graphics.newImage("Assets/back.png")
  return card
end


function CardClass:draw()
  if self.face == true then
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.image, self.position.x, self.position.y, 0, self.scale, self.scale)
 else
    love.graphics.setColor(1, 1, 1)
   love.graphics.draw(backImage, self.position.x-16, self.position.y, 0, self.scale*1.40, self.scale*1.3)
  end 
end

function CardClass:isMouseOver(mx, my)
  return mx >= self.position.x and mx <= self.position.x + self.size.x and
         my >= self.position.y and my <= self.position.y + self.size.y
end

function CardClass:findPosition()
  if self.table == nil then
    return
    end
  
  local stack = state[self.table]
if self.table=="hearts" or self.table=="tiles" or self.table=="pikes" or self.table=="clovers"  then
  x=880
  y= scoreyIndex[self.table]-90
  self.position = Vector(x,y)
  return
  end 
   if self.table =="draw" then
    x=offsetIndex[self.table]
    for i=1, #stack do
      if self==stack[i] then
      pos = i
      end
    end
    y = 180+((pos - 1) * 120)
  else
   for i=1, #stack do
     x=offsetIndex[self.table]-80
      if self==stack[i] then
      pos = i
      end
    end
   y = 60+((pos - 1) * 60)
    end
     self.position = Vector(x,y)
  end