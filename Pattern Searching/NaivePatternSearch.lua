--[[
    Naive Pattern Searching
        - Given a text txt[1..n] and a pattern pat[1..m], write a function search(pat[], txt[]) that returns all occurrences of pat[] in txt[]. 
        You may assume that n > m.
    Time Complexity
        - O((n-m)+1 * n) ~ O(n)
]]

function search( pat, txt )
    local n = #txt;
    local m = #pat;
    local occurrences = { };

    for i=1, (n-m)+1, 1 do -- 1234567891011, 1234 .. once we get to [8] we dont need to check for 9,10,11
        local c = 0;
        
        for j=1, m, 1 do
            if txt[i+j-1] ~= pat[j] then
                break;
            end
            c = c + 1;
        end
        
        if ( c == m ) then
            occurrences[#occurrences+1] = i;
        end
    end
    
    return occurrences;
end