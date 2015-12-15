--[[

   @brief A demo screen

]]


require('Screen')
require('Scene')
require('SceneObject')
require('Vector')
require('util')

ShooterScreen = Class.extend(Screen, {
   character = nil,
   verticalSpeed = 300, -- px/s
   direction = nil,
})

function ShooterScreen:load()
   Screen.load(self) -- super
   self.character = SceneObject.new(
      'resources/sprites/ship.animation.lua', {
	 collisionLevel = Scene.COLLISION_LEVELS.FRIENDLY
   });
   
   self.direction = Vector.new(0,0)
   self.bg = love.graphics.newImage("resources/bg.jpg")
   self.character:setPosition(20, love.graphics.getHeight() / 2 -  self.character:getFrameHeight() / 2)
   self.character:setMovementBounds(0, love.graphics.getWidth(), 0, love.graphics.getHeight())
   self:getScene():addObject(self.character)
end

function ShooterScreen:keypressed(key) 
   local direction = self.character:getVector()
   if key == "up" then
      self.character:setVector(direction.x, direction.y - 1)
   elseif key == "down" then
      self.character:setVector(direction.x, direction.y + 1)
   elseif key == "right" then
      self.character:setVector(direction.x + 1, direction.y)
   elseif key == "left" then
      self.character:setVector(direction.x - 1, direction.y)
   end
end

function ShooterScreen:keyreleased(key) 
   local direction = self.character:getVector()
   if key == "up" then
      self.character:setVector(direction.x, direction.y + 1)
   elseif key == "down" then
      self.character:setVector(direction.x, direction.y - 1)
   elseif key == "right" then
      self.character:setVector(direction.x - 1, direction.y)
   elseif key == "left" then
      self.character:setVector(direction.x + 1, direction.y)
   end
end

function ShooterScreen:update(dt)
   return Screen.update(self, dt) -- super
end

function ShooterScreen:draw()
   -- Background
   love.graphics.draw(self.bg, 0, 0)
   return Screen.draw(self)
end

return ShooterScreen
