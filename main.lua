function love.load()
    math.randomseed(os.time())
    nox = require 'nox'

    nox.load(love.filesystem.read("Main.nox"))
end

function love.draw()
    nox.draw()
end

function love.update(elapsed)
    nox.update(elapsed)
end

function love.mousepressed(x, y, button)
    nox.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    nox.mousereleased(x, y, button)
end

function love.keypressed(key, scancode, isrepeat)
    nox.keypressed(key, isrepeat)
end

function love.keyreleased(key)
    nox.keyreleased(key)
end

function love.textinput(text)
    nox.textinput(text)
end
