--[[
 Class module

 Example usage :
 
 -- We create a class
 local Car = Class.define({
 	init = function(self, brand)
 		self.brand = brand
 	end,
 	numberOfWheels = 4
  })

 -- Define methods
 function Car:honk()
	print("honk " ..  self.numberOfWheels)
	print("honk " ..  self.brand)
 end
 
]]


Class = {}

function Class.define(classDesc)
	local klass = classDesc
	klass.__index = klass

	function klass.new(...)
		local instance = {}
		local ctor = classDesc.init or nil
		setmetatable(instance, klass)
		if ctor then
			ctor(instance, ...)
		end
		return instance
	end

	return klass
end

function Class.extend(superClass, classDesc)	
	local klass = Class.define(classDesc)
	
	setmetatable(klass, { __index = superClass })
	return klass
end

return Class