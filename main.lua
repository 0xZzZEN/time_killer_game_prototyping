-- simple game where you use some sort of the gun to point at the flying clocks
-- time will slow down or speed up depending on randomseed when you grab an item

push = require "push"

-- gameStateStart
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

-- Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
function love.draw()
    love.graphics.printf('Time Killer', 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center')               -- alignment mode, can be 'center', 'left', or 'right'
end