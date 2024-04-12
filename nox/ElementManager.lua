lume = require(LIBPATH .. ".libraries.lume")

local elementmanager = {}
local widgetfuncs = {}
elementmanager.widgets = {}

local function _recursiveLoader(_path, _tbl)
    local items = love.filesystem.getDirectoryItems(_path)
    for item = 1, #items, 1 do
        local path = _path .. "/" .. items[item]
        if love.filesystem.getInfo(path).type == "directory" then
            recursiveLoader(path)
        end
        if love.filesystem.getInfo(path).type == "file" then
            table.insert(_tbl, path)
        end
    end
end

function elementmanager.init()
    local p = {}
    _recursiveLoader(LIBPATH .. "/widgets", p)
    for path = 1, #p, 1 do
        widgetfuncs[string.lower(string.gsub(p[path]:match("[^/]+$"), ".lua", ""))] = require(p[path]:gsub(".lua", ""))
    end
end

function elementmanager.load(_tree)
    local parentUUID = nil
    for e = 1, #_tree, 1 do 
        if _tree[e].type == "parent" then
            parentUUID = _tree[e].uuid
            elementmanager.widgets[_tree[e].uuid] = widgetfuncs[_tree[e].name](_tree[e].properties, _tree[e].uuid, {
                type  = "parent",
                elementList = elementmanager.widgets,
                parentUUID = nil
            })
        else
            elementmanager.widgets[_tree[e].uuid] = widgetfuncs[_tree[e].name](_tree[e].properties, _tree[e].uuid, {
                type  = "children",
                elementList = elementmanager.widgets,
                parentUUID = parentUUID
            })
        end
    end
end

function elementmanager.selectFromTag(_tag)
    
end

return elementmanager