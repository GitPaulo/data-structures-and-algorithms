--[[
	Graph - Graph( v, e )
]]

local Graph = { };

Graph.Create = function ( self, vertex_from, vertex_to, weight )
    local graph = { };
    if weight == nil then
        weight = 0;
    end

    s.vertex_from = vertex;
    s.vertex_to   = vertex_to;
    s.weight 	  = weight;

    return setmetatable(graph, {
    	__index = Graph,
	});   
end

Graph.VertexFrom = function ( self )
    return self.vertex_from;
end

Graph.VertexTo = function ( self )
    return self.vertex_to;
end

Graph.VertexCount = function ( self )

end

Graph.EdgeCount = function ( self )

end

Graph.GetVertices = function ( self )

end

Graph.GetEdges = function ( self )

end

Graph.AddEdge = function ( self )

end

Graph.RemoveVertex = function ( self )

end

Graph.ContainsVertex = function ( self )

end

Graph.ContainsEdge = function ( self )

end

Graph.GetAdjacentVertices = function ( self )

end

return Graph;