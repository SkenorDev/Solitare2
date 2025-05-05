-- Takes mouse input to find which table to insert to
function sort(x, y)
  for i = 1, #xkeys  do
    if x < offsetIndex[xkeys[i]] then
      
      return xkeys[i]
    end
  end

  for i = 1, #ykeys do
    if y < scoreyIndex[ykeys[i]] then
      
      return ykeys[i]
    end
  end
end

 -- Takes card and table
function cardInsert(card, tablename)
 
  local targetStack = state[tablename]
  -- Shouldnt happen
  if not targetStack then 
    return 
  end
   -- If placed into stack that card is already in
if tablename==card.table then
  return
  end
  -- Checks for scoring
  if tablename == "hearts" or tablename == "tiles" or tablename == "pikes" or tablename == "clovers" then
    if card.rank == ranks[#targetStack + 1] and card.suit==tablename then
      save()
      local deleteStack = state[card.table]
      for i = 1, #deleteStack do
        if deleteStack[i] == card then
          table.remove(deleteStack, i)
          break
        end
      end
      card.table = tablename
      table.insert(targetStack, card)
      return
    else
      return
    end
  end

  -- Logic to check if insert is viable
  if #targetStack > 0 then
    if not columnSuitViable(card.suit, targetStack[#targetStack].suit) then
      return
    end
    if not columnRankViable(card.rank, targetStack[#targetStack].rank) then
      return
    end
  else
    if card.rank ~= "King" then return end
  end
save()
-- insert logic
  local deleteStack = state[card.table]
  for i = 1, #deleteStack do
    if deleteStack[i] == card then
      table.remove(deleteStack, i)
      break
    end
  end

  card.table = tablename
  table.insert(targetStack, card)
end



  -- Checks if suit is viable
function columnSuitViable(suit,tablesuit)
  if suit == "clovers" or suit == "pikes" then
    if tablesuit=="hearts" or tablesuit=="tiles" then 
    return true
  else 
    return false
    end 
    else
      if tablesuit=="clovers" or tablesuit=="pikes" then 
        return true
      else 
        return false
      end
      end
  end
  
    -- Checks in number is viable
function columnRankViable(rank,tablerank)
  for i=1,#ranks do
    if rank==ranks[i] then
      rankindex =i
    end
     if tablerank==ranks[i] then
      tablerankindex =i
      end
end
if rankindex-tablerankindex==-1 then
  return true
else
  return false
  end 
  end