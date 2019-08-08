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
   self:_each('keypressed', 'blocksInput', key)
end

--
-- On user input (key up)
--
-- @method keypressed
-- @memberof ScreenManager
--
function ScreenManager:keyreleased(key)
   self:_each('keyreleased', 'blocksInput', key)
end


--
-- Draws the screens
--
-- @method draw
-- @memberof ScreenManager
--
function ScreenManager:draw()
   self:_each('draw', 'blocksDraw', dt)
end

--
-- Updates the screens
--
-- @method update
-- @memberof ScreenManager
--
function ScreenManager:update(dt)
   self:_each('update', 'blocksUpdate', dt)
end


function ScreenManager:_each(funcName, blockProperty, arg)
   local i = 1
   while i <= #self.screens do
      local screen = self.screens[i]
      if screen[blockProperty] then
	      break
      end
      i = i + 1
   end
   while i >= 1 do
      local screen = self.screens[i]
      screen[funcName](screen, arg)
      i = i - 1
   end

end

return ScreenManager
