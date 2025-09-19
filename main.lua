-- simple game where you use some sort of the gun to point at the flying clocks
-- time will slow down or speed up depending on randomseed when you grab an item


-- add support for virtual screen res
push = require "/lib/push"

-- add support for class
Class = require "/lib/class"


-- prototyping scale
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 900

-- test size
VIRTUAL_WIDTH = 500
VIRTUAL_HEIGHT = 400

-- running text
TEXT_X = -120
TEXT_SPEED = 150 -- how fast text is going to be running


-- gameStateStart
function love.load()

    --apply filter to decrease blureness
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --set title of the game
    love.window.setTitle("Time Killer Alpha ver")
    
    --[[initialize and load font
    kreativ = love.graphics.newFont('/graphics/Kreativ.otf', 20)
    cookie_crisp = love.graphics.newFont('/graphics/cookiecrisp.ttf', 28)]]
    base_font = love.graphics.newFont('/graphics/fonts/press_start_2p.ttf', 12)
    love.graphics.setFont(base_font)
    
    -- initialise window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false, resizable = true, vsync = true})

    gameState = "start"
end

function love.update(dt)
    TEXT_X = TEXT_X + TEXT_SPEED * dt 
    -- if text left boundary goes to the end of screen width, it restarts at x again
    if TEXT_X > VIRTUAL_WIDTH then
        TEXT_X = -120
    end
end

function love.keypressed(key)
    if key == "enter" then
        if gameState == "start" then
            gameState = "play"
        else
            gameState = "start"
            -- reset entities
        end
    elseif key == "escape" then
        -- set a flag
        --isExiting = true
        --love.graphics.printf('Would you like to exit? Y/N', 150, VIRTUAL_HEIGHT / 2 - 15, VIRTUAL_WIDTH, 'center')
        love.event.quit()
    end    
end

-- Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')
    
    -- render text on start state
    love.graphics.printf('Time Killer Alpha ver', 0, VIRTUAL_HEIGHT / 2 - 15, VIRTUAL_WIDTH, 'center')  
    love.graphics.printf('Tic-taaac /\\', TEXT_X, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('To start a game, press enter', VIRTUAL_WIDTH / 24 - 20, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')

    love.graphics.printf(('Current Game State: %s'):format(gameState), 10, 30, VIRTUAL_WIDTH, 'left')

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')
    end
    
    -- render monitor res, FPS
    displayFPS()

    
    -- finish rendering at virtual res
    push:apply('end')
end

function love.resize(w, h)
    push:resize(w, h)
end

function displayFPS()
    -- display info
    _, _, flags = love.window.getMode()

    -- The window's flags contain the index of the monitor it's currently in.
    width, height = love.window.getDesktopDimensions(flags.display)

    -- render fps
    fps = love.timer.getFPS()
    love.graphics.printf(("display %d: %d x %d, FPS: %d"):format(flags.display, width, height, fps), 4, 10, VIRTUAL_WIDTH, "center")
end