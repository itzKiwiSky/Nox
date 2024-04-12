-- This component is part of the Nox Framework, copyright 2024 (c) Gabriella Schultz--

local colors = require 'src.Shell.Colors'

local lexerr = {}
lexerr.__index = lexerr
local function _new(_posStart, _posEnd, _errName, _details)
    local self = setmetatable({}, lexerr)
    self.posStart = _posStart
    self.posEnd = _posEnd
    self.errName = _errName
    self.details = _details
    return self
end

function lexerr:asString()
    local errTemplate = [[
%s[ERROR]%s : %s | %s
    File : %s, line: %s
    ]]
    return string.format(
        errTemplate,
        colors.bright_red, colors.reset, self.errName, self.details, self.posStart.ln, self.posStart.ln + 1
    )
end

return setmetatable(lexerr, { __call = function(_, ...) return _new(...) end })