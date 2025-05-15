-- FluxionUI.lua
local FluxionUI = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Store current tab to parent UI elements to
FluxionUI.CurrentTab = nil

-- Create a window
function FluxionUI:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FluxionUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = screenGui

    -- Top User Info Section
    local userInfoFrame = Instance.new("Frame")
    userInfoFrame.Size = UDim2.new(1, 0, 0, 50)
    userInfoFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    userInfoFrame.BorderSizePixel = 0
    userInfoFrame.Parent = mainFrame

    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 40, 0, 40)
    avatar.Position = UDim2.new(0, 5, 0.5, -20)
    avatar.BackgroundTransparency = 1
    avatar.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", LocalPlayer.UserId)
    avatar.Parent = userInfoFrame

    local username = Instance.new("TextLabel")
    username.Size = UDim2.new(1, -55, 1, 0)
    username.Position = UDim2.new(0, 50, 0, 0)
    username.BackgroundTransparency = 1
    username.Text = LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")"
    username.TextColor3 = Color3.new(1, 1, 1)
    username.Font = Enum.Font.Gotham
    username.TextSize = 16
    username.TextXAlignment = Enum.TextXAlignment.Left
    username.Parent = userInfoFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 50)
    titleLabel.Text = title
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.Parent = mainFrame

    FluxionUI.MainFrame = mainFrame
    FluxionUI.ScreenGui = screenGui

    -- Keybind to toggle visibility (e.g. RightShift)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.K then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    -- Classic Roblox-style notification
    task.spawn(function()
        local success, err = pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Fluxion UI",
                Text = "Loaded successfully!",
                Duration = 5
            })
        end)
        if not success then
            warn("Notification failed:", err)
        end
    end)

    return FluxionUI
end

-- Create a tab (simple vertical layout for now)
function FluxionUI:CreateTab(name)
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 1, -80)
    tabFrame.Position = UDim2.new(0, 0, 0, 80)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Name = name
    tabFrame.Parent = FluxionUI.MainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = tabFrame

    FluxionUI.CurrentTab = tabFrame
    return FluxionUI
end

-- Create a button
function FluxionUI:CreateButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.AutoButtonColor = true
    button.Parent = FluxionUI.CurrentTab

    button.MouseButton1Click:Connect(function()
        if callback then
            pcall(callback)
        end
    end)

    return button
end

-- Create a label
function FluxionUI:CreateLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.Text = text
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = FluxionUI.CurrentTab

    return label
end

return FluxionUI
