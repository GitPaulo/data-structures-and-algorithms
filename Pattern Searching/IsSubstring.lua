-- Applicaiton of Naive Patter Search
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
			return true;
		end
	end
	
	return false;
end