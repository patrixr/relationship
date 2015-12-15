--[[
   @brief Manages a stack of screens to structure the game

   The Screne manager updates, draws and propagates input to the screens
   from the top of the stack to the botton. Screens can prevent the lower screens
   from being processed by setting the blocksDraw, blocksUpdate and blocksInput flags.

   @module ScreenManager
   @singleton
]]
require('Screen')
require('Class')

local instance = nil

ScreenManager = Class.define({
   init = function(self)
      self.screens = {}
   end,
   
   -- Members
   screens = nil,
})
--
-- Returns the screen manager
--
-- @method singleton
-- @memberof ScreenManager
--
function ScreenManager.singleton()
   if (instance == nil) then
      instance = ScreenManager.new()
   end
   return instance
end

--
-- Pushes a screen to the stack
--
-- @method push
-- @memberof ScreenManager
--
function ScreenManager:push(screen)
   screen:load()
   table.insert(self.screens, 1, screen)
end

--
-- Pops a screen from the stack
--
-- @method pop
-- @memberof ScreenManager
--
function ScreenManager:pop()
   local screen = self.screens[1]
   screen:unload()
   table.remove(self.screens, 1)
   return screen
end

-- 
-- On user input (key down)
--
-- @method keypressed
-- @memberof ScreenManager
--
function ScreenManager:keypressed(key)
   local i = 1
   while i <= #self.screens do
      local screen = self.screens[i]
      screen:keypressed(key)
      if screen.blocksInput then 
	 break
      end
      i = i + 1
   end   
end

-- 
-- On user input (key up)
--
-- @method keypressed
-- @memberof ScreenManager
--
function ScreenManager:keyreleased(key)
   local i = 1
   while i <= #self.screens do
      local screen = self.screens[i]
      screen:keyreleased(key)
      if screen.blocksInput then 
	 break
      end
      i = i + 1
   end   
end


--
-- Draws the screens
--
-- @method draw
-- @memberof ScreenManager
--
function ScreenManager:draw()
   local i = 1
   while i <= #self.screens do
      local screen = self.screens[i]
      screen:draw()
      if screen.blocksDraw then 
	 break
      end
      i = i + 1
   end
end

--
-- Updates the screens
--
-- @method update
-- @memberof ScreenManager
--
function ScreenManager:update(dt)
   local i = 1
   while i <= #self.screens do
      local screen = self.screens[i]
      screen:update(dt)
      if screen.blocksUpdate then 
	 break
      end
      i = i + 1
   end
end

return ScreenManager
