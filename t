local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PetStealerGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer.PlayerGui

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 200)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(26, 26, 46)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Frame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundColor3 = Color3.fromRGB(108, 63, 197)
Header.BorderSizePixel = 0
Header.Parent = Frame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local HeaderLabel = Instance.new("TextLabel")
HeaderLabel.Text = "🐾 GAG2 Pet Stealer"
HeaderLabel.Size = UDim2.new(1, -8, 1, 0)
HeaderLabel.Position = UDim2.new(0, 8, 0, 0)
HeaderLabel.BackgroundTransparency = 1
HeaderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderLabel.TextSize = 11
HeaderLabel.Font = Enum.Font.GothamBold
HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
HeaderLabel.Parent = Header

-- Dragging
local dragging = false
local dragStart = nil
local startPos = nil

Header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
	end
end)

Header.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement or
			input.UserInputType == Enum.UserInputType.Touch
		) then
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Search Box
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -14, 0, 24)
SearchBox.Position = UDim2.new(0, 7, 0, 36)
SearchBox.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
SearchBox.BorderSizePixel = 0
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderText = "Search player..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 150)
SearchBox.TextSize = 10
SearchBox.Font = Enum.Font.Gotham
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = Frame

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 5)
SearchCorner.Parent = SearchBox

-- Player List
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Size = UDim2.new(1, -14, 0, 85)
ListFrame.Position = UDim2.new(0, 7, 0, 66)
ListFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
ListFrame.BorderSizePixel = 0
ListFrame.ScrollBarThickness = 3
ListFrame.Visible = true
ListFrame.Parent = Frame

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 6)
ListCorner.Parent = ListFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 3)
ListLayout.Parent = ListFrame

-- Avatar Panel (same size as list)
local AvatarPanel = Instance.new("Frame")
AvatarPanel.Size = UDim2.new(1, -14, 0, 85)
AvatarPanel.Position = UDim2.new(0, 7, 0, 66)
AvatarPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
AvatarPanel.BorderSizePixel = 0
AvatarPanel.Visible = false
AvatarPanel.Parent = Frame

local AvatarPanelCorner = Instance.new("UICorner")
AvatarPanelCorner.CornerRadius = UDim.new(0, 6)
AvatarPanelCorner.Parent = AvatarPanel

-- Avatar image (smaller to leave room for name)
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Size = UDim2.new(0, 44, 0, 44)
AvatarImage.Position = UDim2.new(0.5, -22, 0, 4)
AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 62)
AvatarImage.BorderSizePixel = 0
AvatarImage.Image = ""
AvatarImage.Parent = AvatarPanel

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0, 50)
AvatarCorner.Parent = AvatarImage

-- Player name — full width, wraps if needed
local AvatarName = Instance.new("TextLabel")
AvatarName.Size = UDim2.new(1, -8, 0, 18)
AvatarName.Position = UDim2.new(0, 4, 0, 50)
AvatarName.BackgroundTransparency = 1
AvatarName.TextColor3 = Color3.fromRGB(192, 176, 255)
AvatarName.TextSize = 10
AvatarName.Font = Enum.Font.GothamBold
AvatarName.Text = ""
AvatarName.TextXAlignment = Enum.TextXAlignment.Center
AvatarName.TextWrapped = true
AvatarName.ClipsDescendants = false
AvatarName.Parent = AvatarPanel

-- Back button right below name
local BackBtn = Instance.new("TextButton")
BackBtn.Size = UDim2.new(1, -10, 0, 16)
BackBtn.Position = UDim2.new(0, 5, 0, 67)
BackBtn.BackgroundColor3 = Color3.fromRGB(50, 40, 90)
BackBtn.BorderSizePixel = 0
BackBtn.TextColor3 = Color3.fromRGB(180, 160, 255)
BackBtn.TextSize = 9
BackBtn.Font = Enum.Font.Gotham
BackBtn.Text = "← Back to list"
BackBtn.Parent = AvatarPanel

local BackCorner = Instance.new("UICorner")
BackCorner.CornerRadius = UDim.new(0, 5)
BackCorner.Parent = BackBtn

-- Roblox-style Toast
local Toast = Instance.new("Frame")
Toast.Size = UDim2.new(0, 220, 0, 50)
Toast.Position = UDim2.new(1, 10, 1, -70)
Toast.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
Toast.BorderSizePixel = 0
Toast.Parent = ScreenGui

local ToastCorner = Instance.new("UICorner")
ToastCorner.CornerRadius = UDim.new(0, 6)
ToastCorner.Parent = Toast

local ToastAccent = Instance.new("Frame")
ToastAccent.Size = UDim2.new(0, 4, 1, 0)
ToastAccent.Position = UDim2.new(0, 0, 0, 0)
ToastAccent.BackgroundColor3 = Color3.fromRGB(0, 162, 60)
ToastAccent.BorderSizePixel = 0
ToastAccent.Parent = Toast

local ToastAccentCorner = Instance.new("UICorner")
ToastAccentCorner.CornerRadius = UDim.new(0, 6)
ToastAccentCorner.Parent = ToastAccent

local ToastIconBg = Instance.new("Frame")
ToastIconBg.Size = UDim2.new(0, 34, 0, 34)
ToastIconBg.Position = UDim2.new(0, 12, 0.5, -17)
ToastIconBg.BackgroundColor3 = Color3.fromRGB(0, 162, 60)
ToastIconBg.BorderSizePixel = 0
ToastIconBg.Parent = Toast

local ToastIconBgCorner = Instance.new("UICorner")
ToastIconBgCorner.CornerRadius = UDim.new(0, 5)
ToastIconBgCorner.Parent = ToastIconBg

