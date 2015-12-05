Util = {
   clamp = function (v, min, max)
      if (v < min) then 
	 return min
      elseif (v > max) then 
	 return max
      else 
	 return v
      end
   end,

   dumpObject = function (obj)
      for key in pairs(obj) do
	 print(key .. " : " .. tostring(obj[key]))
      end
   end
}


return Util
