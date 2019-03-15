--[[
		Given a rectangle grid, find the number of paths from 0,0 to n, k where n is the |x| and k is the |y|
		You can only go right or bottom.
		Answer in Modulo big prime.
]]

function PathInGrid( w, h )
	local p = 1000000007; -- big prime
	function f ( n ) -- factiorial
		if (n >= p) then error("n >= p"); end
    	a = 1; i = 0;
    	for i=2, n do
     		a = (a*i)%p; -- modulo p, for big N
    	end
    	return a;
  	end
  	function c( n, r ) -- combination
    	if (n <= r) then return error("n ≥ r ≥ 0"); end
    	return f(n)/(f(n-r)*f(r));
  	end
  	return c(w+h,w); -- solution
end

print(PathInGrid(6,2));
--[[ Explanation:
  You can only take a bottom or right turn. So in a vector (x, y) you can only add. 0..x, 0..y. 2 Moves! 
  Thus, how many unordered combinations of 2 can you have in x = x+y Cn y
  Ways of getting from 1 to 6. 3+2 Cn 2 = 20
  [1][2][3]
  [4][5][6]
]]