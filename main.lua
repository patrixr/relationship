require 'ScreenManager'
require 'Config'
require 'util'

function love.load(arg)

   print("[love.load] Setting up our humble game")

   love.graphics.setBackgroundColor(Config.screen.background or {0, 0, 0})
   --
   -- Setup
   --
   love.window.setMode(
      Config.screen.width,
      Config.screen.height,
      {
	 resizable = false,
	 vsync = Config.screen.vsync
   })

   local baseScreen = require(Config.startup.screen)
   ScreenManager.singleton():push(baseScreen.new())
end

function love.keypressed(key)
   if key == 'escape' then
      love.event.push('quit')
   end
   ScreenManager.singleton():keypressed(key)
end

function love.keyreleased(key)
   ScreenManager.singleton():keyreleased(key)
end

function love.draw()
   ScreenManager.singleton():draw()

   if Config.debugMode.active and Config.debugMode.drawHitboxes then
      love.graphics.setColor({255,255,255})
      love.graphics.print("FPS : " .. tostring(love.timer.getFPS()), 10, 10)
   end
end

function love.update(dt)
   ScreenManager.singleton():update(dt)
end
