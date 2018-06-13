--[[
	Counting Inversions - Simple
		- How far the array is from being sorted. If array is already sorted then inversion count is 0. If array is sorted in reverse order that inversion count is the maximum.

	Time Complexity:
		- O(n*n)
	Space Complexity:
		- O(1)
]]

function CountingInversionsSimple( arr )
	local inv_count = 0;
  	for i=1, n, 1 do
		for j=i+1, n, 1 do
      		if (arr[i] > arr[j]) then
        		inv_count++;
        	end
        end
    end
	return inv_count;
end

--[[
	Counting Inversions - Merge Sort
		- How far the array is from being sorted. If array is already sorted then inversion count is 0. If array is sorted in reverse order that inversion count is the maximum.

	Time Complexity:
		- O(nlogn), same as merge sort
	Space Complexity:
		- same as merge sort
]]

function merge( arr, temp, low, mid, high )
    local inv_count = 0;
    local i = low; -- i is index for left subarray
    local j = mid;  -- j is index for right subarray
    local k = high; -- k is index for resultant merged subarray
     
    while ((i <= mid - 1) && (j <= high)) do
        if (arr[i] <= arr[j]) then
        	k = k + 1; i = i + 1;
        	temp[k] = arr[i];
        else
        	k = k + 1; j = j + 1;
        	temp[k] = arr[j];
        	--this is tricky -- see above explanation/diagram for merge()
          	inv_count = inv_count + (mid - i);
        end
    end
      
	-- Copy the remaining elements of left subarray (if there are any) to temp
	while (i <= mid - 1) do 
		k = k + 1; i = i + 1;
		temp[k] = arr[i];
  	end
	-- Copy the remaining elements of right subarray (if there are any) to temp
  	while (j <= high) do
  		k = k + 1; j = j + 1;
    	temp[k] = arr[j];
  	end

 	-- Copy back the merged elements to original array*/
  	for i=low, high, 1 do
    	arr[i] = temp[i];
    end

    return inv_count;
end

function CountingInversionsMergeSort( arr, low, high )
    local inv_count = 0;
    local temp = { };
    if low < high then
        local mid = math.floor((low + high)/2);
        -- Call mergeSort for first half:   
        inv_count = MergeSort(arr, low, mid);
        --Call mergeSort for second half:
        inv_count = inv_count + MergeSort(arr, mid+1, high);
        --Merge the two halves sorted in step 2 and 3:
        inv_count = inv_count + merge(arr, temp, low, mid, high);
    end
    return inv_count;
end