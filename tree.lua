--[[
    Tree
]]

local Tree = { };

-- Creates and returns a Tree Node Object.
Tree.Create = function( self, max_child_num, value, parent, index )
    local tree  = { };
    tree.max_child_num  = max_child_num;     -- The maximum index of children. Used on iterator
    tree.value          = value;             -- The value of the node
    tree.parent         = parent;            -- The parent node
    tree.index          = index;             -- The index of this node in its parent
    tree.it             = nil;               -- Value used internally when iterating
    
    return setmetatable(tree, {
        __index = Tree,
        __call = function ( self, i, ... )
            if not self[i] then 
                self:NewChild(i, ...); 
            end
            return self[i];
        end
    });
end

-- Sets the value for the tree node
Tree.SetValue = function( self, value )
    self.value = value;
end

-- Gets the value for the tree node
Tree.GetValue = function ( self, value )
    return self.value;
end

-- Copies Tree and returns it.
Tree.Copy = function ( self, parent, i )
    local tree = Tree:Create(self.max_child_num, self.value, parent, i);
    for i=1, (self.max_child_num or #self), 1 do
        if self[i] then 
            self[i]:Copy(tree, i);
        end
    end
    return tree;
end

-- Sets the max_child_num of the tree
Tree.SetWidth = function ( self, max_child_num )
    for i = 1, self.max_child_num, 1 do
        if self[i] then 
            self[i]:SetWidth(max_child_num);
        end
    end
    self.max_child_num = max_child_num;
end

-- Returns the max_child_num of the tree
Tree.GetWidth = function ( self, max_child_num )
    return self.max_child_num;
end

-- Returns the root of the tree
Tree.GetRoot = function ( self )
    local node = self;
    while node.parent do
        node = node.parent;
    end
    return node;  
end

-- Creates children and returns them
Tree.NewChild = function ( self, i, value, i2, ...)
    i = i or #self + 1;
    if self[i] then 
        self[i]:Remove();
    end

    self[i] = Tree:Create(self.max_child_num, value, self, i);
    
    return self[i], i2 and self:NewChild(i2, ...) or nil;
end

-- Removes the tree node from its parent and returns it
Tree.Remove = function ( self )
    if self.parent then
        self.parent[self.index] = nil;
        self.parent             = nil;
        self.index              = nil;
    end

    return self;
end

-- Returns the depth of the node. Depth param is used resursively.
Tree.GetDepth = function ( self, depth )
    local depth = depth or 0; 
    local odepth, tdepth = depth;
    for i=1, self.max_child_num or #self, 1do
        if self[i] then 
            tdepth = self[i]:GetDepth(odepth+1);
            if tdepth > depth then 
                depth = tdepth; 
            end
        end
    end
    return depth;
end

-- Iterates over a tree. The mode can be "preorder", "inorder", "postorder" and "depth-order"
Tree.Iterator = function ( self, mode, includeNil )
    local mode = mode or "inorder";   -- The traversal mode
    local n = { };                    -- return nodes
    local d = { };                    -- return depth values
    local k, i = 0, 0;                -- start and end index
    local depth = -1;                 -- the current depth
    local traverse;                   -- traversal function
    
    -- Preordered traverse. Root, Left, Right
    if mode == "preorder" then
        function traverse(node)
            if node == nil then return; end
           
            depth = depth + 1;
            i     = i + 1;
            n[i]  = node;
            d[i]  = depth;
            
            for j=1, node.max_child_num or #node, 1 do
                traverse(node[j]);
            end
           
            depth = depth-1;
        end
    -- Inordered traverse. Left, Root, Right
    elseif mode == "inorder" then
        function traverse(node)
            if node == nil then return; end
            
            depth = depth + 1;
            traverse(node[1]);
            
            i    = i+1;
            n[i] = node;
            d[i] = depth;
           
            for j=2,node.max_child_num or #node, 1 do
                traverse(node[j]);
            end
            
            depth = depth-1;
        end
    -- Postordered traverse. Left, Right, Root
    elseif mode == "postorder" then
        function traverse(node)
            if node == nil then return; end
            
            depth = depth + 1;
            
            for j=1, node.max_child_num or #node, 1 do
                traverse(node[j]);
            end
            
            i     = i + 1;
            n[i]  = node;
            d[i]  = depth;
            depth = depth-1;
        end
    -- Depth ordered traverse
    elseif mode == "depth-order" then
        function traverse(node)
            n[1]  = node;
            d[1]  = 0;
            k,i   = 1, 1;
            depth = 1;
            
            local newdepth = 0;
            while k <= i do
                node = n[k];
                k = k + 1;
                for j=1,node.max_child_num or #node, 1 do
                    if node[j] then 
                        i = i + 1;
                        n[i] = node[j]; 
                        d[i] = depth;
                    end
                end
                if k >= newdepth then
                    depth = depth + 1;
                    newdepth = i + 1;
                end
            end
        end
        -- Unknown traversal mode
    else
        error("Unknown mode. inorder, postorder or depth-order.");
    end
    
    -- Perform the traverse
    traverse(self);
    k = 0;
    
    -- Return the iterator
    return function()
        if k >= i then return nil; end
        k = k + 1;
        return d[k], n[k];
    end
end

local tree = Tree:Create(2,2);
tree(1)(2)(1)(2):SetValue("testing123");


return Tree;