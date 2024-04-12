local nox = {
    _VERSION  = "Nox v0.0.1",
    _DESCRIPTION = "Wrapper for the loveframes library, implementing a simple declarative language",
    _LICENSE = [[
        MIT LICENSE

        Copyright (c) 2024 Gabriella Olveira Schultz

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

LIBPATH = ...
loveframes = require(LIBPATH .. ".libraries.loveframes")
local desclang = require(LIBPATH .. ".libraries.declang")
require(LIBPATH .. ".libraries.declang.src.FormatTable")
local elementmanager = require(LIBPATH .. ".ElementManager")

function nox.load(_src)
    local tree = desclang.parse(_src)
    elementmanager.init()
    elementmanager.load(tree)
end

function nox.draw()
    loveframes.draw()
end

function nox.update(elapsed)
    loveframes.update(elapsed)
end

function nox.mousepressed(x, y, button)
    loveframes.mousepressed(x, y, button)
end

function nox.mousereleased(x, y, button)
    loveframes.mousereleased(x, y, button)
end

function nox.keypressed(k, scancode, isrepeat)
    loveframes.keypressed(k, scancode, isrepeat)
end

function nox.keyreleased(k, scancode, isrepeat)
    loveframes.keyreleased(k, scancode, isrepeat)
end

function nox.textinput(t)
    loveframes.textinput(t)
end

return nox