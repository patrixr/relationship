require 'Config'
require 'ScreenManager'
require 'screens/GameScreen'

local baseScreen = nil

function love.load(arg)
	love.graphics.setBackgroundColor({0, 0, 0})
	love.window.setMode(Config.screen.width, Config.screen.height, {resizable=false, vsync=Config.screen.vsync})
	baseScreen = GameScreen.new()
	ScreenManager.singleton():push(baseScreen)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.push('quit')
	end
end

function love.draw()
	ScreenManager.singleton():draw()
end

function love.update(dt)
	ScreenManager.singleton():update(dt)
end
