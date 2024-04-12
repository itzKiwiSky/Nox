-- This component is part of the Nox Framework, copyright 2024 (c) Gabriella Schultz--

-- ps: this code is shit.. --

local parser = {}
parser.__index = parser

local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end


local function _new(_tokens)
    local self = setmetatable({}, parser)
    self.tokens = _tokens
    self.curToken = nil

    self.pos = {}
    self.pos.index = 0
    self:advance()
    return self
end

function parser:advance()
    self.pos.index = self.pos.index + 1
    if self.pos.index <= #self.tokens then
        local tknPos = self.tokens[self.pos.index]
        tknPos = tknPos:gsub("[<>]", "")
        local rawStr = string.split(tknPos, ":")
        self.curToken = {
            tknType = rawStr[1],
            tknValue = rawStr[2]
        }
    else
        self.curToken = nil
    end
end


--[[
    TT_NFLOAT
    TT_NINT
    TT_STRING
    TT_ELEMENT
    TT_SELF_CLOSE_ELEMENT
    TT_PROPERTY
    TT_ARROW_SCOPE
    TT_ASSIGNMENT
    TT_SCOPE_OPEN
    TT_SCOPE_CLOSED
    TT_ENDLINE
]]--

function parser:parseProperties(_tbl)
    while self.curToken ~= nil and self.curToken.tknType == "TT_PROPERTY" or self.curToken.tknType == "TT_ASSIGNMENT" do
        if self.curToken.tknType == "TT_SELF_CLOSE_ELEMENT" then self:advance() end
        if self.curToken.tknType == "TT_PROPERTY" then
            local propName = self.curToken.tknValue
            self:advance()
            if self.curToken.tknType == "TT_ASSIGNMENT" then
                self:advance()
                _tbl[propName] = self.curToken.tknValue
                self:advance()
            end
        end
    end
end

--[[
    element.type = self.curToken.tknValue
    element.properties = {}
    self:advance()
    self:parseProperties(element.properties)
    table.insert(elements, element)
    self:advance()
]]--


function parser:run()
    local elements = {}
    local lastParent = ""

    while self.curToken ~= nil do
        local element = {}
        local lastUUID = uuid()
        if self.curToken.tknType == "TT_ELEMENT" then
            element.type = "parent"
            element.name = self.curToken.tknValue
            element.uuid = lastUUID
            element.properties = {}
            self:advance()
            self:parseProperties(element.properties)
            if self.curToken.tknType == "TT_SCOPE_OPEN" then
                -- add a reference to this shit element to indicate the newest elements is children from this mf --
                lastParent = lastUUID
                self:advance()
            end
            if lastParent ~= nil and element.type == "children" then
                element.parentFrom = lastParent
            end
            table.insert(elements, element)
        elseif self.curToken.tknType == "TT_SELF_CLOSE_ELEMENT" then
            element.type = "children"
            element.name = self.curToken.tknValue
            element.uuid = lastUUID
            element.properties = {}
            -- check if is out of the parent element scope --
            if lastParent ~= nil then
                element.parentFrom = lastParent
            end
            self:advance()
            self:parseProperties(element.properties)
            table.insert(elements, element)
        elseif self.curToken.tknType == "TT_SCOPE_CLOSED" then
            if lastParent ~= nil then
                lastParent = nil
                self:advance()
            end
        end
    end

    return elements
end

return setmetatable(parser, { __call = function(_, ...) return _new(...) end })