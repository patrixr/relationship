Util = {
   clamp = function (v, min, max)
      if (v < min) then 
	 return min
      elseif (v > max) then 
	 return max
      else 
	 return v
      end
   end
}


return Util
