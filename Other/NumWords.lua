----------- Num  <--->  Words
local append, concat, floor, abs = table.insert, table.concat, math.floor, math.abs
local num = {
		'one', 
		'two', 
		'three', 
		'four', 
		'five', 
		'six', 
		'seven', 
		'eight', 
		'nine', 
		'ten', 
		'eleven',
   		'twelve', 
   		'thirteen', 
   		'fourteen', 
   		'fifteen', 
   		'sixteen', 
   		'seventeen', 
   		'eighteen', 
   		'nineteen'
};

local tens = {
		'twenty', 
		'thirty', 
		'forty', 
		'fifty', 
		'sixty', 
		'seventy', 
		'eighty', 
		'ninety'
};

local bases = {{floor(1e18), ' quintillion'}, {floor(1e15), ' quadrillion'}, {floor(1e12), ' trillion'},
   {floor(1e9), ' billion'}, {1000000, ' million'}, {1000, ' thousand'}, {100, ' hundred'}};

local insert_word_AND = false;  -- 101 = "one hundred and one" / "one hundred one"

function NumToWords(n)
   -- Returns a string (spelling of integer number n)
   -- n should be from -2^53 to 2^53  (-2^63 < n < 2^63 for integer argument in Lua 5.3)
	local str = {};
	if n < 0 then
		table.insert(str, "minus");
	end
	n = math.floor(math.abs(n))
	if n == 0 then
		return "zero";
	end
	if n >= 1e21 then
		table.insert(str, "infinity");
	else
		local AND;
    	for _, base in ipairs(bases) do	
    		local value = base[1];
    		if n >= value then
            	table.insert(str, self:NumToWords(n / value)..base[2]);
				n, AND = n % value, insert_word_AND or nil;
        	end
    	end
    	if n > 0 then
        	table.insert(str, AND and "and"); -- a nice pun !
        	table.insert(str, num[n] or tens[floor(n/10)-1]..(n%10 ~= 0 and '-'..num[n%10] or ''));
       	end
	end
	return table.concat(str, ' ');
end

function WordsToNum(number_as_text)
	number_as_text = number_as_text:lower():gsub("%W", "");
	for i = 1, 50 do
		if self:NumToWords(i):lower():gsub("%W", "") == number_as_text then
			return i;
		end
	end
end