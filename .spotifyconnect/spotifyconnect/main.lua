-- Define the path to the librespot binary
local librespotPath = "../librespot/librespot"

-- Initialize status and button details
local status = "Checking status..."
local statusColor = {1, 1, 1}  -- Default color (white)
local buttonList = {
    {"Enable Spotify Connect",""},
    {"Disable Spotify Connect"}
}
local selectedRow = 1
local numRows = #buttonList
local buttonWidth = 200
local buttonHeight = 50
local buttonPadding = 20
local buttonColor = {0.2, 0.2, 0.2}
local selectedButtonColor = {0.4, 0.6, 1}
local textColor = {1, 1, 1}
local selectedTextColor = {1, 1, 1}

-- Initialize debug variables
local debugInfo = {
    selectedRow = selectedRow,
    joystickAxisX = 0,
    joystickButtonA = false,
    joystickDpadLeft = false,
    joystickDpadRight = false
}

-- Function to check if librespot is running
local function checkLibrespotStatus()
    local handle = io.popen("pgrep -f '" .. librespotPath .. "'")
    local result = handle:read("*a")
    handle:close()
    
    return result and #result > 0
end

-- Function to start librespot
local function startLibrespot()
    if not checkLibrespotStatus() then
        os.execute("nohup nice --20 '" .. librespotPath .. "' --name 'MyDevice' --cache '/tmp' --enable-volume-normalisation --normalisation-pregain 0 &")
        love.timer.sleep(0.5)  -- Give the process time to start
    end
end

-- Function to stop librespot
local function stopLibrespot()
    if checkLibrespotStatus() then
        os.execute("pkill -f '" .. librespotPath .. "'")
        love.timer.sleep(0.5)  -- Give the process time to stop
    end
end

-- Load function to initialize variables and check initial status
function love.load()
    love.graphics.setFont(love.graphics.newFont(20))
    love.window.setTitle("Librespot Controller")
    
    -- Initial status check
    if checkLibrespotStatus() then
        status = "librespot is running"
        statusColor = {0, 1, 0}  -- Green color
    else
        status = "librespot is not running"
        statusColor = {1, 0, 0}  -- Red color
    end
end

-- Function to draw buttons
local function drawButtons()
    for row = 1, numRows do
        local x = 100 + (row - 1) * (buttonWidth + buttonPadding)
        local y = 200
        local isSelected = (row == selectedRow)
        
        -- Set color based on selection state
        love.graphics.setColor(isSelected and selectedButtonColor or buttonColor)
        love.graphics.rectangle("fill", x, y, buttonWidth, buttonHeight)
        
        -- Set text color based on selection state
        love.graphics.setColor(isSelected and selectedTextColor or textColor)
        love.graphics.printf(buttonList[row][1], x, y + buttonHeight / 4, buttonWidth, "center")
    end
end

-- Function to update the status dynamically
local function updateStatus()
    if checkLibrespotStatus() then
        status = "librespot is running"
        statusColor = {0, 1, 0}  -- Green color
    else
        status = "librespot is not running"
        statusColor = {1, 0, 0}  -- Red color
    end
end

-- Function to handle input
local function handleInput()
    local joystick = love.joystick.getJoysticks()[1]
    local moveLeft, moveRight, selectButton = false, false, false

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        moveLeft = true
    elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        moveRight = true
    elseif love.keyboard.isDown("return") or love.keyboard.isDown("space") then
        selectButton = true
    end

    -- Check joystick input
    if joystick then
        local axisX = joystick:getAxis(1)  -- X-axis of the left stick
        debugInfo.joystickAxisX = axisX
        if axisX < -0.2 then
            moveLeft = true
        elseif axisX > 0.2 then
            moveRight = true
        end

        debugInfo.joystickButtonA = joystick:isGamepadDown("a")
        debugInfo.joystickDpadLeft = joystick:isGamepadDown("dpleft")
        debugInfo.joystickDpadRight = joystick:isGamepadDown("dpright")

        if joystick:isGamepadDown("a") then
            selectButton = true
        end
    end

    -- Handle navigation
    if moveLeft then
        selectedRow = math.max(1, selectedRow - 1)
        love.timer.sleep(0.2)  -- Add a slight delay to prevent rapid input
    elseif moveRight then
        selectedRow = math.min(numRows, selectedRow + 1)
        love.timer.sleep(0.2)
    elseif selectButton then
        if selectedRow == 1 then
            startLibrespot()
        elseif selectedRow == 2 then
            stopLibrespot()
        end
        love.timer.sleep(0.2)
    end

    -- Update status after input to reflect any changes
    updateStatus()
    debugInfo.selectedRow = selectedRow
end

-- Update function to handle input
function love.update(dt)
    handleInput()
end

-- Function to draw debug information
local function drawDebugInfo()
    love.graphics.setColor(1, 1, 1)
    local debugText = string.format(
        "Debug Info:\nSelected Row: %d\nJoystick Axis X: %.2f\nJoystick Button A: %s\nJoystick Dpad Left: %s\nJoystick Dpad Right: %s",
        debugInfo.selectedRow,
        debugInfo.joystickAxisX,
        tostring(debugInfo.joystickButtonA),
        tostring(debugInfo.joystickDpadLeft),
        tostring(debugInfo.joystickDpadRight)
    )
    love.graphics.print(debugText, 10, love.graphics.getHeight() - 150)
end

-- Draw function to display status, buttons, and debug info
function love.draw()
    love.graphics.clear(0.2, 0.2, 0.2)  -- Clear the screen to a dark grey color
    
    -- Draw the status at the top
    love.graphics.setColor(statusColor)
    love.graphics.printf(status, 0, 50, love.graphics.getWidth(), "center")
    
    -- Draw the buttons
    drawButtons()

    -- Draw debug information
    drawDebugInfo()
end
