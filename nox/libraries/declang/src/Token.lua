-- This component is part of the Nox Framework, copyright 2024 (c) Gabriella Schultz--

local token = {}
token.__index = token

local function _new(_type, _value)
    local self = setmetatable({}, token)
    self.type = _type
    self.value = _value

    if self.value then
        return ("<%s:%s>"):format(self.type, self.value)
    else
        return ("<%s>"):format(self.type)
    end

    return self
end

return setmetatable(token, { __call = function(_, ...) return _new(...) end })