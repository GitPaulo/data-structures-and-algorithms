--[[
    Dijkstra Algorithm First Search
]]

local G = {
	-- 1   2   3   4   5   6
	{  0,  0, 13,  0, 16,  8 }, -- 1
	{  0,  0,  0,  6,  0, 10 }, -- 2
	{ 13,  0,  0, 14,  0, 11 }, -- 3
	{  0,  6, 14,  0,  5, 17 }, -- 4
	{ 16,  0,  0,  5,  0,  7 }, -- 5
	{  8, 10, 11, 17,  7,  0 }  -- 6
}

local INF = math.huge;
local extract_min = function(q, d)
	local m = INF
	local i = 0
	for k, v in pairs(q) do
		if d[v] < m then
			m = d[v]
			i = k
		end
	end
	q[i] = nil -- remove i
	return i
end

function Dijkstra (graph, start_node)
	local n = table.getn(graph); -- #vertices
	local d = { };
	local previous = { };
	
	for v = 1, n do 
		d[v] = INF 
	end
	
	d[start_node] = 0
	
	local S = {}
	local Q = {}
	
	for v = 1, n do 
		Q[v] = v 
	end -- fill Q
	
	local nQ = n -- # elements in Q
	while nQ > 0 do
		local u = extract_min(Q, d);
		nQ = nQ - 1;
		table.insert(S, u);
		for v = 1, n do
			if G[u][v] > 0 -- edge between u and v?
					and d[v] > d[u] + G[u][v] then -- relax
				d[v] = d[u] + G[u][v];
				previous[v] = u;
			end
		end
	end
	return d, previous;
end

function path (p, start_node)
	local i = start_node
	local t = { i }
	while p[i] do
		table.insert(t, 1, p[i])
		i = p[i]
	end
	return t
end