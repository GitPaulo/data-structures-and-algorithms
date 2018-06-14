--[[
    KMP Algorithm
        - Uses the degenerating property (pattern having same sub-patterns appearing more than once in the pattern) of the pattern and improves the worst case complexity to O(n) of Naive String Matching.
        - Whenever we detect a mismatch (after some matches), we already know some of the characters in the txt of next window.
]]

function KMPAlgorithm(pat, txt)
    --starting positions... 
    local patloc = 1;
    local txtloc = 1;
     
    --get the length of pat and txt..
    local sublen = string.len(pat);
    local txtlen = string.len(txt);
     
     --generate the fail links...
    local failure = { };
    local comparisons = 0;
     
    local fail = { 0 };
     
    for i=2, sublen do
        local temp = fail[i - 1];
        while temp > 0 and pat:sub(temp, temp) ~= pat:sub(i - 1, i - 1) do
            comparisons = comparisons + 1;
            temp = fail[temp];
        end
        fail[i] = temp + 1;
    end

    local failure = {fail, comparisons + 1};
     
    --store failure comparisons
    comparisons = failure[2]; 
    --store fail table
    fail = failure[1];
     
    --the main loop..
    while txtloc <= txtlen and patloc <= sublen do   
        if patloc == 0 or txt:sub(txtloc, txtloc) == pat:sub(patloc, patloc) then
            comparisons = comparisons + 1;
            txtloc = txtloc + 1;
            patloc = patloc + 1;
        else --no match found so follow fail link
            patloc = fail[patloc];
        end
    end

    if patloc > sublen then
        return {txtloc - sublen, comparisons};
    else
        return {0, comparisons};
    end    
end

print( KMPAlgorithm("ta", "ttattta")[1] );
