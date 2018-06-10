--[[
	Vector3d - Vector3d(x,y,z)
]]

local assert = assert
local sqrt, cos, sin, atan2 = math.sqrt, math.cos, math.sin, math.atan2
local Vector3d = { };

Vector3d.Create = function ( self, arr )
	local vector = { };
	vector.x = arr.x or 0;
	vector.y = arr.y or 0;
	vector.z = arr.z or 0;
	return setmetatable( vector, {
		__index = self,
	});
end

Vector3d.IsVector = function ( self, t )
	return type(t) == 'table' and type(t.x) == 'number' and type(t.y) == 'number' and type(t.z) == 'number';
end

Vector3d.Copy = function ( self, t )
	return Vector:Create( { x = self.x, y = self.y, z = self.z } );
end

Vector3d.__add = function ( self, a, b ) 
	assert(isvector(a) and isvector(b), "Addition - One of the arguments was not a Vector3d!");
	return Vector:Create( a.x + b.x, a.y + b.y, a.z + b.z);
end

Vector3d.__sub = function ( self, a, b )
	assert(isvector(a) and isvector(b), "Subtraction - One of the arguments was not a Vector3d!");
	return Vector:Create( a.x - b.x, a.y - b.y, a.z - b.z );
end

Vector3d.__mul = function ( self, a, b )
	if type(a) == "number" then
		return Vector3d:Create(a*b.x, a*b.y, a*b.z );
	elseif type(b) == "number" then
		return Vector3d:Create(b*a.x, b*a.y, b*a.z);
	else
		assert(isvector(a) and isvector(b), "Multiplication - One of the arguments was not a Vector3d!");
		return a.x * b.x + a.y * b.y + a.z * b.z;
	end
end

Vector3d.__div = function ( self, a, b )
	assert(isvector(a) and type(b) == "number", "Division - One of the arguments was not Vector3d or Number!");
	return Vector3d:Create(a.x / b, a.y / b, a.z / b);
end

Vector3d.__idiv = function ( self, a, b )
	assert(isvector(a) and type(b) == "number", "IDivision - On of the arguments was not a Vector3d or Number");
	return Vector3d:Create(a.x // b, a.y // b, a.z // b);
end

Vector3d.__eq = function ( self, a, b )
	return a.x == b.x and a.y == b.y and a.z == b.z;
end

Vector3d.__lt = function ( self, a, b )
	return a:Length() < b:Length();
end

Vector3d.__le = function ( self, a, b )
	return a:Length() <= b:Length();
end

Vector3d.__gt = function ( self, a, b )
	return a:Length() > b:Length();
end

Vector3d.__ge = function ( self, a, b )
	return a:Length() >= b:Length();
end

Vector3d.Length = function ( self )
	return sqrt( self.x*self.x + self.y*self.y + self.z+self.z );
end

Vector3d.Distance = function ( self, a, b )
	assert(isvector(a) and isvector(b), "Distance - wrong argument types Vector3d");
	local dx = a.x - b.x 
	local dy = a.y - b.y
	local dz = a.z - b.z
	return sqrt(dx * dx + dy * dy + dz * dz);
end

Vector3d.Cross = function ( self, a, b )
	return Vector3d:Create( { (a.y*b.z - a.z*b.y), (a.z*b.x - a.x*b.z), (a.x*b.y - a.y*b.x) } );
end





--[[
	Vector3d - Vector3d(x,y,z)
]]

local assert = assert
local sqrt, cos, sin, atan2 = math.sqrt, math.cos, math.sin, math.atan2
local Vector3d = { };

Vector3d.Create = function ( self, arr )
	local vector = { };
	vector.x = arr.x or 0;
	vector.y = arr.y or 0;
	vector.z = arr.z or 0;
	return setmetatable( vector, {
		__index = self,
	});
end

Vector3d.IsVector = function ( self, t )
	return type(t) == 'table' and type(t.x) == 'number' and type(t.y) == 'number' and type(t.z) == 'number';
end

Vector3d.Copy = function ( self, t )
	return Vector:Create( { x = self.x, y = self.y, z = self.z } );
end

Vector3d.__add = function ( self, a, b ) 
	assert(isvector(a) and isvector(b), "Addition - One of the arguments was not a Vector3d!");
	return Vector:Create( a.x + b.x, a.y + b.y, a.z + b.z);
end

Vector3d.__sub = function ( self, a, b )
	assert(isvector(a) and isvector(b), "Subtraction - One of the arguments was not a Vector3d!");
	return Vector:Create( a.x - b.x, a.y - b.y, a.z - b.z );
end

Vector3d.__mul = function ( self, a, b )
	if type(a) == "number" then
		return Vector3d:Create(a*b.x, a*b.y, a*b.z );
	elseif type(b) == "number" then
		return Vector3d:Create(b*a.x, b*a.y, b*a.z);
	else
		assert(isvector(a) and isvector(b), "Multiplication - One of the arguments was not a Vector3d!");
		return a.x * b.x + a.y * b.y + a.z * b.z;
	end
end

Vector3d.__div = function ( self, a, b )
	assert(isvector(a) and type(b) == "number", "Division - One of the arguments was not Vector3d or Number!");
	return Vector3d:Create(a.x / b, a.y / b, a.z / b);
end

Vector3d.__idiv = function ( self, a, b )
	assert(isvector(a) and type(b) == "number", "IDivision - On of the arguments was not a Vector3d or Number");
	return Vector3d:Create(a.x // b, a.y // b, a.z // b);
end

Vector3d.__eq = function ( self, a, b )
	return a.x == b.x and a.y == b.y and a.z == b.z;
end

Vector3d.__lt = function ( self, a, b )
	return a:Length() < b:Length();
end

Vector3d.__le = function ( self, a, b )
	return a:Length() <= b:Length();
end

Vector3d.__gt = function ( self, a, b )
	return a:Length() > b:Length();
end

Vector3d.__ge = function ( self, a, b )
	return a:Length() >= b:Length();
end

Vector3d.Length = function ( self )
	return sqrt( self.x*self.x + self.y*self.y + self.z+self.z );
end

Vector3d.Distance = function ( self, a, b )
	assert(isvector(a) and isvector(b), "Distance - wrong argument types Vector3d");
	local dx = a.x - b.x 
	local dy = a.y - b.y
	local dz = a.z - b.z
	return sqrt(dx * dx + dy * dy + dz * dz);
end

Vector3d.Cross = function ( self, a, b )
	return Vector3d:Create( { (a.y*b.z - a.z*b.y), (a.z*b.x - a.x*b.z), (a.x*b.y - a.y*b.x) } );
end





