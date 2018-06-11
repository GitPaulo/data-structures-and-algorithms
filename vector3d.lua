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

-- Is it a vector?
Vector3d.IsVector = function ( self, t )
	return type(t) == 'table' and type(t.x) == 'number' and type(t.y) == 'number' and type(t.z) == 'number';
end

-- Return a copy of the vector.
Vector3d.Copy = function ( self, t )
	return Vector:Create( { x = self.x, y = self.y, z = self.z } );
end

-- Returns elements of vector
Vector3d.Unpack = function ( self )
	return self.x, self.y, self.z;
end

-- Addition meta data
Vector3d.__add = function ( self, a, b ) 
	assert(isvector(a) and isvector(b), "Addition - One of the arguments was not a Vector3d!");
	return Vector:Create( a.x + b.x, a.y + b.y, a.z + b.z);
end

-- Subtraction meta data
Vector3d.__sub = function ( self, a, b )
	assert(isvector(a) and isvector(b), "Subtraction - One of the arguments was not a Vector3d!");
	return Vector:Create( a.x - b.x, a.y - b.y, a.z - b.z );
end

-- Multiplication meta data
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

-- Division meta data
Vector3d.__div = function ( self, a, b )
	assert(isvector(a) and type(b) == "number", "Division - One of the arguments was not Vector3d or Number!");
	return Vector3d:Create(a.x / b, a.y / b, a.z / b);
end

-- IDivision meta data
Vector3d.__idiv = function ( self, a, b )
	assert(isvector(a) and type(b) == "number", "IDivision - On of the arguments was not a Vector3d or Number");
	return Vector3d:Create(a.x // b, a.y // b, a.z // b);
end

-- Equality meta data
Vector3d.__eq = function ( self, a, b )
	return a.x == b.x and a.y == b.y and a.z == b.z;
end

-- Less than meta data
Vector3d.__lt = function ( self, a, b )
	return a:Length() < b:Length();
end

-- Lest than equal meta data
Vector3d.__le = function ( self, a, b )
	return a:Length() <= b:Length();
end

-- Greater than meta data
Vector3d.__gt = function ( self, a, b )
	return a:Length() > b:Length();
end

-- Greater than equal meta data
Vector3d.__ge = function ( self, a, b )
	return a:Length() >= b:Length();
end

-- Returns a negative vector
Vector3d.__unm = function ( self, a )
	return Vector3d:Create(-a.x, -a.y, -a.z);
end

-- Returns the |v|, length, of the vector
Vector3d.Length = function ( self )
	return sqrt( self.x*self.x + self.y*self.y + self.z+self.z );
end

-- Distance between two vectors.
Vector3d.Distance = function ( self, a, b )
	assert(isvector(a) and isvector(b), "Distance - wrong argument types Vector3d");
	local dx = a.x - b.x 
	local dy = a.y - b.y
	local dz = a.z - b.z
	return sqrt(dx * dx + dy * dy + dz * dz);
end

-- Cross between two vectors.
Vector3d.Cross = function ( self, a, b )
	return Vector3d:Create( { (a.y*b.z - a.z*b.y), (a.z*b.x - a.x*b.z), (a.x*b.y - a.y*b.x) } );
end

-- Dot between two vectors
Vector3d.Dot = function ( self, a, b )
	return Vector3d:Create( { (a.x * b.x) + (a.y * b.y) + (a.z * b.z) } );
end

-- Polar
Vector3d.ToPolar = function ( self )
	return Vector3d:Create( atan2(self.x, self.y, self.z), self:Length() );
end

-- Normalise
Vector3d.Normalise = function ( self )
	local l = self:Length();
	return Vector3d:Create(self.x / l, self.y / l, self.z / l);
end

-- To string representation
Vector3d.ToString = function ( self )
	return "(" .. self.x .. ", " .. self.y .. ", " .. self.z .. ")";
end

-- Returns a rounded vector
Vector3d.Rounded = function ( self )
	local x, y, z = math.floor(self.x), math.floor(self.y), math.floor(self.z);
	local xm, ym, zm = 10^(#tostring(x)-2), 10^(#tostring(y)-2), 10^(#tostring(z)-2);
	x = math.ceil(x / xm)*xm;
	y = math.ceil(y / ym)*ym;
	z = math.ceil(z / zm)*zm;
	return Vector3d:Create(x, y, z);
end

return Vector3d; 