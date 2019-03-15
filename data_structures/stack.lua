--[[
Stack
First In Last Out Structure.
]]

local Stack = { };

-- Creates a new instance of the Stack.
Stack.Create = function ( self, arr )
	local stack = arr or { };
	return setmetatable(stack, {
		__index = self;
	});
end

-- Size of Stack
Stack.Size = function ( self )
	return #self;
end

-- Copy to new Stack Object
Stack.Copy = function ( self )
	local new_stack = { };
	for k,v in self:Iterator() do
		new_stack:Push(v);
	end
	return new_stack;
end

-- Clears all values of the Stack.
Stack.Clear = function ( self )
	for k in pairs(self) do
		self[k] = nil;
	end
end

Stack.IsEmpty = function ( self )
	return #self == 0;
end

-- Pushes a new value to the top of the stack
Stack.Push = function ( self, ... )
	for _, v in pairs({...}) do
		self[#self+1] = v;
	end
end

-- Removes a value of the stack.
Stack.Pop = function ( self )
	if self:IsEmpty() then 
		error("Stack is empty!"); 
	end

	local poped = self[#self];
	self[#self] = nil;

	return poped;
end

-- Returns the top value of the stack.
Stack.Peek = function ( self )
	return self[#self];
end

-- Stack iterator. Pass modify as true to remove value on pass through
Stack.Iterator = function ( self, modify )
	local i = #self;
	local count = 0;
	return function()
		if i > 0 then 
			i = i - 1;
			count = count + 1;
			return count, modify and self:Pop() or self[i+1];
		end
	end
end

-- To String Stack
Stack.ToString = function ( self )
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

return Stack;