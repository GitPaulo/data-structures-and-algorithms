--[[
	How many binary trees can we construct with n nodes?
]]
function BinaryTreesWithNNodes(n) --  this is literally just the catalan number sequence
	local function Catalan(n)  // Base case
		if (n <= 1) then return 1; end
		-- catalan(n) is sum of catalan(i)*catalan(n-i-1)
		local res = 0;
		for i=0, n-1, 1 do
			res = res + Catalan(i)*Catalan(n-i-1);
		end
		return res;
	end		
	return Catalan(n);
end