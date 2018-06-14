-- Not finished...
function IsRotation( str1, str2 )
	local n = #str1;
    local m = #str2;
    
    if (n != m) then
        return false;
    end
 
    -- create lps[] that will hold the longest
    -- prefix suffix values for pattern
    local lps = { };
 
    -- length of the previous longest prefix suffix
    local len = 0;
    local i = 2;
    lps[1] = 0; -- lps[1] is always 0
 
    -- the loop calculates lps[i] for i = 1 to n-1
    while (i <= n) do
        if (str1[i] == str2[len]) then
        	len = len + 1;
        	lps[i] = len;
    		i = i + 1;
    	else
            if (len == 0) then
                lps[i] = 0;
                i = i + 1;
            else 
            	len = lps[len - 1];
            end
        end
	end
    
    i = 1;
 
    -- match from that rotating point
    for k=lps[n - 1], m, 1 do
        if (str2[k] != str1[i] ) then
            return false;
		end
		i = i + 1;
	end
   
    return true;
end