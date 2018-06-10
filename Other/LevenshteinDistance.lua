-- Displacement of Characters in strings
function LevenshteinDistance(s, t)
	local minimum = function (a, b, c)
		local smallest = a;
		if (smallest > b) then smallest = b; end
		if (smallest > c) then smallest = c; end
		return smallest;
	end
	-- for all i and j, d[i][j] will hold the Levenshtein distance between
	-- the first i characters of s and the first j characters of t
	-- note that d has (#s+1)*(#t+1) values
	local d = { };
	for i=1, #s-1, 1 do
		d[i] = {};
		for j=1, #t+1, 1 do
			d[i][j] = 0;
		end
	end
  
	-- source prefixes can be transformed into empty string by
	-- dropping all characters
	for i=2, #s-1, 1 do
    	d[i][1] = i;
	end
	
	-- target prefixes can be reached from empty source prefix
	-- by inserting every character
	for j=2, #t-1, 1 do
    	d[1][j] = j;
    end
 
	local substitutionCost = 0;
	for j=2, #t-1, 1 do
    	for i=2, #s-1, 1 do
        	if s[i] == t[j] then
            	substitutionCost = 0;
        	else
            	substitutionCost = 1;
        		d[i][j] = minimum( d[i-1][j] + 1,                     -- deletion
                            		d[i][j-1] + 1,                    -- insertion
                            		d[i-1][j-1] + substitutionCost);  -- substitution
			end
		end
	end

	return d[#s-1][#t-1];
end