--[[
	Euclidian Algorithm: GCD of two numbers is the largest number that divides both of them.
	The algorithm is based on below facts:
		- If we subtract smaller number from larger (we reduce larger number), GCD doesn’t change. So if we keep subtracting repeatedly the larger of two, we end up with GCD.
		- Now instead of subtraction, if we divide smaller number, the algorithm stops when we find remainder 0.

	Time Complexity:
		-  O(Log min(a, b))
]]

function gcd ( a, b )
	return (a==0) and b or gcd(b%a, a);
end
