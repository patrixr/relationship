require('libs/animations/animlove')
require('Vector')
require('util')
require('Class')

local config = require('Config')

SceneObject = Class.extend(LoveAnimation, {
      
   init = function (self, animationFile, opts)
      -- constructor
      LoveAnimation.init(self, animationFile)
      opts = opts or {}
      self.collisionLevel = opts.collisionLevel or Scene.COLLISIONLEVELS.FRIENDLY
      self.vector = opts.vector or Vector.new(0,0)
      self.speed = opts.speed or 300
      self.tick = 0
   end,
      
   collisionLevel = 0,
   active = true,
   vector = nil,
   tick = 0,
   areaBounds = nil,
   speed = 300 -- px/s
   
})

--
-- Detect collision with another scene object
--
function SceneObject:collides(sObj)
   if (sObj.collisionLevel == 0 or sObj.collisionLevel == self.collisionLevel) then
      return false;
   end
   
   local geo = sObj:getGeometry()
   
   return self:intersects(
      geo.x,
      geo.y,
      geo.width,
      geo.height
   )
end

function SceneObject:setMovementBounds(minX, maxX, minY, maxY)
   self.areaBounds = {
      minX = minX,
      maxX = maxX,
      minY = minY,
      maxY = maxY
   }
end

function SceneObject:getVector() 
   return self.vector
end

function SceneObject:setVector(xOrVector, y)
   if type(xOrVector) == "number" and type(y) == "number" then
      self.vector.x = Util.clamp(xOrVector, -1, 1)
      self.vector.y = Util.clamp(y, -1, 1)
   elseif type(xOrVector == "table") then
      self.vector = xOrVector
      self.vector.x = Util.clamp(self.vector.x, -1, 1)
      self.vector.y = Util.clamp(self.vector.y, -1, 1)
   end
end

function SceneObject:draw()
   LoveAnimation.draw(self) -- super

   if (config.debugMode.active and config.debugMode.drawHitboxes) then
      local geometry = self:getGeometry()
      love.graphics.rectangle("line", geometry.x, geometry.y, geometry.width, geometry.height)
   end
end

function SceneObject:update(dt)
   LoveAnimation.update(self, dt)

   local mv = (dt * self.speed)

   local geometry = self:getGeometry()
   local x = geometry.x
   local y = geometry.y

   if self.vector.y ~= 0 then      
      if self.areaBounds then
	 y = Util.clamp(geometry.y + self.vector.y * mv, self.areaBounds.minY, self.areaBounds.maxY)
      else
	 y = geometry.y + self.vector.y * mv
      end
   end

   if self.vector.x ~= 0 then
      if self.areaBounds then
	 x = Util.clamp(geometry.x + self.vector.x * mv, self.areaBounds.minX, self.areaBounds.maxX)
      else
	 x = geometry.x + self.vector.x * mv
      end
   end

   self:setPosition(x, y)
end

function SceneObject:getCollisionLevel()
   return self.collisionLevel
end

function SceneObject:onCollision(otherObj)
   -- @TODO
end

function SceneObject:isActive()
   return self.active
end

return SceneObject
