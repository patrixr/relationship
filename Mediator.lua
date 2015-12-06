--[[
   @brief A mediator to allow inter module communication

   @todo improve (async? delayed? replace data param with multiple params?)
]]

local function Channel(name)
   return {
      lastId = 0,
      name = name,
      subscribers = {},

      publish = function (self, data)
	 for i,fn in ipairs(self.subscribers) do
	    if fn then
	       fn(data)
	    end
	 end
      end,

      addSubscriber = function (self, callback)
	 self.lastId = self.lastId + 1
	 self.subscribers[self.lastId] = callback
	 return self.lastId
      end,

      removeSubscriber = function (self, id)
	 self.subscribers[id] = nil
	 return true
      end
   }
end

local _channels = {}

Mediator = {
   --
   -- Subsribe a listener to an event
   -- @return the id of the listner
   --
   subscribe = function(channelName, callback)
      local chan = _channels[channelName]
      if not chan then
	 chan = Channel(channelName)
	 _channels[channelName] = chan
      end

      return chan:addSubscriber(callback)
   end,

   -- 
   -- Unsubscribe a listener from a channel using it's id
   --
   unsubscribe = function (channelName, id)
      local chan = _channels[channelName]
      if not chan then
	 return false
      end

      return chan:removeSubscriber(id)
   end,

   --
   -- Publish data on a channel, all listeners will receive it
   --
   publish = function (channelName, data)
      local chan = _channels[channelName];
      if chan then
	 chan:publish(data)
      end
   end
}

return Mediator
