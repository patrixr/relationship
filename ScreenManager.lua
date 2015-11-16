--[[
@brief	Manages a stack of screens to structure the game

@module ScreenManager
@singleton
]]
require('Screen')

ScreenManager = {
	-- Members
	screens = {},
}
ScreenManager.__index = ScreenManager

local instance = nil

--
-- Returns the screen manager
--
-- @method singleton
-- @memberof ScreenManager
--
function ScreenManager.singleton()
	if (instance == nil) then
		instance =  {}
		setmetatable(instance, ScreenManager)
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
	table.remove(self.screens, 1)
	return screen
end

--
-- Draws the screens
--
-- @method draw
-- @memberof ScreenManager
--
function ScreenManager:draw()
	local i = 1
	while i < #self.screens do
		local screen = self.screens[i]
		screen:draw()
		if screen.blocksDraw then 
			break
		end
	end
end

--
-- Updates the screens
--
-- @method update
-- @memberof ScreenManager
--
function ScreenManager:update()
	local i = 1
	while i < #self.screens do
		local screen = self.screens[i]
		screen:update()
		if screen.blocksUpdate then 
			break
		end
	end
end