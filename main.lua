require 'ScreenManager'

function love.load(arg)
   print("Setting up our humble game")

   local config = require('Config')

   love.graphics.setBackgroundColor(config.screen.background or {0, 0, 0})
   --
   -- Setup
   --
   love.window.setMode(
      config.screen.width,
      config.screen.height,
      {
	 resizable = false,
	 vsync = config.screen.vsync
   })

   local baseScreen = require(config.startup.screen)
   ScreenManager.singleton():push(baseScreen.new())
end

function love.keypressed(key)
   if key == 'escape' then
      love.event.push('quit')
   end
   ScreenManager.singleton():keypressed(key)
end

function love.draw()
   ScreenManager.singleton():draw()
end

function love.update(dt)
   ScreenManager.singleton():update(dt)
end
