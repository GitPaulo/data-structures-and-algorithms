--[[
    Depth First Search
]]

function DFS( start_node )
    local visited = { };
    
    recur = function (node)
        print(node .. " ");
        visited[node] = true; -- mark starting point
        
        for k,v in pairs( node.children ) do
            if (not visited[v]) then
                print"u"
                recur(v);
            end
        end
    end

    recur(start_node);
    return visited;
end

local a = { }
a.children = { }
local b = { }
b.children = { }
local r = { } 
r.children = { a , b }
for k,v in pairs( DFS( r ) ) do print(k,v) end