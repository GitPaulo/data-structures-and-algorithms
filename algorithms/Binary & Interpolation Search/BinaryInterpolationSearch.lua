--[[
    Binary Search:
        -Sorted Array required.

    Assymptotic Analysis:
        T(n) = T(n/2) + c 
        Using the master method: 
        a = 1, b = 2 and f(n) = c 
        logb(a) = log2(1) = 0
        We can compare O(f(n)) = O(1) to O(n^logb(a)) = O(1)
        This is case 2 of the master theorem:
        T(n) = Θ(logn)

    Space Complexity: 
        O(1) in case of iterative implementation. In case of recursive implementation, O(Logn). (recursion call stack space)
]]

-- Recursive implementation
local function BinarySearchRecursive( arr, head, tail, value )
    if ( tail >= head ) then
        local mid = math.ceil(head + (tail-head) / 2); -- mid point = ceil[difference between two pointers + head].
 
        if ( arr[mid] == value ) then -- if value is at the current mid pointer then we found it.
            return mid;
        end
        -- Recursively search in the correct subarray.
        return ( arr[mid] < value ) and BinarySearchRecursive( arr, mid+1, tail, value ) or BinarySearchRecursive( arr, head, mid-1, value ); 
    end
    return nil;
end

-- Iterative Implementation
local function BinarySearchIterative( arr, value )
    local head, tail = 1, #arr;
    while ( head <= tail ) do
        local mid = math.ceil(head + (tail-head) / 2);
        
        if ( arr[mid] == value ) then -- if value is at the current mid pointer then we found it.
            return mid;
        end

        if ( arr[mid] < value ) then 
            head = mid + 1;
        else
            tail = mid - 1;
        end
    end
    return nil;
end

--[[
    Iterpolation Search
        - Sorted array required.
        - Improvement to binary search. Assign mid pointer dependent to the expectations.

    Time Complexity:
        O (log log n)) In worst case it can take upto O(n).
    Space Complexitt: 
        O(1)
]]

-- Iterative Implementation
local function InterpolationSearchIterative( arr, value )
    local head, tail = 1, #arr;
    -- Since array is sorted, an element present in array must be in range defined by corner
    while ( head <= tail and value >= arr[head] and value <= arr[tail] ) do
        -- Probing the position with keeping (uniform distribution in mind)
        local mid = math.ceil( head + ((value-arr[head])*(tail-head)/(arr[tail]-arr[head])) );
        if ( arr[mid] == value ) then 
            return mid;
        end

        if ( arr[mid] < value ) then 
            head = mid + 1;
        else
            tail = mid - 1;
        end
    end
    return nil;
end

local t, x = {1,2,3,4,5,6}, 4;
print(BinarySearchRecursive( t, 0, #t, x ));
print(BinarySearchIterative( t, x ));
print(InterpolationSearchIterative( t, x ));