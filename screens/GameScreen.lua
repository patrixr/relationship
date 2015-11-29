require 'Screen'
require 'SceneObject'

GameScreen = {
	character = nil
}

-- set up inheritance
setmetatable(GameScreen,{__index = Screen})

-- constructor
GameScreen.__index = GameScreen

function GameScreen.new()
	local instance = Screen.new()
	setmetatable(instance,GameScreen)
	return instance
end

function GameScreen:load()
	Screen.load(self) -- super
	self.character = SceneObject.new('resources/sprites/animation1.lua', 1);
	self:getScene():addObject(self.character)
end

return GameScreen
