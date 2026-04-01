-- KEY SYSTEM
local KEY = "DARKZ"

local KeyGui = Instance.new("ScreenGui", game.CoreGui)

local Frame = Instance.new("Frame", KeyGui)
Frame.Size = UDim2.new(0,250,0,150)
Frame.Position = UDim2.new(0.5,-125,0.5,-75)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "ENTER KEY"
Title.TextScaled = true
Title.BackgroundColor3 = Color3.fromRGB(40,40,40)
Title.BorderSizePixel = 0
Title.TextColor3 = Color3.new(1,1,1)

local Box = Instance.new("TextBox", Frame)
Box.Size = UDim2.new(1,-20,0,35)
Box.Position = UDim2.new(0,10,0,55)
Box.PlaceholderText = "DIGITE A KEY"
Box.Text = ""
Box.TextScaled = true
Box.BackgroundColor3 = Color3.fromRGB(35,35,35)
Box.TextColor3 = Color3.new(1,1,1)
Box.BorderSizePixel = 0

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1,-20,0,35)
Button.Position = UDim2.new(0,10,0,100)
Button.Text = "CONFIRMAR"
Button.TextScaled = true
Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
Button.TextColor3 = Color3.new(1,1,1)
Button.BorderSizePixel = 0

local unlocked = false

Button.MouseButton1Click:Connect(function()
	if Box.Text == KEY then
		unlocked = true
		KeyGui:Destroy()
	else
		Box.Text = ""
		Box.PlaceholderText = "KEY ERRADA"
	end
end)

repeat task.wait() until unlocked
-- @enx.amz MOBILE GUI
-- ESP + DISTÂNCIA + AIM HEAD + FOV SLIDER
-- DRAG FIX + LOCK + MINIMIZE

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- FLAGS
local ESP_ON = false
local AIM_ON = false
local GUI_LOCKED = false
local minimized = false

-- FOV CONFIG
local MIN_FOV, MAX_FOV = 50, 350
local FOV_RADIUS = 140

-- FOV CIRCLE
local FOV = Drawing.new("Circle")
FOV.Color = Color3.fromRGB(255,0,0)
FOV.Thickness = 2
FOV.Filled = false
FOV.Visible = false
FOV.Radius = FOV_RADIUS

-- ESP STORAGE
local ESP = {}

local function Alive(plr)
    return plr.Character
        and plr.Character:FindFirstChild("Humanoid")
        and plr.Character.Humanoid.Health > 0
end

local function CreateESP(plr)
    if plr == LocalPlayer then return end

    local box = Drawing.new("Square")
    box.Color = Color3.fromRGB(255,0,0)
    box.Thickness = 2
    box.Filled = false
    box.Visible = false

    local text = Drawing.new("Text")
    text.Color = Color3.fromRGB(255,255,255)
    text.Size = 14
    text.Center = true
    text.Outline = true
    text.Visible = false

    ESP[plr] = {
        Box = box,
        Text = text
    }
end

for _,p in pairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)

local Main = Instance.new("Frame", gui)
Main.Size = UDim2.new(0,240,0,260)
Main.Position = UDim2.new(0,40,0,200)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.BorderSizePixel = 0
Main.Active = true

-- TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundColor3 = Color3.fromRGB(40,40,40)
Title.Text = "darkk.zz"
Title.TextScaled = true
Title.BorderSizePixel = 0
Title.Active = true

-- RGB TITLE
task.spawn(function()
    local h = 0
    while Title.Parent do
        h = (h + 0.005) % 1
        Title.TextColor3 = Color3.fromHSV(h,1,1)
        task.wait()
    end
end)

-- BUTTON CREATOR
local function Button(txt, y)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(1,-20,0,35)
    b.Position = UDim2.new(0,10,0,y)
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)
    b.TextScaled = true
    b.Text = txt
    b.BorderSizePixel = 0
    return b
end

local espBtn  = Button("ESP OFF", 45)
local aimBtn  = Button("AIM OFF", 85)
local lockBtn = Button("GUI: LIVRE", 125)
local minBtn  = Button("MINIMIZAR", 165)

-- SLIDER FOV
local SliderBG = Instance.new("Frame", Main)
SliderBG.Size = UDim2.new(1,-20,0,10)
SliderBG.Position = UDim2.new(0,10,0,215)
SliderBG.BackgroundColor3 = Color3.fromRGB(80,80,80)
SliderBG.BorderSizePixel = 0
SliderBG.Active = true

local SliderFill = Instance.new("Frame", SliderBG)
SliderFill.Size = UDim2.new(0.4,0,1,0)
SliderFill.BackgroundColor3 = Color3.fromRGB(255,0,0)
SliderFill.BorderSizePixel = 0

local SliderBtn = Instance.new("Frame", SliderBG)
SliderBtn.Size = UDim2.new(0,16,0,16)
SliderBtn.Position = UDim2.new(0.4,-8,0.5,-8)
SliderBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
SliderBtn.BorderSizePixel = 0
SliderBtn.Active = true

