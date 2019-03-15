--[[
		Dice co-effecient:
      - How similar two sets are.
      - We devide the strs in bigrams (sets of two) then count how many are equal (intersection) and make a percentage out of that.
    Time Complexity:
      O(nlogn) - assuming sort is nlogn
]]

function Dice( str1, str2 ) 
    local strlen1 = #str1;
    local strlen2 = #str2;

    --check fast cases
    if (((str1 ~= nil) and (strlen1 == 0)) or
        ((str2 ~= nil) and (strlen2 == 0))) then
        return 0;
    end

    if (str1 == str2) then
        return 1;
    end
    
    strlen1 = strlen1 - 1;
    strlen2 = strlen2 - 1;
    
    local bigram1 = { };
    local bigram2 = { };

    for i = 1, strlen1, 1 do
        table.insert( bigram1, str1:sub(i,i+1) );
    end

    for i = 1, strlen2, 1 do
        table.insert( bigram2, str2:sub(i,i+1) );
    end 
    
    table.sort(bigram1, function ( a, b ) return a < b end)
    table.sort(bigram2, function ( a, b ) return a < b end)
    
    -- intersection:
    local count = 0;
    local i, j = 1, 1;
    while ( i <= strlen1 and j <= strlen2) do
        if (bigram1[i] < bigram2[j] )then
            i = i + 1;
        elseif (bigram1[i] > bigram2[j] ) then
            j = j + 1; 
        else -- they're equal */
            count = count + 1;
            i = i + 1;
            j = j + 1;
        end
    end
    
    return count / (strlen1 + strlen2);
end

print(Dice( "paul", "paulo" ));
print(Dice( "paule", "paulo" ));
print(Dice( "pul", "paulo" ));
