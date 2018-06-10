--[[
    Bubble Sort:
        - Probably the simplest sorting algorithm.
        - Repeatedly swaps the adjacent elements if they are in wrong order. (Bubbles them).

    Time Complexity:
        O(n^2) time even if the array is sorted.
    
    Space Complexity:
        O(1)
]]

-- non optimised
function BubbleSort( arr )
    for i=1, #arr-1, 1 do -- last comparison not needed
        for j=1, #arr-i, 1 do  -- up until i (sorted part)
            if arr[j] > arr[j+1] then 
                local temp;
                temp     = arr[j+1]
                arr[j+1] = arr[j];
                arr[j]   = temp;
            end
        end
    end
    return arr;
end

-- optimised bubble sort
function BubbleSortOpt( arr )
    local swapped = false; -- flag to sinalise if it is worth sorting
    for i=1, #arr-1, 1 do
        swapped = false;
        for j=1, #arr-i, 1 do
            if arr[j] > arr[j+1] then
                swapped = true;
                local temp;
                temp     = arr[j+1]
                arr[j+1] = arr[j];
                arr[j]   = temp;
            end
        end
        if not swapped then break; end -- we didnt swap so we can break.
    end
    return arr;
end

--[[
    Insertion Sort:
        - Works the same way as we sort cards.

    Time Complexity:
        O(n^2) time even if the array is sorted.
    
    Space Complexity:
        O(1)
]]

function InsertionSort( arr )
    for i=1, #arr, 1 do
        local key = arr[i];
        local j = i-1;
        while( j >= 1 and arr[j] > key ) do
            arr[j+1] = arr[j];
            j = j-1;
        end
        arr[j+1] = key;
    end
    return arr;
end

----------------- Testing -----------------

PrintTable(BubbleSort({1,3,4,5,11,23,1,44,-1,-1231}));
PrintTable(BubbleSortOpt({1,3,4,5,11,23,1,44,-1,-1231}));
PrintTable(InsertionSort({1,3,4,5,11,23,1,44,-1,-1231}));