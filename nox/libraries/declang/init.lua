local declang = {
    _VERSION  = "Descriptor Lang v0.0.1",
    _DESCRIPTION = "Descriptor lang, used internally for the Nox wrapper for LoveFrames",
    _LICENSE = [[
        MIT LICENSE

        Copyright (c) 2024 Gabriella Schultz

        Permission is hereby granted, free of charge, to any person obtaining a
        copy of this software and associated documentation files (the
        "Software"), to deal in the Software without restriction, including
        without limitation the rights to use, copy, modify, merge, publish,
        distribute, sublicense, and/or sell copies of the Software, and to
        permit persons to whom the Software is furnished to do so, subject to
        the following conditions:

        The above copyright notice and this permission notice shall be included
        in all copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
        OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
        MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
        IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
        CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
        TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
        SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    ]]
}

path = ...

require(path .. ".src.StringExt")
require(path .. ".src.FormatTable")
require(path .. ".src.Switch")
local lexer = require(path .. ".src.Lexer")
local parser = require(path .. ".src.Parser")


function declang.parse(_str)
    local result = string.gsub(_str, "[\r\n\t]", "")

    -- find special tags --
    for tag in string.gmatch(_str, "%$(%b[])") do
        tag = tag:gsub("[%[%]]", "")
    end

    local lexrt = lexer(result)
    local tkn = lexrt:createTokens()

    local parsert = parser(tkn)
    local elements = parsert:run()

    return elements

end

return declang