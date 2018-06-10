--[[
    Counting Sort:
        - We count each occurence of digits!
    Time Complexity:
        - O(n+k) where n is the number of elements in input array and k is the range of input.
    Space Complexity:
        - O(n+k)
--]]

function CountingSort( arr, min, max )
    local count = {};
    for i = min, max do
        count[i] = 0;
    end

    for i = 1, #arr do
        count[ arr[i] ] = count[ arr[i] ] + 1;
    end

    local z = 1;
    for i = min, max do
        while count[i] > 0 do
            arr[z] = i;
            z = z + 1;
            count[i] = count[i] - 1;
        end
    end
    return arr;
end

--[[
    Shell Sort:
        - A variation of insertion sort. Better :D. The idea of shellSort is to allow exchange of far items. 
        In shellSort, we make the array h-sorted for a large value of h. We keep reducing the value of h until it becomes 1. An array is said to be h-sorted if all sublists of every h’th element is sorted.
    Time Complexity:
        - O(n^2) In the above implementation gap is reduce by half in every iteration. 
    Space Complexity:
        - O(1)
]]

-- See https://en.wikipedia.org/wiki/Shellsort#Gap_sequences to reduce complexity
function ShellSort( arr )
    -- Start with a big gap, then reduce the gap
    local gap = math.ceil( #arr / 2 )
    while gap > 0 do
        -- Do a gapped insertion sort for this gap size.
        -- The first gap elements arr[1..gap-1] are already
        -- in gapped order keep adding one more element
        -- until the entire array is gap sorted
        for i = gap, #arr do
            local tmp = arr[i];
            local j = i;
            while j > gap and arr[j-gap] > tmp do
                arr[j] = arr[j-gap];
                j = j - gap;
            end
            arr[j] = tmp;
        end
        gap = math.floor( 0.5 + gap / 2.2 );
    end

    return arr;
end
        

--[[
    Quick Sort:
        - Divide and Conquer sorting algorithm
    Time Complexity:
        - In general: T(n) = T(k) + T(n-k-1) + theta(n)
        - Two terms are for the different recursive calls, the last term is for the partition process. 

        - Best case: T(n) = 2T(n/2) + theta(n) [when the partition process always picks the middle element as pivot]
        - Using the master theorem notation:
            a = 2, b = 2, f(n) = n and logb(a) = 1
            Compare O(f(n)) = O(n) to O(n^log2(2)), they are equal.
            This is case 2. 
            T(n) is theta(nLogn)
        
        - Average case: T(n) = T(n/9) + T(9n/10) + theta(n) [bit more complicated, need to consider all possible permutations of array]
        - Solution of the above: O(nLogn)
        
        - Worst case: T(n) = T(0) + T(n-1) + theta(n) <=> T(n) = T(n-1) + theta(n) [when the partition process always picks greatest or smallest element as pivot]
        - Solution of the above: O(nLogn)
    Space Complexity & Superiority to Merge Sort:
        - Quick Sort in its general form is an in-place sort (i.e. it doesn’t require any extra storage) whereas merge sort requires O(N) extra storage.
        - Allocating and de-allocating the extra space used for merge sort increases the running time of the algorithm. 
        - Comparing average complexity we find that both type of sorts have O(NlogN) average complexity but the constants differ. For arrays, merge sort loses due to the use of extra O(N) storage space.
]]

function partition( arr, low, high )
    local pivot = arr[high];  
    local i = (low - 1)  -- Index of smaller element

    for j=low, high-1, 1 do
        -- If current element is smaller than or equal to pivot
        if (arr[j] <= pivot) then
            i = i + 1 -- increment index of smaller element
            arr[i], arr[j] = arr[j], arr[i]; -- swap
        end
    end
    
    -- swap
    arr[i + 1], arr[high] = arr[high], arr[i + 1];

    return (i + 1)
end

function QuickSort( arr, low, high )
    if low < high then
        local pivot = partition(arr, low, high);
        quicksort(arr, low, pivot - 1);
        quicksort(arr, pivot + 1, high);
    end
    return arr;
end

--[[
    Merge Sort:
        - Divide and Conquer sorting algorithm
    Time Complexity:
        - T(n) = 2T(n/2) + theta(n)
        (same as Quick Sort)
    Space Complexity:
        - O(n)      
]] 

-- Merges two subarrays of arr[].
-- First subarray is arr[low..m]
-- Second subarray is arr[mid+1..high]
function merge( arr, low, mid, high )
    -- Find sizes of two subarrays to be merged
    local n1 = mid - low + 1;
    local n2 = high - mid;
    -- Create temp arrays
    local L = { };
    local R = { };
    -- Copy data to temp arrays
    for i=1, n1, 1 do
        L[i] = arr[low + i - 1];
    end

    for j=1, n2, 1 do
        R[j] = arr[mid + j];
    end
    
    L[n1+1] = math.huge;
    R[n2+1] = math.huge;
    
    local i=1;
    local j=1;
    
    -- Copy elements to the right positions in arr
    for k=low, high, 1 do
        if L[i] <= R[j] then
            arr[k] = L[i];
            i = i + 1;
        else
            arr[k] = R[j];
            j = j + 1;
        end
    end
end

function MergeSort( arr, low, high )
    if low < high then
        local mid = math.floor((low + high)/2);
        -- Call mergeSort for first half:   
        MergeSort(arr, low, mid);
        --Call mergeSort for second half:
        MergeSort(arr, mid+1, high);
        --Merge the two halves sorted in step 2 and 3:
        merge(arr, low, mid, high);
    end
    return arr;
end
