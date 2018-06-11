--[[
	Tree
]]

local Tree = { };

-- Creates and returns a new tree node. All parameters are optional.
Tree.Create = function ( self, width, value, parent, index_child )
    local tree = { };
    tree.width 		  = width;		  -- width of the tree
    tree.value 		  = value; 		  -- value of the node
    tree.parent 	  = parent;		  -- parent node
    tree.index_child  = index_child;  -- index on parent's children
    return setmetatable( tree, {
    	__index = self;
    });
end

-- Returns the root of the tree
Tree.GetRoot = function ( self )
    local node = self;
    while node.parent do
        node = node.parent;
    end
    return node;
end

-- Sets the value
Tree.SetValue = function ( self, value )
    self.value = value;
end

-- Gets the value 
Tree.GetValue = function ( self, value )
    return self.value;
end

-- Returns a copy of the tree.
Tree.Copy = function ( self, root, i )
    local tree = Tree:Create(self.width, self.value, root, i);
    for i=1,(self.width or #self) do
        if self[i] then 
            self[i]:Copy(tree, i);
        end
    end
    return tree;
end

-- Sets the width of the tree
Tree.SetWidth = function ( self, width )
    for i = 1, self.width do
        if self[i] then 
        	self[i]:SetWidth(width);
		end
    end
    self.width = width;
end

-- Returns the width of the tree
Tree.GetWidth = function ( self, width )
    return self.width
end

-- Creates children and returns them
Tree.Insert = function ( self, i, value, i2, ... )
    i = i or #self + 1;
    
    if self[i] then 
    	self[i]:Remove(); 
    end
    
    self[i] = Tree:Create(self.width, value, self, i);
    
    return self[i], i2 and self:Insert(i2, ...) or nil;
end

-- Removes the tree node from its parent and returns it
Tree.Delete = function ( self )
    if self.parent then
        self.parent[self.index] = nil;
        self.parent = nil;
        self.index_child = nil;
    end
    return self;
end

-- Tree depth
Tree.Depth = function ( self, depth )
	local od, td = depth;
 	for i=1, self.width or #self do
        if self[i] then 
            td = self[i]:Depth( od+1 );
            depth = td > depth and td or depth;
        end
    end
end

Tree.ToString = function ( self )

end

return Tree;