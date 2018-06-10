--[[
		Kadane's algorithm is to look for all positive contiguous segments of the array (max_ending_here is used for this). 
		And keep track of maximum sum contiguous segment among all positive segments (max_so_far is used for this). 
		Each time we get a positive sum compare it with max_so_far and update max_so_far if it is greater than max_so_far
]]

function KadanesAlgorithm(arr)
	local max_so_far = 0;
	local max_ending_here = 0;

	for i=1, #arr, 1 do -- O(n) time :D
		max_ending_here = max_ending_here + arr[i];
		if(max_ending_here < 0) then
			max_ending_here = 0;
		end
		if(max_so_far < max_ending_here) then
			max_so_far = max_ending_here;
		end
	end
	return max_so_far;
end
