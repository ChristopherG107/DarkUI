print(game.PlaceId)

--Get services
UIS = game:GetService("UserInputService")
TS = game:GetService("TweenService")
--Locals
GMainFrame = nil
GMainFrameActivePosition = nil
GInitilize = nil
Draggable = false
dragstart = nil
dragspeed = 0.01
StartPos = nil
ActivePart = nil
DarkUIConfig = nil

--Add the Configs
if not game.ReplicatedStorage:FindFirstChild("DarkUIConfig") then
	DarkUIConfig = Instance.new("Folder",game.ReplicatedStorage)
	DarkUIConfig.Name = "DarkUIConfig"
	
	local Colors = Instance.new("Folder",DarkUIConfig)
	Colors.Name = "Colors"

	local BackgroundColor = Instance.new("Color3Value",Colors)
	BackgroundColor.Name = "BackgroundColor"
	BackgroundColor.Value = Color3.fromRGB(39, 39, 39)

	local BorderColor = Instance.new("Color3Value",Colors)
	BorderColor.Name = "BorderColor"
	BorderColor.Value = Color3.fromRGB(117, 24, 109)
	
	local Positions = Instance.new("Frame",DarkUIConfig)
	Positions.Name = "Positions"
	
	local PosXScale = Instance.new("NumberValue",Positions)
	PosXScale.Name = "PosXScale"
	local PosXOffset= Instance.new("NumberValue",Positions)
	PosXOffset.Name = "PosXOffset"
	local PosYScale = Instance.new("NumberValue",Positions)
	PosYScale.Name = "PosYScale"
	local PosYOffset = Instance.new("NumberValue",Positions)
	PosYOffset.Name = "PosYOffset"
else
	DarkUIConfig = game.ReplicatedStorage:FindFirstChild("DarkUIConfig")
end

--End of Configs
local function UpdateInput(input)
	local delta = input.Position - dragstart
	local position = UDim2.new(
		StartPos.X.Scale,
		StartPos.X.Offset + delta.X,
		StartPos.Y.Scale,
		StartPos.Y.Offset + delta.Y)
	TS:Create(ActivePart,TweenInfo.new(dragspeed),{Position = position}):Play()
end


local function DarkUIInitilize()
	local DarkUI = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
	DarkUI.Name = "DarkUI"

	local Pathing = Instance.new("ObjectValue",DarkUI)
	Pathing.Name = 'DarkUIConfigurationPath'
	Pathing.Value = DarkUIConfig
	
	return DarkUI
end

local function AddFrame(Parent,Name,Position,Size)
	local Frame = Instance.new("Frame",Parent)
	Frame.Name = Name
	Frame.AnchorPoint = Vector2.new(0.5,0.5)
	Frame.Position = Position
	Frame.Size = Size
	Frame.BackgroundColor3 = DarkUIConfig.BackgroundColor.Value
	Frame.BorderColor3 = DarkUIConfig.BorderColor.Value
	Frame.BorderSizePixel = 2
	return Frame
end

local function DevelopUI(NewValue)
	local Initilize = DarkUIInitilize()
	if NewValue ~= nil then
		local MainFrame = AddFrame(
			Initilize,
			'MainUI',
			UDim2.new(NewValue),
			UDim2.new(0,478,0,516)
		)
		return MainFrame, Initilize 
	else
		local MainFrame = AddFrame(
			Initilize,
			'MainUI',
			UDim2.new(0.5,0,0.5,0),
			UDim2.new(0,478,0,516)
		)
		return MainFrame, Initilize 
	end
end

if DarkUIConfig.Positions.PosXScale ~= nil then
	ActivePart, GInitilize = DevelopUI(UDim2.new(DarkUIConfig.Positions.PosXScale, DarkUIConfig.Positions.PosXOffset, DarkUIConfig.Positions.PosYScale, DarkUIConfig.Positions.PosYOffset))
else
	ActivePart, GInitilize = DevelopUI(nil)
end


 
game.Players.LocalPlayer.CharacterAdded:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ChristopherG107/DarkUI/main/Main.lua"))()
end)

ActivePart.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1) then
		Draggable = true
		dragstart = input.Position
		StartPos = ActivePart.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				GMainFrameActivePosition = ActivePart.Position
				Draggable = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		if Draggable then
			UpdateInput(input)
		end
	end
end)