-- MINI BUTTON
local MiniBtn = Instance.new("TextButton", gui)
MiniBtn.Size = UDim2.new(0,48,0,48)
MiniBtn.Position = UDim2.new(0,20,0,120)
MiniBtn.Text = "zz"
MiniBtn.TextScaled = true
MiniBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
MiniBtn.Visible = false
MiniBtn.Active = true
MiniBtn.BorderSizePixel = 0

task.spawn(function()
    local h = 0
    while MiniBtn.Parent do
        h = (h + 0.01) % 1
        MiniBtn.TextColor3 = Color3.fromHSV(h,1,1)
        task.wait()
    end
end)

-- BUTTON LOGIC
espBtn.MouseButton1Click:Connect(function()
    ESP_ON = not ESP_ON
    espBtn.Text = ESP_ON and "ESP ON" or "ESP OFF"
end)

aimBtn.MouseButton1Click:Connect(function()
    AIM_ON = not AIM_ON
    aimBtn.Text = AIM_ON and "AIM ON" or "AIM OFF"
    FOV.Visible = AIM_ON
end)

lockBtn.MouseButton1Click:Connect(function()
    GUI_LOCKED = not GUI_LOCKED
    lockBtn.Text = GUI_LOCKED and "GUI: TRAVADO" or "GUI: LIVRE"
end)

local function ToggleMenu()
    minimized = not minimized
    Main.Visible = not minimized
    MiniBtn.Visible = minimized
end

minBtn.MouseButton1Click:Connect(ToggleMenu)
MiniBtn.MouseButton1Click:Connect(ToggleMenu)

-- DRAG MAIN (TITLE ONLY)
local dragGui, guiTouch, gStart, gPos

Title.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch and not GUI_LOCKED then
        dragGui = true
        guiTouch = i
        gStart = i.Position
        gPos = Main.Position
    end
end)

Title.InputEnded:Connect(function(i)
    if i == guiTouch then dragGui = false end
end)

UIS.InputChanged:Connect(function(i)
    if dragGui and i == guiTouch then
        local d = i.Position - gStart
        Main.Position = UDim2.new(gPos.X.Scale, gPos.X.Offset+d.X, gPos.Y.Scale, gPos.Y.Offset+d.Y)
    end
end)

-- DRAG MINI BUTTON
local dragMini, mTouch, mStart, mPos

MiniBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        dragMini = true
        mTouch = i
        mStart = i.Position
        mPos = MiniBtn.Position
    end
end)

MiniBtn.InputEnded:Connect(function(i)
    if i == mTouch then dragMini = false end
end)

UIS.InputChanged:Connect(function(i)
    if dragMini and i == mTouch then
        local d = i.Position - mStart
        MiniBtn.Position = UDim2.new(mPos.X.Scale, mPos.X.Offset+d.X, mPos.Y.Scale, mPos.Y.Offset+d.Y)
    end
end)

-- SLIDER LOGIC
local sliding, sTouch = false, nil

local function updateSlider(i)
    local x = (i.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X
    x = math.clamp(x,0,1)
    SliderBtn.Position = UDim2.new(x,-8,0.5,-8)
    SliderFill.Size = UDim2.new(x,0,1,0)
    FOV_RADIUS = math.floor(MIN_FOV + (MAX_FOV-MIN_FOV)*x)
    FOV.Radius = FOV_RADIUS
end

SliderBG.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        sliding = true
        sTouch = i
        updateSlider(i)
    end
end)

SliderBG.InputEnded:Connect(function(i)
    if i == sTouch then sliding = false end
end)

UIS.InputChanged:Connect(function(i)
    if sliding and i == sTouch then updateSlider(i) end
end)

-- TARGET
local function GetTarget()
    local best, dist = nil, FOV_RADIUS
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and Alive(p) and p.Character:FindFirstChild("Head") then
            local pos,on = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if on then
                local m = (Vector2.new(pos.X,pos.Y)-center).Magnitude
                if m < dist then dist, best = m, p end
            end
        end
    end
    return best
end

-- LOOP
RunService.RenderStepped:Connect(function()
    FOV.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    -- ESP + DISTÂNCIA
    for plr,esp in pairs(ESP) do
        local box = esp.Box
        local text = esp.Text

        if ESP_ON and Alive(plr)
        and LocalPlayer.Character
        and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local myHrp = LocalPlayer.Character.HumanoidRootPart

            if hrp then
                local pos,on = Camera:WorldToViewportPoint(hrp.Position)
                if on then
                    local dist = math.floor((hrp.Position - myHrp.Position).Magnitude)

                    box.Visible = true
                    box.Size = Vector2.new(40,60)
                    box.Position = Vector2.new(pos.X-20,pos.Y-30)

                    text.Visible = true
                    text.Text = dist.."m"
                    text.Position = Vector2.new(pos.X, pos.Y + 35)
                else
                    box.Visible = false
                    text.Visible = false
                end
            else
                box.Visible = false
                text.Visible = false
            end
        else
            box.Visible = false
            text.Visible = false
        end
    end

    -- AIM
    if AIM_ON then
        local t = GetTarget()
        if t and t.Character and t.Character:FindFirstChild("Head") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character.Head.Position)
        end
    end
end)

