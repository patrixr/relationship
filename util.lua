Util = {
   --
   -- Limits a value to a set range
   --
   clamp = function (v, min, max)
      if (v < min) then
	 return min
      elseif (v > max) then
	 return max
      else
	 return v
      end
   end,

   --
   -- Prints all the keys of an object
   --
   dumpObject = function (obj)
      for key in pairs(obj) do
	      print(key .. " : " .. tostring(obj[key]))
      end
   end
}


return Util
