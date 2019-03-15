--[[
Graph - Graph( v, e )
]]

local Edge = { };

Edge.Create = function ( self, vertex_from, vertex_to, weight )
	local edge = { };
	edge.vertex_from = vertex_from;
	edge.vertex_to   = vertex_to;
	edge.weight		 = weight;

	return setmetatable(edge, {
		__index = Edge,
	});
end

Edge.VertexFrom = function ( self )
	return self.vertex_from;
end

Edge.VertexTo = function ( self )
	return self.vertex_to;
end

Edge.GetWeight = function ( self )
	return self.weight;
end

local Graph = { };

Graph.Create = function ( self, edges )
	local graph = { };
	graph.edges = edges or { };

	return setmetatable(graph, {
		__index = Graph,
	});   
end

Graph.VertexCount = function ( self )

end

Graph.EdgeCount = function ( self )
	return #self.edge;
end

Graph.GetVertices = function ( self )
	return self.edges;
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