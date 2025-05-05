function drawUi()
   -- green rectangles
  love.graphics.setColor(0.2, 0.9, 0.2, 1)
  love.graphics.rectangle("fill", 0, 0, 100, screenHeight)
  love.graphics.rectangle("fill", screenWidth - 100, 0, 100, screenHeight)
  -- deck button
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(back, -20, 0, 0, 0.2, 0.2)
  -- make score spots
  love.graphics.rectangle("line", 880, 40, 65, 90)
  love.graphics.print("heart", 900, 80)
  love.graphics.rectangle("line", 880, 140, 65, 90)
  love.graphics.print("diamond", 900, 180)
  love.graphics.rectangle("line", 880, 240, 65, 90)
  love.graphics.print("clubs", 900, 280)
  love.graphics.rectangle("line", 880, 340, 65, 90)
  love.graphics.print("spades", 900, 380)
  -- Make the buttons in the bottom left
  local resetX, resetY, resetW, resetH = 10, screenHeight - 60, 80, 30
  local undoX, undoY, undoW, undoH = 10, screenHeight - 100, 80, 30
  love.graphics.setColor(0.3, 0.3, 0.3)
  love.graphics.rectangle("fill", undoX, undoY, undoW, undoH)
  love.graphics.rectangle("fill", resetX, resetY, resetW, resetH)
  love.graphics.setColor(1, 1, 1)
  love.graphics.printf("Undo", undoX, undoY + 8, undoW, "center")
  love.graphics.printf("Reset", resetX, resetY + 8, resetW, "center")
  --check in win condition is met and if so print wincon
   if wincon == true then
    love.graphics.setColor(1, 1, 1)
    
    love.graphics.printf("You Win!", 0, screenHeight / 2 - 20, screenWidth, "center")
  end
  end