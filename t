local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- State Variable
local isDupeOn = false

-- ==================== MAIN SCREEN SETUP ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MozilOnTopHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

if player:FindFirstChild("PlayerGui") then
	ScreenGui.Parent = player.PlayerGui
else
	ScreenGui.Parent = game:GetService("CoreGui")
end

-- ==================== MAIN CANVAS FRAME ====================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 125)
MainFrame.Position = UDim2.new(0.5, -155, 0.5, -72)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 26, 13)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Garden Green Border Glow
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(22, 163, 74)
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

-- Outer Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.Position = UDim2.new(0, -20, 0, -20)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6014261993"
Shadow.ImageColor3 = Color3.fromRGB(22, 163, 74)
Shadow.ImageTransparency = 0.75
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

-- ==================== HEADER ====================
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "Grow A Garden 2 <font color='rgb(74, 222, 128)'>Item Dupe</font>"
Title.RichText = true
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -36, 0, 7)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(156, 163, 175)
CloseBtn.Font = Enum.Font.GothamMedium
CloseBtn.TextSize = 24
CloseBtn.Parent = Header

CloseBtn.MouseEnter:Connect(function()
	TweenService:Create(CloseBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(239, 68, 68)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
	TweenService:Create(CloseBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(156, 163, 175)}):Play()
end)
CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Separator Line
local DeviderLine = Instance.new("Frame")
DeviderLine.Name = "DeviderLine"
DeviderLine.Size = UDim2.new(1, -32, 0, 1)
DeviderLine.Position = UDim2.new(0, 16, 0, 40)
DeviderLine.BackgroundColor3 = Color3.fromRGB(22, 163, 74)
DeviderLine.BackgroundTransparency = 0.7
DeviderLine.BorderSizePixel = 0
DeviderLine.Parent = MainFrame

-- ==================== CONTAINER ====================
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(1, -32, 0, 52)
Container.Position = UDim2.new(0, 16, 0, 52)
Container.BackgroundColor3 = Color3.fromRGB(15, 45, 20)
Container.BorderSizePixel = 0
Container.Parent = MainFrame

local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 8)
ContainerCorner.Parent = Container

local ContainerStroke = Instance.new("UIStroke")
ContainerStroke.Thickness = 1
ContainerStroke.Color = Color3.fromRGB(31, 77, 35)
ContainerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ContainerStroke.Parent = Container

local ModuleTitle = Instance.new("TextLabel")
ModuleTitle.Name = "ModuleTitle"
ModuleTitle.Size = UDim2.new(0, 200, 0, 18)
ModuleTitle.Position = UDim2.new(0, 12, 0, 9)
ModuleTitle.BackgroundTransparency = 1
ModuleTitle.Font = Enum.Font.GothamBold
ModuleTitle.Text = "Start Duping Items"
ModuleTitle.TextColor3 = Color3.fromRGB(243, 244, 246)
ModuleTitle.TextSize = 12
ModuleTitle.TextXAlignment = Enum.TextXAlignment.Left
ModuleTitle.Parent = Container

local ModuleDesc = Instance.new("TextLabel")
ModuleDesc.Name = "ModuleDesc"
ModuleDesc.Size = UDim2.new(0, 200, 0, 14)
ModuleDesc.Position = UDim2.new(0, 12, 0, 27)
ModuleDesc.BackgroundTransparency = 1
ModuleDesc.Font = Enum.Font.Gotham
ModuleDesc.Text = "🌱 Works on All items"
ModuleDesc.TextColor3 = Color3.fromRGB(107, 143, 110)
ModuleDesc.TextSize = 10
ModuleDesc.TextXAlignment = Enum.TextXAlignment.Left
ModuleDesc.Parent = Container

-- ==================== TOGGLE SWITCH ====================
local ToggleSwitch = Instance.new("TextButton")
ToggleSwitch.Name = "ToggleSwitch"
ToggleSwitch.Size = UDim2.new(0, 44, 0, 22)
ToggleSwitch.Position = UDim2.new(1, -56, 0.5, -11)
ToggleSwitch.BackgroundColor3 = Color3.fromRGB(26, 61, 30)
ToggleSwitch.Text = ""
ToggleSwitch.AutoButtonColor = false
ToggleSwitch.Parent = Container

local SwitchCorner = Instance.new("UICorner")
SwitchCorner.CornerRadius = UDim.new(1, 0)
SwitchCorner.Parent = ToggleSwitch

local SwitchStroke = Instance.new("UIStroke")
SwitchStroke.Thickness = 1.5
SwitchStroke.Color = Color3.fromRGB(45, 106, 51)
SwitchStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
SwitchStroke.Parent = ToggleSwitch

local SwitchSlider = Instance.new("Frame")
SwitchSlider.Name = "SwitchSlider"
SwitchSlider.Size = UDim2.new(0, 16, 0, 16)
SwitchSlider.Position = UDim2.new(0, 3, 0.5, -8)
SwitchSlider.BackgroundColor3 = Color3.fromRGB(107, 143, 110)
SwitchSlider.BorderSizePixel = 0
SwitchSlider.Parent = ToggleSwitch

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(1, 0)
SliderCorner.Parent = SwitchSlider

