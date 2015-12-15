--[[
   @brief Container for graphical entities.   

   @class SceneObject
]]

require('SceneObject')
require('Class')

Scene = Class.define({
   init = function(self, width, height)
      self.width = width
      self.height = height   
   end,
      
   -- Members
   objects = {},
   width = 0,
   height = 0
})

Scene.COLLISION_LEVELS = {
   FRIENDLY = 1,
   ENEMY = 2,
   NON_COLLIDABLE = 3
}

function Scene:addObject(sObj)
   table.insert(self.objects, sObj)
end

function Scene:update(dt)
   local i = 1
   while i <= #self.objects do
      local sObj = self.objects[i]
      if (not sObj:isActive() or self:checkOutOfBounds_(sObj)) then
	 table.remove(self.objects, i)
      else
	 i = i + 1
	 self:checkCollisions_(sObj);
	 sObj:update(dt)
      end
   end
end

function Scene:draw()
   local i = 1
   while i <= #self.objects do
      local sObj = self.objects[i]
      sObj:draw()
      i = i + 1
   end
end

-- Private

function Scene:checkOutOfBounds_(sObj)
   -- Checks if an object went ouside of the scene
   local geo = sObj:getGeometry()
   return geo.x + geo.width < 0 
      or geo.x > self.width
      or geo.y + geo.height < 0
      or geo.y > self.height
end

function Scene:checkCollisions_(sObj)
   -- Check the collision with another scene object
   for i, sObj2 in ipairs(self.objects) do
      if (
	 sObj:getCollisionLevel() ~= sObj2:getCollisionLevel() and
	 sObj:isActive() and sObj2:isActive()
      )
      then 
	 if (sObj:collides(sObj2)) then
	    sObj:onCollision(sObj2)
	    sObj2:onCollision(sObj)
	 end
      end
   end
   
   return false;
end


return Scene
