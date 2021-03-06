--[[
Grid - Grid(x,y)
]]

local Grid = { };

-- Creates and returns a new grid
Grid.Create = function ( self )
    local grid = { };
    return setmetatable(grid, {
        __index = self;
    });
end

-- Creates a copy of the grid and returns it
Grid.Copy = function( self )
    local new_grid = Grid:Create();
    for x, y, v in self:Iterate() do
        new_grid:SetCell(x, y, v);
    end
    return new_grid;
end

-- Clears the grid
Grid.Clear = function ( self )
    self = {};
end

-- Returns the number of grid elements. This is rather slow. For debug only.
Grid.Size = function ( self )
    local count = 0;
    for _, cell in pairs(self) do
        for _, _ in pairs(cell) do
            count = count + 1; 
        end
    end
    return count;
end

-- Gets the value of a single cell
Grid.GetCell = function ( self, x, y )
    return self[x] and self[x][y];
end

-- Sets the value of a single cell
Grid.SetCell = function ( self, x, y, value )
    if not self[x] then 
        self[x] = { }; 
    end
    self[x][y] = value;
end

-- Iterator for the grid 
Grid.Iterate = function ( self )
    local x, row = next(self);
    if x == nil then return function() end end
    local y, val;
    return function()
        repeat
            y,val = next(row,y);
            if y == nil then x,row = next(self, x); end
        until (val and x and y) or (not val and not x and not y)
        return x,y,val;
    end
end

-- Iterate over a rectangle shape. Gauranteed to be left-to-right, top-to-bottom order.
-- Mode can be "line" or "fill"
Grid.IterateRectangle = function ( self, node, startX, startY, width, height, includeNil )
    local x, y = startX, startY;
    local rx, ry, rv;
    return function()
        while y < startY + height do
            while x < startX + width do
                rx, ry, rv = x, y, self(x,y);
                if mode == "fill" or y == startY or y == startY + height - 1 then 
                    x = x+1;
                else
                    x = x + width - 1;
                end
                if rv ~= nil or includeNil then 
                    return rx, ry, rv;
                end
            end
            x = startX;
            y = y+1;
        end
        return nil;
    end
end

-- Iterate over a line. Mode can be "smooth" or "rigid"
Grid.IterateLine =  function ( self, mode, startX, startY, endX, endY, includeNil )
    local dx = math.abs(endX - startX);
    local dy = math.abs(endY - startY);
    local x = startX;
    local y = startY;
    local incrX = endX > startX and 1 or -1;
    local incrY = endY > startY and 1 or -1;
    local err = dx - dy;
    local err2 = err*2;
    local i = 1+dx+dy;
    local rx,ry,rv ;
    local checkX = false;
    
    return function()
        while i>0 do 
            rx,ry,rv = x,y,self(x,y);
            err2 = err*2;
            while true do
                checkX = not checkX     
                if checkX == true or mode == "rigid" then 
                    if err2 > -dy then
                        err = err - dy;
                        x = x + incrX;
                        i = i-1;
                        if mode ~= "rigid" then break; end
                    end
                end
                if checkX == false or mode == "rigid" then
                    if err2 < dx then
                        err = err + dx;
                        y = y + incrY;
                        i = i-1;
                        if mode ~= "rigid" then break; end
                    end
                end
                if mode == "rigid" then break; end
            end
            if rx == endX and ry == endY then i = 0; end
            if rv ~= nil or includeNil then return rx,ry,rv; end
        end
        return nil;
    end
end

-- Iterates over a circle of cells. Mode can be "line" or "fill"
Grid.IterateCircle = function ( self, mode, x0, y0, radius, includeNil )
    mode = mode or "fill";
    local f = 1 - radius;
    local dx = 1;
    local dy = -2 * radius;
    local x = 0;
    local y = radius;
    local points = {};

    local function mark(y,x1,x2)
        if not points[y] then points[y] = {}; end
        if mode == "line" then
            points[y][x1] = true;
            points[y][x2] = true;
        else
            for x = x1,x2 do
                points[y][x] = true;
            end
        end
    end

    mark(y0 + radius, x0, x0);
    mark(y0 - radius, x0, x0);
    mark(y0, x0 - radius, x0 + radius);

    while x < y do
        if f >= 0 then
            y = y - 1;
            dy = dy + 2;
            f = f + dy;
        end
        x = x + 1;
        dx = dx + 2;
        f = f + dx;    
        mark(y0 + y, x0 - x, x0 + x);
        mark(y0 - y, x0 - x, x0 + x);
        mark(y0 + x, x0 - y, x0 + y);
        mark(y0 - x, x0 - y, x0 + y);
    end

    local row;
    y, row = next(points);
    x = nil;
    return function()
        while true do
            x = next(row,x);
            if not x then 
                y, row = next(points,y) ;
                if not row then return nil; end
                x = next(row);
            end
            if self(x,y) or includeNil then
                return x, y, self(x,y);
            end
        end
    end
end

-- Cleans the grid of empty rows. 
Grid.Clean = function ( self )
    for key,row in pairs(self) do
        if not next(row) then 
            self[key] = nil; 
        end
    end
end

-- This makes calling the grid as a function act like Grid.get or Grid.set depending on the number
-- of parameters.
Grid.__call = function( self, x, y, v )
    if v == nil then
        return self:get(x,y);
    else
        self:set(x,y,v);
    end
end 

-- To String Grid
Grid.ToString = function ( self )
    local function newStringStack ()
        return { "" };  -- starts with an empty string
    end

    function addString ( stack, s )
        table.insert(stack, s)    -- push 's' into the the stack
        for i=#stack-1, 1, -1 do
            if string.len(stack[i]) > string.len(stack[i+1]) then
                break
            end
            stack[i] = stack[i] .. table.remove(stack)
        end
    end

    local str = newStringStack();
    for key,row in pairs(self) do
        addString( str, "["..key.."]".."{ " );
        for k,v in pairs(row) do
            addString( str, v );
            if k ~= #row then 
                addString( str, ", " );
            end
        end
        addString( str, " }\n" );
    end
    return table.concat(str, "");
end

local g = Grid:Create();
g:SetCell(1,1,10);
g:SetCell(1,2,13);
g:SetCell(2,1,104);
g:SetCell(3,1,110);

print(g:ToString())

return Grid;