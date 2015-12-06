--[[

   @brief A demo screen

]]


require 'Screen'
require 'Scene'
require 'SceneObject'
require 'Vector'
require 'util'

ShooterScreen = {
   character = nil,
   verticalSpeed = 300, -- px/s
   direction = nil,
   tick = 0
}

-- set up inheritance
setmetatable(ShooterScreen,{__index = Screen})

-- constructor
ShooterScreen.__index = ShooterScreen

function ShooterScreen.new()
   local instance = Screen.new()
   setmetatable(instance,ShooterScreen)
   return instance
end

function ShooterScreen:load()
   Screen.load(self) -- super
   self.character = SceneObject.new('resources/sprites/ship.animation.lua',
				    Scene.COLLISION_LEVELS.FRIENDLY);

   self.direction = Vector.new(0,0)
   self.bg = love.graphics.newImage("resources/bg.jpg")
   self.character:setPosition(20, love.graphics.getHeight() / 2 -  self.character:getFrameHeight() / 2)
   self:getScene():addObject(self.character)
end

function ShooterScreen:keypressed(key) 
   if key == "up" then
      self.direction.y = self.direction.y - 1
   elseif key == "down" then
      self.direction.y = self.direction.y + 1
   elseif key == "right" then
      self.direction.x = self.direction.x + 1
   elseif key == "left" then
      self.direction.x = self.direction.x - 1
   end
end

function ShooterScreen:keyreleased(key) 
   if key == "up" then
      self.direction.y = self.direction.y + 1
   elseif key == "down" then
      self.direction.y = self.direction.y - 1
   elseif key == "right" then
      self.direction.x = self.direction.x - 1
   elseif key == "left" then
      self.direction.x = self.direction.x + 1
   end
end

function ShooterScreen:update(dt)
   self.tick  = self.tick + dt
   if self.tick < 0.01 then
      return Screen.update(self, dt) -- super
   end

   self.tick = self.tick * 1000 -- to ms

   local mv = (self.tick * self.verticalSpeed) / 1000

   local geometry = self.character:getGeometry()
   local x = geometry.x
   local y = geometry.y

   if self.direction.y ~= 0 then
      y = Util.clamp(
	 (geometry.y + self.direction.y * mv),
	 0,
	 love.graphics.getHeight() - self.character:getFrameHeight())
   end

   if self.direction.x ~= 0 then
      x = Util.clamp(
	 (geometry.x + self.direction.x * mv),
	 0,
	 love.graphics.getWidth() - self.character:getFrameWidth())
   end

   self.character:setPosition(x, y)

   self.tick = 0
   return Screen.update(self, dt) -- super
end

function ShooterScreen:draw()
   -- Background
   love.graphics.draw(self.bg, 0, 0)
   return Screen.draw(self)
end

return ShooterScreen
