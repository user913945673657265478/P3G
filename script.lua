local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local Colors = {
    MainBg    = Color3.fromRGB(25, 25, 28),
    SidebarBg = Color3.fromRGB(20, 20, 22),
    ItemBg    = Color3.fromRGB(40, 40, 45),
    Text      = Color3.fromRGB(240, 240, 240),
    SubText   = Color3.fromRGB(140, 140, 150),
    Accent    = Color3.fromRGB(255, 255, 255),
    Green     = Color3.fromRGB(80, 200, 120),
    Red       = Color3.fromRGB(200, 50, 50),
    DarkGrey  = Color3.fromRGB(60, 60, 65),
    Divider   = Color3.fromRGB(60, 60, 65),
}

local GradColor1 = Color3.fromRGB(120, 15, 15)
local GradColor2 = Color3.fromRGB(5, 5, 5)

local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do obj[k] = v end
    return obj
end

local function AddCorner(parent, radius)
    return Create("UICorner", {CornerRadius = UDim.new(0, radius or 6), Parent = parent})
end

local function AddStroke(parent, color, thickness)
    return Create("UIStroke", {Color = color or Colors.Divider, Thickness = thickness or 1, Parent = parent})
end

if CoreGui:FindFirstChild("P3G_KeySystem") then
    CoreGui:FindFirstChild("P3G_KeySystem"):Destroy()
end

local Blur = Lighting:FindFirstChild("P3G_KeyBlur") or Create("BlurEffect", {
    Name = "P3G_KeyBlur", Size = 0, Parent = Lighting
})

local ScreenGui = Create("ScreenGui", {
    Name = "P3G_KeySystem",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = CoreGui
})

local Backdrop = Create("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 0.5,
    BorderSizePixel = 0,
    Active = true,
    Parent = ScreenGui
})

local MainFrame = Create("Frame", {
    Name = "Main",
    Size = UDim2.new(0, 0, 0, 0),
    Position = UDim2.new(0.5, -225, 0.5, -160),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 0.15,
    BorderSizePixel = 0,
    Parent = ScreenGui
})
AddCorner(MainFrame, 12)
AddStroke(MainFrame, Color3.fromRGB(80, 80, 80), 1)

Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, GradColor1),
        ColorSequenceKeypoint.new(1, GradColor2)
    }),
    Rotation = 135,
    Parent = MainFrame
})

task.spawn(function()
    task.wait(0.1)
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 450, 0, 320)
    }):Play()
    TweenService:Create(Blur, TweenInfo.new(0.4), {Size = 10}):Play()
    Blur.Enabled = true
end)

local TopBar = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 45),
    BackgroundTransparency = 1,
    Parent = MainFrame
})

Create("TextLabel", {
    Text = "P3G KEY SYSTEM",
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextColor3 = Colors.Text,
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 200, 1, 0),
    Position = UDim2.new(0.5, -100, 0, 0),
    Parent = TopBar
})

Create("Frame", {
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = Colors.Divider,
    BackgroundTransparency = 0.5,
    BorderSizePixel = 0,
    Parent = TopBar
})

Create("TextLabel", {
    Text = "VERIFICATION REQUIRED",
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = Colors.Text,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -40, 0, 25),
    Position = UDim2.new(0, 20, 0, 60),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = MainFrame
})

Create("TextLabel", {
    Text = "Enter a valid key to continue",
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextColor3 = Colors.SubText,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -40, 0, 18),
    Position = UDim2.new(0, 20, 0, 88),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = MainFrame
})

local keyBoxContainer = Create("Frame", {
    Size = UDim2.new(1, -40, 0, 50),
    Position = UDim2.new(0, 20, 0, 120),
    BackgroundColor3 = Colors.ItemBg,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
    Parent = MainFrame
})
AddCorner(keyBoxContainer, 8)
AddStroke(keyBoxContainer, Colors.Divider, 1)

local keyBox = Create("TextBox", {
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = "",
    PlaceholderText = "Enter your key here...",
    PlaceholderColor3 = Colors.SubText,
    TextColor3 = Colors.Text,
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    Parent = keyBoxContainer
})

local verifyBtn = Create("TextButton", {
    Size = UDim2.new(1, -40, 0, 45),
    Position = UDim2.new(0, 20, 0, 185),
    BackgroundColor3 = Colors.ItemBg,
    BackgroundTransparency = 0.5,
    TextColor3 = Colors.Text,
    Text = "VERIFY",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    AutoButtonColor = false,
    Parent = MainFrame
})
AddCorner(verifyBtn, 8)
AddStroke(verifyBtn, Colors.Divider, 1)

verifyBtn.MouseEnter:Connect(function()
    TweenService:Create(verifyBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Colors.ItemBg,
        BackgroundTransparency = 0.3
    }):Play()
end)
verifyBtn.MouseLeave:Connect(function()
    TweenService:Create(verifyBtn, TweenInfo.new(0.2), {
        BackgroundTransparency = 0.5
    }):Play()
end)

local status = Create("TextLabel", {
    Size = UDim2.new(1, -40, 0, 25),
    Position = UDim2.new(0, 20, 0, 245),
    BackgroundTransparency = 1,
    Text = "",
    TextColor3 = Colors.Red,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = MainFrame
})

local validKeys = {"6767", "7676"}
local isVerifying = false

local function verifyKey()
    if isVerifying then return end
    isVerifying = true

    local inputKey = keyBox.Text
    local isValid = false
    for _, validKey in ipairs(validKeys) do
        if inputKey == validKey then
            isValid = true
            break
        end
    end

    if isValid then
        status.Text = "Correct key! Loading hub..."
        status.TextColor3 = Colors.Green
        
        verifyBtn.Active = false
        verifyBtn.AutoButtonColor = false

        TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(Backdrop, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Blur, TweenInfo.new(0.6), {Size = 0}):Play()

        task.wait(0.6)
        Blur.Enabled = false
        ScreenGui:Destroy()

        loadstring(game:HttpGet("https://raw.githubusercontent.com/user913945673657265478/P3G/refs/heads/main/P3G.lua"))()
    else
        status.Text = "Incorrect key! Please try again."
        status.TextColor3 = Colors.Red

        local originalPos = MainFrame.Position
        for i = 1, 3 do
            task.wait(0.05)
            MainFrame.Position = UDim2.new(0.5, -225 + (i % 2 == 0 and 10 or -10), 0.5, -160)
        end
        MainFrame.Position = originalPos

        keyBox.Text = ""
        keyBox:CaptureFocus()

        TweenService:Create(verifyBtn, TweenInfo.new(0.1), {BackgroundColor3 = Colors.Red, BackgroundTransparency = 0.3}):Play()
        task.wait(0.2)
        TweenService:Create(verifyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ItemBg, BackgroundTransparency = 0.5}):Play()
    end

    isVerifying = false
end

verifyBtn.MouseButton1Click:Connect(verifyKey)
keyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then verifyKey() end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Escape then
    end
end)

task.spawn(function()
    while ScreenGui.Parent do
        if not ScreenGui.Enabled then
            ScreenGui.Enabled = true
        end
        task.wait(1)
    end
end)