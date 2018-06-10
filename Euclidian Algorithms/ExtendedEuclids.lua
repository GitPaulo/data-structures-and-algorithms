--[[
		Extended Euclids also find integers that:  ax + by = gcd(a, b) 
		(This is a key point in RSA encryption)

		Time Complexity:
			-  O(Log min(a, b))
]]

function ExtendedEuclids( a, b, x, y )
   	-- Base Case
    if (a == 0) then
        x = 0;
        y = 1;
        return b;
    end
 
    local x1, y1; --To store results of recursive call
    local gcd = ExtendedEuclids(b%a, a, x1, y1);
 
    -- Update x and y using results of recursive call
    x = y1 - (b/a) * x1;
    y = x1;
 
    return gcd;
end