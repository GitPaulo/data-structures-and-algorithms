--[[
	Vector3d - Vector3d(x,y,z)
]]

local Vector3d = { };

Vector3d.Create = function ( self )
	local vector = { };
	vector.x = 0;
	vector.y = 0;
	vector.z = 0;
	return setmetatable( vector, {
		__index = self,
	});
end