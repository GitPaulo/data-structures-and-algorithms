function PrintTable( tbl )
    local valueToString = function ( v )
        if "string" == type(v) then
            v = string.gsub( v, "\n", "\\n" );
            if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
                return "'" .. v .. "'";
            end
            return '"' .. string.gsub(v,'"', '\\"' ) .. '"';
        else
            return "table" == type(v) and table.tostring(v) or
            tostring(v);
        end
    end
    local keyToString = function ( k )
        if "string" == type(k) and string.match( k, "^[_%a][_%a%d]*$" ) then
            return k;
        else
            return "[" .. valueToString(k) .. "]";
        end
    end
    local result, done = { }, { };
    for k, v in ipairs( tbl ) do
        table.insert( result, valueToString(v) );
        done[k] = true;
    end
    for k, v in pairs( tbl ) do
        if not done[k] then
            table.insert( result, keyToString(k) .. "=" .. valueToString(v) );
        end
    end
    print("{" .. table.concat( result, ", " ) .. "}");
end
