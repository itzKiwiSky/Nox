-- This component is part of the Nox Framework, copyright 2024 (c) Gabriella Schultz--
local token = require(path .. ".src.Token")

local lexer = {}
lexer.__index = lexer

local function _new(_text)
    local self = setmetatable({}, lexer)
    self.text = _text
    self.curChar = nil
    self.pos = {}
    self.pos.index = 0
    self.pos.col = 1
    self:advance()
    return self
end

function lexer:advance()
    self.pos.index = self.pos.index + 1
    self.pos.col = self.pos.col + 1

    if self.pos.index <= #self.text then
        self.curChar = string.sub(self.text, self.pos.index, self.pos.index)
    else
        self.curChar = nil
    end
end

function lexer:makeNumber()
    local numStr = ""
    local dotCount = 0

    while self.curChar ~= nil and self.curChar:find("[0-9]") or self.curChar:find("%.") do
        if self.curChar == "." then
            if dotCount == 1 then break end
            dotCount = dotCount + 1
            numStr = numStr .. self.curChar
        else
            numStr = numStr .. self.curChar
        end
        self:advance()
    end

    if dotCount > 0 then
        return token("TT_NFLOAT", tonumber(numStr))
    else
        return token("TT_NINT", math.floor(tonumber(numStr)))
    end
end

function lexer:makeText()
    local str = ""
    local quoteCount = 0
    while self.curChar ~= nil and self.curChar:find("['\"a-zA-Z%d%s]") do
        if quoteCount > 1 then break end
        if self.curChar == "'" or self.curChar == "\"" then
            quoteCount = quoteCount + 1
            str = str .. self.curChar
        else
            str = str .. self.curChar
        end
        self:advance()
    end
    return token("TT_STRING", string.gsub(tostring(str), "['\"]", ""))
end

function lexer:makeElement()
    local str = ""
    local tagDetect = 0
    local selfClose = false
    while self.curChar ~= nil and self.curChar:find("[!a-zA-Z%(%)]") do
        if self.curChar == "(" or self.curChar == ")" then
            if tagDetect == 2 then break end
            tagDetect = tagDetect + 1
            str = str .. self.curChar
        elseif self.curChar == "!" then
            selfClose = true
        else
            str = str .. self.curChar
        end
        self:advance()
    end
    
    if selfClose then
        return token("TT_SELF_CLOSE_ELEMENT", string.gsub(tostring(str), "[%(%)]", ""))
    else
        return token("TT_ELEMENT", string.gsub(tostring(str), "[%(%)]", ""))
    end
end

function lexer:makeProperty()
    local name = ""
    while self.curChar:find("[a-zA-Z]") do
        name = name .. self.curChar
        self:advance()
    end
    
    return token("TT_PROPERTY", tostring(name))
end

function lexer:operators()
    local op = ""
    while self.curChar:find("[%->]") do
        op = op .. self.curChar
        self:advance()
    end

    return token("TT_ARROW_SCOPE")
end

function lexer:createTokens()
    local tokens = {}

    while self.curChar ~= nil do
        --print(self.curChar)
        if self.curChar == " " or self.curChar == "\t" then
            self:advance()
        elseif self.curChar == "(" then
            table.insert(tokens, self:makeElement())
        elseif self.curChar == "'" or self.curChar == "\"" then
            table.insert(tokens, self:makeText())
        elseif self.curChar:find("[0-9]") then
            table.insert(tokens, self:makeNumber())
        elseif self.curChar:find("[a-zA-Z]") then
            table.insert(tokens, self:makeProperty())
        elseif self.curChar == "=" then
            table.insert(tokens, token("TT_ASSIGNMENT"))
            self:advance()
        elseif self.curChar == "{" then
            table.insert(tokens, token("TT_SCOPE_OPEN"))
            self:advance()
        elseif self.curChar == "}" then
            table.insert(tokens, token("TT_SCOPE_CLOSED"))
            self:advance()
        elseif self.curChar == ";" then
            table.insert(tokens, token("TT_ENDLNE"))
            self:advance()
        else
            return {}, "[ERROR] Invalid token type"
        end
    end

    return tokens, nil
end

return setmetatable(lexer, { __call = function(_, ...) return _new(...) end })