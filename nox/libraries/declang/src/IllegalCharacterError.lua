-- This component is part of the Nox Framework, copyright 2024 (c) Gabriella Schultz--

local lexErr = require 'src.Lang.Compiler.Error'

local illegalcharactererror = {}

function illegalcharactererror.new(_posStart, _posEnd, _details)
    local self = setmetatable({}, illegalcharactererror)
    self.illegalChar = lexErr(_posStart, _posEnd, "Illegal Character", _details)
    return self
end

return illegalcharactererror