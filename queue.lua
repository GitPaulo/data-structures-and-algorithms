--[[
		Queue
		First In First Out Structure. (Both ways)
]]

local Queue = { };

-- Creates a new instance of the Stack.
Queue.Create = function ( self, arr )
	local queue = arr or { };
	queue.first = 1;
	queue.last = arr and #arr or 1;
	return setmetatable(queue, {
		__index = self;
	});
end

-- Copy to new queue object
Queue.Copy = function ( self )
	local new_queue = Queue:Create();
	for k,v in self:Iterator() do
		new_queue:EnQueueRight(v);
	end
	return new_queue;
end

-- Is Queue Empty?
Queue.IsEmpty = function( self )
	return self.first == self.last and self[self.first] == nil;
end

-- Size of Queue
Queue.Size = function ( self )
	return self.last - self.first;
end

-- Clears all values of the Stack.
Queue.Clear = function ( self )
	for k in pairs(self) do
        self[k] = nil;
    end
    self.first = 1;
    self.last  = 1;
end

-- Add value to the right end
Queue.EnQueueRight =  function ( self, val )
	if not self:IsEmpty() then 
        self.last = self.last + 1;
	end
    self[self.last] = val;
end

-- Remove value from the right end
Queue.DeQueueRight = function ( self )
	if self:IsEmpty() then 
		error("The queue is empty");
	end

	local t = self[self.last];
	self[self.last] = nil;
	self.last = self.last-1;
	
	return t;
end

-- Add value to the left end
Queue.EnQueueLeft = function ( self, val )
    if not self:IsEmpty() then
        self.first = self.first - 1;
	end
    self[self.first] = val;
end

-- Remove value to the left end
Queue.DeQueueLeft = function ( self )
	if self:IsEmpty() then 
		error("The queue is empty");
	end
    
	local t = self[self.first];
	self[self.first] = nil;
	self.first = self.first + 1;
	
	return t;
end

-- Iterator for the Queue data sturcture
Queue.Iterator = function ( self )
    local i = self.first-1;
    local count = 0;
    return function()
        if i < self.last then 
            i = i + 1;
            count = count + 1;
            return count, self[i];
        end
    end
end

-- To string Queue
Queue.ToString = function ( self )
	local str = "{";
	for k,v in self:Iterator() do
		str = str .. v;
        print(k, self:Size())
		if k ~= self:Size() then
			str = str .. ", ";
		end
	end
   
	return str.."}";
end

local q = Queue:Create();
print(q.last)
q:EnQueueRight(1);
q:EnQueueRight(2);
q:EnQueueRight(3);

for k,v in q:Iterator() do
    print(k,v)
end

return Queue;