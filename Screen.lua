--[[
@brief 	Represents a screen of the game (e.g a game screen, a level, a menu screen, ...) \
		They can be stacked one on top of each others through the ScreenManager \
		Each screen contains a scene, which is the graphical representation of the screen

@class	Screen
]]

require('Scene')

Screen = {
	-- Members
	scene = nil,
	blocksDraw = true,
	blocksUpdate = true,
	blocksInput = true,
	width = 0,
	height = 0
}
Screen.__index = Screen

--
-- Creates a new screen
--
-- @method new
-- @param {Scene} opts The scene to use. Can be nil
-- @param {table} [opts] Object to be set by using the different attributes. Can be nil
-- @param {boolean} [options.blocksDraw] True if screen prevents lower screens to draw
-- @param {boolean} [options.blocksUpdate] True if screen prevents lower screens to update
-- @memberof Screen
--
function Screen.new(scene, opts)
	local instance =  {}
	opts = opts or {}
	setmetatable(instance, Screen)
	instance.scene = scene or Scene.new(love.graphics.getWidth(), love.graphics.getHeight())
	instance.blocksDraw = opts.blocksDraw or instance.blocksDraw;
	instance.blocksUpdate = opts.blocksUpdate or instance.blocksUpdate;
	return instance
end

--
-- load
--
-- @method load
-- @memberof Screen
--
function Screen:load()
	print("Screen:load()")
end

--
-- unload, called before destruction of the screen
--
-- @method unload
-- @memberof Screen
--
function Screen:unload()
	print("Screen:unload()")
end

--
-- Callback for user input (key down). To be overridden
--
-- @method keypressed
-- @memberof Screen
--
function Screen:keypressed(key)
   -- empty
end

--
-- Callback for user input (key up). To be overridden
--
-- @method keyreleased
-- @memberof Screen
--
function Screen:keyreleased(key)
   -- empty
end

--
-- Returns the scene of the screen
--
-- @returns scene
-- @method getScene
-- @memberof Screen
--
function Screen:getScene()
	return self.scene
end

--
-- Draws the screen
--
-- @method draw
-- @memberof Screen
--
function Screen:draw()
	self.scene:draw()
end

--
-- Updates the screen
--
-- @method update
-- @memberof Screen
--
function Screen:update(dt)
	self.scene:update(dt)
end

return Screen