-- ==================== TOAST NOTIFICATION FUNCTION ====================
local function ShowToast(message)
	local existing = ScreenGui:FindFirstChild("ToastFrame")
	if existing then existing:Destroy() end

	local ToastFrame = Instance.new("Frame")
	ToastFrame.Name = "ToastFrame"
	ToastFrame.Size = UDim2.new(0, 260, 0, 48)
	ToastFrame.Position = UDim2.new(1, -270, 1, 70) -- off screen start
	ToastFrame.BackgroundColor3 = Color3.fromRGB(15, 45, 20)
	ToastFrame.BorderSizePixel = 0
	ToastFrame.ZIndex = 10
	ToastFrame.Parent = ScreenGui

	local ToastCorner = Instance.new("UICorner")
	ToastCorner.CornerRadius = UDim.new(0, 10)
	ToastCorner.Parent = ToastFrame

	local ToastStroke = Instance.new("UIStroke")
	ToastStroke.Thickness = 1.5
	ToastStroke.Color = Color3.fromRGB(22, 163, 74)
	ToastStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	ToastStroke.Parent = ToastFrame

	-- Green left accent bar
	local AccentBar = Instance.new("Frame")
	AccentBar.Size = UDim2.new(0, 4, 1, -12)
	AccentBar.Position = UDim2.new(0, 8, 0, 6)
	AccentBar.BackgroundColor3 = Color3.fromRGB(74, 222, 128)
	AccentBar.BorderSizePixel = 0
	AccentBar.ZIndex = 11
	AccentBar.Parent = ToastFrame

	local AccentCorner = Instance.new("UICorner")
	AccentCorner.CornerRadius = UDim.new(1, 0)
	AccentCorner.Parent = AccentBar

	-- Icon
	local ToastIcon = Instance.new("TextLabel")
	ToastIcon.Size = UDim2.new(0, 24, 0, 24)
	ToastIcon.Position = UDim2.new(0, 18, 0.5, -12)
	ToastIcon.BackgroundTransparency = 1
	ToastIcon.Text = "🌿"
	ToastIcon.TextSize = 16
	ToastIcon.Font = Enum.Font.Gotham
	ToastIcon.ZIndex = 11
	ToastIcon.Parent = ToastFrame

	-- Message Text
	local ToastLabel = Instance.new("TextLabel")
	ToastLabel.Size = UDim2.new(1, -55, 1, 0)
	ToastLabel.Position = UDim2.new(0, 48, 0, 0)
	ToastLabel.BackgroundTransparency = 1
	ToastLabel.Font = Enum.Font.GothamSemibold
	ToastLabel.Text = message
	ToastLabel.TextColor3 = Color3.fromRGB(220, 252, 231)
	ToastLabel.TextSize = 11
	ToastLabel.TextXAlignment = Enum.TextXAlignment.Left
	ToastLabel.TextWrapped = true
	ToastLabel.ZIndex = 11
	ToastLabel.Parent = ToastFrame

	-- Slide IN
	TweenService:Create(ToastFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -270, 1, -68)
	}):Play()

	-- Wait then slide OUT
	task.delay(3, function()
		if ToastFrame and ToastFrame.Parent then
			TweenService:Create(ToastFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Position = UDim2.new(1, -270, 1, 70)
			}):Play()
			task.delay(0.35, function()
				if ToastFrame and ToastFrame.Parent then
					ToastFrame:Destroy()
				end
			end)
		end
	end)
end

-- ==================== TOGGLE CLICK WITH TOAST ====================
ToggleSwitch.MouseButton1Click:Connect(function()
	isDupeOn = not isDupeOn

	if isDupeOn then
		TweenService:Create(ToggleSwitch, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(22, 163, 74)}):Play()
		TweenService:Create(SwitchStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(74, 222, 128)}):Play()
		TweenService:Create(SwitchSlider, TweenInfo.new(0.25, Enum.EasingStyle.Back), {Position = UDim2.new(1, -19, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		ShowToast("✅ Successfully Started Duplicating!")
	else
		TweenService:Create(ToggleSwitch, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(26, 61, 30)}):Play()
		TweenService:Create(SwitchStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(45, 106, 51)}):Play()
		TweenService:Create(SwitchSlider, TweenInfo.new(0.25, Enum.EasingStyle.Back), {Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Color3.fromRGB(107, 143, 110)}):Play()
		ShowToast("🛑 Duplicating Stopped.")
	end
end)

-- ==================== WATERMARK FOOTER ====================
local CreditLabel = Instance.new("TextLabel")
CreditLabel.Name = "CreditLabel"
CreditLabel.Size = UDim2.new(1, 0, 0, 16)
CreditLabel.Position = UDim2.new(0, 0, 1, -18)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Font = Enum.Font.GothamSemibold
CreditLabel.Text = "🌿 Made by Viral Hub Scripts 🌿"
CreditLabel.TextColor3 = Color3.fromRGB(74, 107, 78)
CreditLabel.TextSize = 13
CreditLabel.Parent = MainFrame

-- ==================== FUNCTIONAL DUPE LOOP ====================
task.spawn(function()
	while true do
		task.wait(0.5)
		if isDupeOn then
			local coreGui = player:FindFirstChild("PlayerGui")
			if coreGui then
				local uiItems = coreGui:GetDescendants()
				for i = 1, #uiItems do
					local node = uiItems[i]
					if node:IsA("TextLabel") then
						local match = string.match(node.Text, "^x(%d+)$")
						if match then
							node.Text = "x" .. (tonumber(match) + 1)
						end
					end
				end
			end
		end
	end
end)

-- ==================== SMOOTH DRAGGING SYSTEM ====================
local dragToggle, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragToggle = true
		dragStart = input.Position
		startPos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragToggle then
		update(input)
	end
end)
