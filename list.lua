--[[
List 
]]

local List = { };

-- Create new instance of the List
List.Create = function ( self, a )
	local list = { };
	list.array = a or { };
	return setmetatable( list, {
		__index = List;
	});
end

-- Get Size
List.Size = function ( self )
	return #self.array;
end

-- Is the array empty
List.IsEmpty = function ( self )
	return #self.array == 0;
end

-- List to Array
List.ToArray = function ( self )
	return self.array;
end

-- Contains a value
List.Contains = function ( self, value )
	for k, v in pairs( self.array ) do
		if v == value then
			return true, k;
		end
	end
	return false, nil;
end

-- Index of a value
List.IndexOf = function ( self, value )
	local _, k = self:Contains(value);
	return k;
end

-- Copy List to a new instance
List.Copy = function ( self )
	local temp = {}
	for k, v in pairs(self.array) do
		temp[k] = v;
	end
	return List:Create(temp);
end

-- Insert at front of list
List.InsertFront = function ( self, value )
	self.array[self:Size() + 1] = value;
end

-- Insert at front of list
List.RemoveFront = function ( self, value )
	self.array[self:Size()] = nil;
end

-- Insert at pos
List.Insert = function ( self, pos, value )
	local n = self:Size();
	if pos > n + 1 or pos < 1 then 
		error("Out of bounds removal.");
	end

	if pos == n + 1 then
		self:InsertFront(value);
	end

	for i=n, pos, -1 do
		self.array[i+1] = self.array[i];
	end

	self.array[pos] = value;
end

-- Remove at pos
List.Remove = function ( self, pos )
	local n = self:Size();
	if pos <= 0 and pos > n then
		error("Out of bounds removal.");
	end

	self.array[pos] = nil;

	for i=pos, n-1, 1 do
		self.array[i] = self.array[i+1];
	end

	self.array[n] = nil;
end

-- Iterator for the Queue data sturcture
List.Iterator = function ( self, modify )
	local i = 0;
	return function()
		if i < self:Size() then 
			i = i + 1;
			return i, self.array[i];
		end
	end
end

-- To string List
List.ToString = function ( self )
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

local l = List:Create({1,2,3});
l:Insert(2,11);
l:Remove(2);
print(l:ToString());

return List;