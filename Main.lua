print(game.PlaceId)

--Get services
UIS = game:GetService("UserInputService")
TS = game:GetService("TweenService")
--Locals
GMainFrame = nil
GInitilize = nil
Draggable = false
dragstart = nil
dragspeed = 0.01
StartPos = nil
ActivePart = nil

--Add the Configs
local DarkUIConfig = Instance.new("Folder",game.ReplicatedStorage)
DarkUIConfig.Name = "DarkUIConfig"

local Colors = Instance.new("Folder",DarkUIConfig)
Colors.Name = "Colors"

local BackgroundColor = Instance.new("Color3Value",Colors)
BackgroundColor.Name = "BackgroundColor"
BackgroundColor.Value = Color3.fromRGB(39, 39, 39)

local BorderColor = Instance.new("Color3Value",Colors)
BorderColor.Name = "BorderColor"
BorderColor.Value = Color3.fromRGB(117, 24, 109)

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
	Frame.BackgroundColor3 = BackgroundColor.Value
	Frame.BorderColor3 = BorderColor.Value
	Frame.BorderSizePixel = 2
	return Frame
end

local function DevelopUI()
	local Initilize = DarkUIInitilize()
	
	local MainFrame = AddFrame(
		Initilize,
		'MainUI',
		UDim2.new(0.5,0,0.5,0),
		UDim2.new(0,478,0,516)
	)
	return MainFrame, Initilize 
end

GMainFrame, GInitilize = DevelopUI()
ActivePart = GMainFrame

game.Players.LocalPlayer.CharacterAdded:Connect(function()
	GMainFrame, GInitilize = DevelopUI()
	ActivePart = GMainFrame
end)

GMainFrame.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1) then
		Draggable = true
		dragstart = input.Position
		StartPos = GMainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
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

