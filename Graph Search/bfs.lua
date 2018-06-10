--[[
	Breath First Search - (NOT FINISHED)
]]

function BFS ( start_node )
    local visited = { };
 
    -- Create a queue for BFS
    local queue = { };
 
    -- Mark the current node as visited and enqueue it
    visited[start_node] = true;
    table.insert(queue, start_node);
 
    while ( #queue ~= 1) do
    	--	Dequeue a vertex from queue and print it
        start_node = table.remove(queue, 1);
        print( start_node + " " );
 
        -- Get all adjacent vertices of the dequeued vertex s
        -- If a adjacent has not been visited, then mark it
        -- visited and enqueue it
    end
    return visited;
end