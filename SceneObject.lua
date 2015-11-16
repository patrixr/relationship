require('animlove')

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

function SceneObject:getCollisionLevel()
	return self.collisionLevel
end

function SceneObject:onCollision(otherObj)
	-- @TODO
end

function SceneObject:isActive()
	return self.active
end