local ToastIcon = Instance.new("TextLabel")
ToastIcon.Size = UDim2.new(1, 0, 1, 0)
ToastIcon.BackgroundTransparency = 1
ToastIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
ToastIcon.TextSize = 18
ToastIcon.Text = "✔"
ToastIcon.Font = Enum.Font.GothamBold
ToastIcon.TextXAlignment = Enum.TextXAlignment.Center
ToastIcon.TextYAlignment = Enum.TextYAlignment.Center
ToastIcon.Parent = ToastIconBg

local ToastTitle = Instance.new("TextLabel")
ToastTitle.Size = UDim2.new(1, -58, 0, 16)
ToastTitle.Position = UDim2.new(0, 54, 0, 8)
ToastTitle.BackgroundTransparency = 1
ToastTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ToastTitle.TextSize = 11
ToastTitle.Font = Enum.Font.GothamBold
ToastTitle.Text = "Success"
ToastTitle.TextXAlignment = Enum.TextXAlignment.Left
ToastTitle.Parent = Toast

local ToastSub = Instance.new("TextLabel")
ToastSub.Size = UDim2.new(1, -58, 0, 14)
ToastSub.Position = UDim2.new(0, 54, 0, 26)
ToastSub.BackgroundTransparency = 1
ToastSub.TextColor3 = Color3.fromRGB(180, 180, 180)
ToastSub.TextSize = 9
ToastSub.Font = Enum.Font.Gotham
ToastSub.Text = "Successfully Dropped Pets!"
ToastSub.TextXAlignment = Enum.TextXAlignment.Left
ToastSub.Parent = Toast

local toastActive = false

local function showToast()
	if toastActive then return end
	toastActive = true
	TweenService:Create(Toast, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -230, 1, -70)
	}):Play()
	task.delay(2.8, function()
		local slideOut = TweenService:Create(Toast, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 10, 1, -70)
		})
		slideOut:Play()
		slideOut.Completed:Connect(function()
			toastActive = false
		end)
	end)
end

-- View switching
local selectedPlayer = nil

local function showAvatarPanel(player)
	selectedPlayer = player
	ListFrame.Visible = false
	SearchBox.Visible = false
	AvatarPanel.Visible = true
	AvatarName.Text = player.Name
	local content, _ = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
	AvatarImage.Image = content
end

local function showListPanel()
	selectedPlayer = nil
	AvatarPanel.Visible = false
	SearchBox.Visible = true
	ListFrame.Visible = true
	AvatarImage.Image = ""
	AvatarName.Text = ""
end

BackBtn.MouseButton1Click:Connect(showListPanel)

-- Player List populate
local function refreshList(filter)
	for _, child in ipairs(ListFrame:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			if filter == "" or player.Name:lower():find(filter:lower()) then
				local Btn = Instance.new("TextButton")
				Btn.Size = UDim2.new(1, -6, 0, 22)
				Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 62)
				Btn.BorderSizePixel = 0
				Btn.TextColor3 = Color3.fromRGB(192, 176, 255)
				Btn.TextSize = 10
				Btn.Font = Enum.Font.Gotham
				Btn.Text = player.Name
				Btn.TextTruncate = Enum.TextTruncate.AtEnd
				Btn.Parent = ListFrame

				local BtnCorner = Instance.new("UICorner")
				BtnCorner.CornerRadius = UDim.new(0, 5)
				BtnCorner.Parent = Btn

				Btn.MouseButton1Click:Connect(function()
					showAvatarPanel(player)
				end)
			end
		end
	end
	ListFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 6)
end

refreshList("")
SearchBox:GetPropertyChangedSignal("Text"):Connect(function() refreshList(SearchBox.Text) end)
Players.PlayerAdded:Connect(function() refreshList(SearchBox.Text) end)
Players.PlayerRemoving:Connect(function()
	if selectedPlayer and not Players:FindFirstChild(selectedPlayer.Name) then
		showListPanel()
	end
	refreshList(SearchBox.Text)
end)

-- Drop Button (sits right below avatar panel, no gap)
local DropBtn = Instance.new("TextButton")
DropBtn.Size = UDim2.new(1, -14, 0, 26)
DropBtn.Position = UDim2.new(0, 7, 0, 158)
DropBtn.BackgroundColor3 = Color3.fromRGB(108, 63, 197)
DropBtn.BorderSizePixel = 0
DropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DropBtn.TextSize = 10
DropBtn.Font = Enum.Font.GothamBold
DropBtn.Text = "Drop Equipped Pets"
DropBtn.Parent = Frame

local DropCorner = Instance.new("UICorner")
DropCorner.CornerRadius = UDim.new(0, 6)
DropCorner.Parent = DropBtn

DropBtn.MouseButton1Click:Connect(function()
	if selectedPlayer then
		-- game.ReplicatedStorage.DropPets:FireServer(selectedPlayer)
		print("Drop pets for: " .. selectedPlayer.Name)
		showToast()
	else
		print("Select a player first!")
	end
end)

-- Credit sits flush right below drop button, no gap
local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, 0, 0, 12)
Credit.Position = UDim2.new(0, 0, 0, 188)
Credit.BackgroundTransparency = 1
Credit.TextColor3 = Color3.fromRGB(90, 80, 140)
Credit.TextSize = 8
Credit.Font = Enum.Font.Gotham
Credit.Text = "Made by Viral Hub Scripts"
Credit.TextXAlignment = Enum.TextXAlignment.Center
Credit.Parent = Frame
