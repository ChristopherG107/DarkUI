print(game.PlaceId)

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
	Frame.Position = Position
	Frame.Size = Size
	Frame.BackgroundColor3 = BackgroundColor.Value
	Frame.BorderColor3 = BorderColor.Value
	Frame.BorderSizePixel = 2
	return Frame
end

local function DevelopUI()
	local MainFrame = AddFrame(
		DarkUIInitilize(),
		'MainUI',
		UDim2.new(0, 316,0, 105),
		UDim2.new(0,478,0,516)
	)
end

DevelopUI()





