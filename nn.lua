-- SimpleUILibrary.lua
local SimpleUILibrary = {}

-- Функція для створення екранної GUI
function SimpleUILibrary:CreateScreenGui(parent)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = parent or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    return screenGui
end

-- Функція для створення панелі
function SimpleUILibrary:CreateFrame(screenGui, size, position, color)
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(0.3, 0, 0.3, 0)
    frame.Position = position or UDim2.new(0.5, -100, 0.5, -100)
    frame.BackgroundColor3 = color or Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    return frame
end

-- Функція для створення кнопки
function SimpleUILibrary:CreateButton(parent, text, size, position, color)
    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0.3, 0, 0.1, 0)
    button.Position = position or UDim2.new(0.5, -50, 0.5, -50)
    button.BackgroundColor3 = color or Color3.fromRGB(70, 130, 180)
    button.Text = text or "Button"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Parent = parent
    return button
end

-- Функція для створення тексту
function SimpleUILibrary:CreateLabel(parent, text, size, position, color)
    local label = Instance.new("TextLabel")
    label.Size = size or UDim2.new(0.3, 0, 0.1, 0)
    label.Position = position or UDim2.new(0.5, -50, 0.5, -100)
    label.BackgroundTransparency = 1
    label.Text = text or "Label"
    label.TextColor3 = color or Color3.new(1, 1, 1)
    label.Parent = parent
    return label
end

-- Функція для створення повзунка
function SimpleUILibrary:CreateSlider(parent, size, position)
    local slider = Instance.new("Frame")
    slider.Size = size or UDim2.new(0.5, 0, 0.05, 0)
    slider.Position = position or UDim2.new(0.25, 0, 0.6, 0)
    slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    slider.Parent = parent

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0.05, 0, 1, 0)
    knob.Position = UDim2.new(0, 0, 0, 0)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = slider

    -- Робимо переміщення ручки повзунка
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local dragging = true
            local function updatePosition(input)
                local scale = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                knob.Position = UDim2.new(scale, 0, 0, 0)
            end
            updatePosition(input)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    return slider
end

return SimpleUILibrary
