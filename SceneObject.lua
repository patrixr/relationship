require 'libs/animations/animlove'

local config = require('Config')

SceneObject = {
	collisionLevel = 0,
	active = true
}

-- set up inheritance
setmetatable(SceneObject,{__index = LoveAnimation})

-- constructor
SceneObject.__index = SceneObject
function SceneObject.new(animationFile, collisionLevel)
	local instance = LoveAnimation.new(animationFile)
	setmetatable(instance,SceneObject)
	instance.collisionLevel = collisionLevel
	return instance
end

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

function SceneObject:draw()
   LoveAnimation.draw(self) -- super

   if (config.debugMode.active and config.debugMode.drawHitboxes) then
      local geometry = self:getGeometry()
      love.graphics.rectangle("line", geometry.x, geometry.y, geometry.width, geometry.height)
   end

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
