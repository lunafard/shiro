if script_key == "ayvWJBsuKdJNsCntrPRe_SHIROU_rsaUQgsAVdKBTMbrZLEY" then

	repeat wait() until game:IsLoaded()
	
	getgenv().ShirouSettings = {
		AntiGroundShots = true, -- remove
		AntiGroundValue = 0.5, -- remove
		WhenAntiGroundActivate = -20, -- remove
		WallCheck = true, -- remove
		K_O_Check = getgenv().ShirouSettings.K_O_Check,
		Humanize = false, -- remove
		HumanizeValue = 2, -- remove
		TriggerBot = false, -- remove
		UseTriggerBotKeybind = false, -- remove
		TriggerBotKey = "MouseButton3", -- remove
		PredictMovement = true, -- remove
		ClosestPoint = true, -- remove
		UseKeybind = true, -- remove
		Far_Activation = math.huge, -- remove
		Medium_Activation = 42, -- remove
		Close_Activation = 16, -- remove
		Transparency = 1, -- remove
		Color = Color3.fromRGB(0,0,0), -- remove
		HitParts = getgenv().ShirouSettings.HitParts, -- remove
		UseAirPart = false, -- remove
		AirPart = "LowerTorso", -- remove
		KnockedCheck = getgenv().ShirouSettings.KnockedCheck, -- remove
		UseCircleRadius = true, -- remove
		HoldMode = false, -- remove
		Part = getgenv().ShirouSettings.Part, -- remove
		ASTransparency = 0.5, -- remove
		ASColor = Color3.fromRGB(0,0,0), -- remove
		DetectDesync = true, -- remove
		DesyncDetection = 86, -- remove
		UseDetectDesyncKeybind = (false), -- remove
		DetectDesyncKey = "x", -- remove
		DetectUnderGround = true, -- remove
		UnderGroundDetection = -30, -- remove
		UseUnderGroundKeybind = false, -- remove
		UnderGroundKey = "X", -- remove
		VisibleCheck = true, -- remove
		TeamCheck = false, -- remove
		UseLay = getgenv().ShirouSettings.UseLay, -- remove
		LayKeybind = getgenv().ShirouSettings.LayKeybind, -- remove
		ESPHoldMode = false, -- remove
		Name = {Enabled = true, OutLine = true, Color = Color3.fromRGB(255, 255, 255)}, -- remove
		Box = {Enabled = true, OutLine = true, Color = Color3.fromRGB(255, 255, 255)}, -- remove
		HealthBar = {Enabled = true, OutLine = true, Color = Color3.fromRGB(161, 196, 140)}, -- remove
		HealthText = {Enabled = true, OutLine = true, Color = Color3.fromRGB(161, 196, 140)}, -- remove
		Distance = {Enabled = false, OutLine = true, Color = Color3.fromRGB(255, 255, 255)}, -- remove
	
		Enabled = getgenv().ShirouSettings.Enabled,
		KeyBind = getgenv().ShirouSettings.KeyBind, -- // toggle on and off silent
		Show_Fov = getgenv().ShirouSettings.Show_Fov,
		Fov_Filled = getgenv().ShirouSettings.Fov_Filled,
		Fov_Size = getgenv().ShirouSettings.Fov_Size,
		Crew_Whitelist = getgenv().ShirouSettings.Crew_Whitelist,
		Friends_Whitelist = getgenv().ShirouSettings.Friends_Whitelist,
		Enabled_Notification = getgenv().ShirouSettings.Enabled_Notification,
		ESP = getgenv().ShirouSettings.ESP,
		UseEspKeybind = getgenv().ShirouSettings.UseEspKeybind, -- // Keybinds ESP so you can turn it on and off with the press of EspKey.
		EspKey = getgenv().ShirouSettings.EspKey,
		Anti_AimViewer = getgenv().ShirouSettings.Anti_AimViewer, -- // Spoofs mousepos to bypass silent aim being aimviewed.
		Auto_prediction = getgenv().ShirouSettings.Auto_prediction,
		HitChance = getgenv().ShirouSettings.HitChance,
	
		Prediction = getgenv().ShirouSettings.Prediction, -- // Main Prediction
	
		NearestHitPart = getgenv().ShirouSettings.NearestHitPart,
	
	------- AIM ASSIST / CAMLOCK -------
	
		AimAssistEnabled = getgenv().ShirouSettings.AimAssistEnabled,
		ASKeyBind = getgenv().ShirouSettings.ASKeyBind,
		AS_Show_Fov = false,
		ASFov_Filled = false,
		Radius = getgenv().ShirouSettings.Radius,
		UseShake = getgenv().ShirouSettings.UseShake,
		ShakeValue = getgenv().ShirouSettings.ShakeValue,
		EnablePrediction = getgenv().ShirouSettings.EnablePrediction,
		ASWallCheck = true,
		DisableOutSideCircle = false,
		Smoothness_X = getgenv().ShirouSettings.Smoothness_X,
		Smoothness_Y = getgenv().ShirouSettings.Smoothness_Y,
		AntiMacroFling = getgenv().ShirouSettings.AntiMacroFling,
	
		ASPrediction = getgenv().ShirouSettings.ASPrediction,
	
		ClosestMousePoint = getgenv().ShirouSettings.ClosestMousePoint,
	}
	
	getgenv = getgenv
	Drawing = Drawing
	mouse1click = mouse1click
	mouse1press = mouse1press
	hookmetamethod = hookmetamethod
	checkcaller = checkcaller
	mousemoverel = mousemoverel
	
	-- // Variables (Too Lazy To Make It To One Local)
	local DoubleBarrel = "Double-Barrel SG"
	local OldSilentAimPart = getgenv().ShirouSettings.HitParts
	local ClosestPointCF, SilentTarget, AimTarget, DetectedDesync, DetectedDesyncV2, DetectedUnderGround, DetectedUnderGroundV2, DetectedFreeFall, Anti_AimViewer = CFrame.new(), nil, nil, false, false, false, false, false, true
	local Script = {Functions = {}, Friends = {}, Drawing = {}, EspPlayers = {}}
	
	local Players, Client, Mouse, RS, Camera, GuiS, Uis, Ran = game:GetService("Players"), game:GetService("Players").LocalPlayer, game:GetService("Players").LocalPlayer:GetMouse(), game:GetService("RunService"), game:GetService("Workspace").CurrentCamera, game:GetService("GuiService"), game:GetService("UserInputService"), math.random
	
	-- // Drawing For AimAssist And SilentAim
	Script.Drawing.SilentCircle = Drawing.new("Circle")
	Script.Drawing.SilentCircle.Color = Color3.new(1,1,1)
	Script.Drawing.SilentCircle.Thickness = 1
	
	Script.Drawing.AimAssistCircle = Drawing.new("Circle")
	Script.Drawing.AimAssistCircle.Color = Color3.new(1,1,1)
	Script.Drawing.AimAssistCircle.Thickness = 1
	
	--// Update Size/Position Of Circle
	Script.Functions.UpdateFOV = function()
		if (not Script.Drawing.SilentCircle and not Script.Drawing.AimAssistCircle) then
			return Script.Drawing.SilentCircle and Script.Drawing.AimAssistCircle
		end
	
		Script.Drawing.AimAssistCircle.Visible = getgenv().ShirouSettings.AS_Show_Fov
		Script.Drawing.AimAssistCircle.Filled = getgenv().ShirouSettings.ASFov_Filled
		Script.Drawing.AimAssistCircle.Color = getgenv().ShirouSettings.ASColor
		Script.Drawing.AimAssistCircle.Transparency = getgenv().ShirouSettings.ASTransparency
		Script.Drawing.AimAssistCircle.Position = Vector2.new(Mouse.X, Mouse.Y + GuiS:GetGuiInset().Y)
		Script.Drawing.AimAssistCircle.Radius = getgenv().ShirouSettings.Radius * 3
	
		Script.Drawing.SilentCircle.Visible = getgenv().ShirouSettings.Show_Fov
		Script.Drawing.SilentCircle.Color = getgenv().ShirouSettings.Color
		Script.Drawing.SilentCircle.Filled = getgenv().ShirouSettings.Fov_Filled
		Script.Drawing.SilentCircle.Transparency = getgenv().ShirouSettings.Transparency
		Script.Drawing.SilentCircle.Position = Vector2.new(Mouse.X, Mouse.Y + GuiS:GetGuiInset().Y)
		Script.Drawing.SilentCircle.Radius = getgenv().ShirouSettings.Fov_Size * 3
	end
	
		--// Check if lock is loaded
		if getgenv().LoadShirou == true then
			if getgenv().ShirouSettings.Enabled_Notification then
			game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Shirou";
			Text = "Shirous lock is already loaded.";
			Icon = "";
			Duration = 5
		})
			wait(1)
			game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Updated";
			Text = "If you made changes to your settings they have been applied";
			Icon = "";
			Duration = 5
		})
			return 
			end
			end
			
			getgenv().LoadShirou = true
			
	if getgenv().ShirouSettings.Enabled_Notification then
			game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Shirous lock loaded";
			Text = "食肉#0001";
			Icon = "";
			Duration = 5
		})
	end
	
	if getgenv().ShirouSettings.AntiMacroFling then
	local antimacrofling = game:GetService("RunService").Heartbeat:Connect(function()
	game:GetService("RunService").RenderStepped:Wait()
	game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	end)
	end
	
	if not getgenv().ShirouSettings.AntiMacroFling then
	antimacrofling:Disconnect()
	end
	
	-- // KeyDown Check
	Mouse.KeyDown:Connect(function(Key)
		local Keybind = getgenv().ShirouSettings.ASKeyBind:lower()
		if Key == Keybind then
			if getgenv().ShirouSettings.Enabled then
				IsTargetting = not IsTargetting
				if IsTargetting then
					Script.Functions.GetClosestPlayer2()
				else
					if AimTarget ~= nil then
						AimTarget = nil
						IsTargetting = false
					end
				end
			end
		end
		local Keybind2 = getgenv().ShirouSettings.KeyBind:lower()
		if Key == Keybind2 and getgenv().ShirouSettings.UseKeybind then
			getgenv().ShirouSettings.Enabled = not getgenv().ShirouSettings.Enabled
			if getgenv().ShirouSettings.Enabled_Notification then
				game.StarterGui:SetCore("SendNotification",{
					Title = "Shirous Lock",
					Text = "" .. tostring(getgenv().ShirouSettings.Enabled),
					Icon = "",
					Duration = 1
				})
			end
		end
		local Keybind3 = getgenv().ShirouSettings.UnderGroundKey:lower()
		if Key == Keybind3 and getgenv().ShirouSettings.UseUnderGroundKeybind then
			getgenv().ShirouSettings.DetectUnderGround = not getgenv().ShirouSettings.DetectUnderGround
			if getgenv().ShirouSettings.Enabled_Notification then
				game.StarterGui:SetCore("SendNotification",{
					Title = "Shirous UG Resolver",
					Text = "" .. tostring(getgenv().ShirouSettings.DetectUnderGround),
					Icon = "",
					Duration = 1
				})
			end
		end
		local Keybind4 = getgenv().ShirouSettings.DetectDesyncKey:lower()
		if Key == Keybind4 and getgenv().ShirouSettings.UseDetectDesyncKeybind then
			getgenv().ShirouSettings.DetectDesync = not getgenv().ShirouSettings.DetectDesync
			if getgenv().ShirouSettings.Enabled_Notification then
				game.StarterGui:SetCore("SendNotification",{
					Title = "Shirous Desync Resolver",
					Text = "" .. tostring(getgenv().ShirouSettings.DetectDesync),
					Icon = "",
					Duration = 1
				})
			end
		end
		local Keybind5 = getgenv().ShirouSettings.LayKeybind:lower()
		if Key == Keybind5 and getgenv().ShirouSettings.UseLay then
			local Args = {
				[1] = "AnimationPack",
				[2] = "Lay"
			}
			game:GetService("ReplicatedStorage"):FindFirstChild("MainEvent"):FireServer(unpack(Args))
		end
		local Keybind6 = getgenv().ShirouSettings.EspKey:lower()
		if Key == Keybind6 and getgenv().ShirouSettings.UseEspKeybind then
			if getgenv().ShirouSettings.ESPHoldMode then
				getgenv().ShirouSettings.ESP = true
			else
				getgenv().ShirouSettings.ESP = not getgenv().ShirouSettings.ESP
			end
		end
	end)
	
	-- // KeyUp Check
	Mouse.KeyUp:Connect(function(Key)
		local Keybind = getgenv().ShirouSettings.EspKey:lower()
		if Key == Keybind and getgenv().ShirouSettings.UseEspKeybind and getgenv().ShirouSettings.ESPHoldMode then
			getgenv().ShirouSettings.ESP = false
		end
		local Keybind2 = getgenv().ShirouSettings.ASKeyBind:lower()
		if Key == Keybind2 and getgenv().ShirouSettings.AimAssistEnabled and getgenv().ShirouSettings.HoldMode then
			IsTargetting = false
			AimTarget = nil
		end
	end)
	
	-- // Disabled If AntiAimViewer Is On
	if getgenv().ShirouSettings.Anti_AimViewer then
		Anti_AimViewer = false
	else
		Anti_AimViewer = true
	end
	
	-- // Blocks Mouse Triggering
	game:GetService("ContextActionService"):BindActionAtPriority("LeftMouseBlock", function()
		if Anti_AimViewer == false and getgenv().ShirouSettings.Anti_AimViewer and Client.Character and Client.Character:FindFirstChildWhichIsA("Tool") then
			return Enum.ContextActionResult.Sink
		else
			return Enum.ContextActionResult.Pass
		end
	end, true, Enum.ContextActionPriority.Low.Value, Enum.UserInputType.MouseButton1)
	
	-- // Delaying The Mouse Trigger
	Uis.InputBegan:connect(function(input)
		if input.UserInputType == Enum.UserInputType[getgenv().ShirouSettings.TriggerBotKey] and getgenv().ShirouSettings.UseTriggerBotKeybind then
			getgenv().ShirouSettings.TriggerBot = true
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 and getgenv().ShirouSettings.Anti_AimViewer and Client.Character and Client.Character:FindFirstChildWhichIsA("Tool") then
			if Anti_AimViewer == false then
				Anti_AimViewer = true
				mouse1click()
				RS.RenderStepped:Wait()
				RS.RenderStepped:Wait()
				mouse1press()
				RS.RenderStepped:Wait()
				RS.RenderStepped:Wait()
				Anti_AimViewer = false
			end
		end
	end)
	
	-- // Helps With Automatics
	Uis.InputEnded:connect(function(input)
		if input.UserInputType == Enum.UserInputType[getgenv().ShirouSettings.TriggerBotKey] and getgenv().ShirouSettings.UseTriggerBotKeybind then
			getgenv().ShirouSettings.TriggerBot = true
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 and getgenv().ShirouSettings.Anti_AimViewer and Client.Character and Client.Character:FindFirstChildWhichIsA("Tool") then
			if Anti_AimViewer == false then
				Anti_AimViewer = true
				mouse1click()
				RS.RenderStepped:Wait()
				RS.RenderStepped:Wait()
				mouse1click()
				RS.RenderStepped:Wait()
				RS.RenderStepped:Wait()
				Anti_AimViewer = true
			end
		end
	end)
	
	-- // Checks If The Player Is Alive
	Script.Functions.Alive = function(Plr)
		if Plr and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and Plr.Character:FindFirstChild("Humanoid") ~= nil and Plr.Character:FindFirstChild("Head") ~= nil then
			return true
		end
		return false
	end
	
	-- // Checks If Player Is On Your Screen
	Script.Functions.OnScreen = function(Object)
		local _, screen = Camera:WorldToScreenPoint(Object.Position)
		return screen
	end
	
	-- // Gets Magnitude From Part Position And Mouse
	Script.Functions.GetMagnitudeFromMouse = function(Part)
		local PartPos, OnScreen = Camera:WorldToScreenPoint(Part.Position)
		if OnScreen then
			local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
			return Magnitude
		end
		return math.huge
	end
	
	-- // Makes Random Number With Vector3 
	Script.Functions.RandomVec = function(Number, Multi)
		return (Vector3.new(Ran(-Number, Number), Ran(-Number, Number), Ran(-Number, Number)) * Multi or 1)
	end
	
	-- // Checks If The Player Is Behind A Wall Or Something Else
	Script.Functions.RayCastCheck = function(Part, PartDescendant)
		local Character = Client.Character or Client.CharacterAdded.Wait(Client.CharacterAdded)
		local Origin = Camera.CFrame.Position
	
		local RayCastParams = RaycastParams.new()
		RayCastParams.FilterType = Enum.RaycastFilterType.Blacklist
		RayCastParams.FilterDescendantsInstances = {Character, Camera}
	
		local Result = workspace.Raycast(workspace, Origin, Part.Position - Origin, RayCastParams)
	
		if (Result) then
			local PartHit = Result.Instance
			local Visible = (not PartHit or Instance.new("Part").IsDescendantOf(PartHit, PartDescendant))
	
			return Visible
		end
		return false
	end
	
	-- // Gets The Part From An Object
	Script.Functions.GetParts = function(Object)
		if string.find(Object.Name, "Gun") then
			return
		end
		if table.find({"Part", "MeshPart", "BasePart"}, Object.ClassName) then
			return true
		end
	end
	
	-- // Random Number To Compare
	Script.Functions.CalculateChance = function(Percentage)
		Percentage = math.floor(Percentage)
		local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
	
		return chance < Percentage / 100
	end
	
	-- // Check If Crew Folder Is A Thing
	Script.Functions.FindCrew = function(Player)
		if Player:FindFirstChild("DataFolder") and Player.DataFolder:FindFirstChild("Information") and Player.DataFolder.Information:FindFirstChild("Crew") and Client:FindFirstChild("DataFolder") and Client.DataFolder:FindFirstChild("Information") and Client.DataFolder.Information:FindFirstChild("Crew") then
			if Client.DataFolder.Information:FindFirstChild("Crew").Value ~= nil and Player.DataFolder.Information:FindFirstChild("Crew").Value ~= nil and Player.DataFolder.Information:FindFirstChild("Crew").Value ~= "" and Client.DataFolder.Information:FindFirstChild("Crew").Value ~= "" then 
				return true
			end
		end
		return false
	end
	
	-- // Splits The Gun Name And Splits []
	Script.Functions.GetGunName = function(Name)
		local split = string.split(string.split(Name, "[")[2], "]")[1]
		return split
	end
	
	-- // Gets Current Gun
	Script.Functions.GetCurrentWeaponName = function()
		if Client.Character and Client.Character:FindFirstChildWhichIsA("Tool") then
			local Tool =  Client.Character:FindFirstChildWhichIsA("Tool")
			if string.find(Tool.Name, "%[") and string.find(Tool.Name, "%]") and not string.find(Tool.Name, "Wallet") and not string.find(Tool.Name, "Phone") then
				return Script.Functions.GetGunName(Tool.Name)
			end
		end
		return nil
	end
	
	-- // Drawing Function With Property Attached
	Script.Functions.NewDrawing = function(Type, Properties)
		local NewDrawing = Drawing.new(Type)
	
		for i,v in next, Properties or {} do
			NewDrawing[i] = v
		end
		return NewDrawing
	end
	
	-- // Draws For The New Players Joining For Esp
	Script.Functions.NewPlayer = function(Player)
		Script.EspPlayers[Player] = {
			Name = Script.Functions.NewDrawing("Text", {Color = Color3.fromRGB(255,2550, 255), Outline = true, Visible = false, Center = true, Size = 13, Font = 0}),
			BoxOutline = Script.Functions.NewDrawing("Square", {Color = Color3.fromRGB(0, 0, 0), Thickness = 3, Visible = false}),
			Box = Script.Functions.NewDrawing("Square", {Color = Color3.fromRGB(255, 255, 255), Thickness = 1, Visible = false}),
			HealthBarOutline = Script.Functions.NewDrawing("Line", {Color = Color3.fromRGB(0, 0, 0), Thickness = 3, Visible = false}),
			HealthBar = Script.Functions.NewDrawing("Line", {Color = Color3.fromRGB(0, 255, 0), Thickness = 1, Visible = false}),
			HealthText = Script.Functions.NewDrawing("Text", {Color = Color3.fromRGB(0, 255, 0), Outline = true, Visible = false, Center = true, Size = 13, Font = 0}),
			Distance = Script.Functions.NewDrawing("Text", {Color = Color3.fromRGB(255, 255, 255), Outline = true, Visible = false, Center = true, Size = 13, Font = 0})
		}
	end
	
	-- // Gets The Closest Part From Cursor
	Script.Functions.GetClosestBodyPart = function(Char)
		local Distance = math.huge
		local ClosestPart = nil
		local Filterd = {}
	
		if not (Char and Char:IsA("Model")) then
			return ClosestPart
		end
	
		local Parts = Char:GetChildren()
		for _, v in pairs(Parts) do
			if Script.Functions.GetParts(v) and Script.Functions.OnScreen(v) then
				table.insert(Filterd, v)
				for _, Part in pairs(Filterd) do                
					local Magnitude = Script.Functions.GetMagnitudeFromMouse(Part)
					if Magnitude < Distance then
						ClosestPart = Part
						Distance = Magnitude
					end
				end
			end
		end
		return ClosestPart
	end
	
	-- // Gets The Closest Point From Cursor
	Script.Functions.GetClosestPointOfPart = function(Part)
		local NearestPosition = nil
		if Part ~= nil then
			local Hit, Half = Mouse.Hit.Position, Part.Size * 0.5
			local Transform = Part.CFrame:PointToObjectSpace(Mouse.Hit.Position)
			NearestPosition = Part.CFrame * Vector3.new(math.clamp(Transform.X, -Half.X, Half.X),math.clamp(Transform.Y, -Half.Y, Half.Y),math.clamp(Transform.Z, -Half.Z, Half.Z))
		end
		return NearestPosition
	end
	
	-- // Gets The Closest Player For Cursor (Silent Aim)
	Script.Functions.GetClosestPlayer = function()
		local Target = nil
		local Closest = math.huge
		local HitChance = Script.Functions.CalculateChance(getgenv().ShirouSettings.HitChance)
	
		if not HitChance then
			return nil
		end
		for _, v in pairs(Players:GetPlayers()) do
			if v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart") then
				if not Script.Functions.OnScreen(v.Character.HumanoidRootPart) then 
					continue 
				end
				if getgenv().ShirouSettings.WallCheck and not Script.Functions.RayCastCheck(v.Character.HumanoidRootPart, v.Character) then 
					continue 
				end
				if getgenv().ShirouSettings.K_O_Check and v.Character:FindFirstChild("BodyEffects") then
					local KoCheck = v.Character.BodyEffects:FindFirstChild("K.O").Value
					local Grabbed = v.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
					if KoCheck or Grabbed then
						continue
					end
				end
				if getgenv().ShirouSettings.K_O_Check and v.Character:FindFirstChild("Humanoid") then
					if v.Character.Humanoid.health < 4 then
						continue
					end
				end
				if getgenv().ShirouSettings.VisibleCheck and v.Character:FindFirstChild("Head") then
					if v.Character.Head.Transparency > 0.5 then
						continue
					end
				end
				if getgenv().ShirouSettings.Crew_Whitelist and Script.Functions.FindCrew(v) and v.DataFolder.Information:FindFirstChild("Crew").Value == Client.DataFolder.Information:FindFirstChild("Crew").Value then
					continue
				end
				if getgenv().ShirouSettings.TeamCheck then
					if v.Team ~= Client.Team then
						continue
					end
				end
				if getgenv().ShirouSettings.Friends_Whitelist then
					if not table.find(Script.Friends, v.UserId) then
						continue
					end
				end
				local Distance = Script.Functions.GetMagnitudeFromMouse(v.Character.HumanoidRootPart)
	
				if (Distance < Closest and Script.Drawing.SilentCircle.Radius + 10 > Distance) then
					Closest = Distance
					Target = v
				end
			end
		end
	
		SilentTarget = Target
	end
	
	-- // Gets Closest Player From Mouse (AimAssist)
	Script.Functions.GetClosestPlayer2 = function()
		local Target = nil
		local Distance = nil
		local Closest = math.huge
	
		for _, v in pairs(Players:GetPlayers()) do
			if v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart") then
				if not Script.Functions.OnScreen(v.Character.HumanoidRootPart) then 
					continue 
				end
				if getgenv().ShirouSettings.ASWallCheck and not Script.Functions.RayCastCheck(v.Character.HumanoidRootPart, v.Character) then 
					continue 
				end
				local Distance = Script.Functions.GetMagnitudeFromMouse(v.Character.HumanoidRootPart)
	
				if Distance < Closest then
					if (getgenv().ShirouSettings.UseCircleRadius and Script.Drawing.AimAssistCircle.Radius + 10 < Distance) then continue end
					Closest = Distance
					Target = v
				end
			end
		end
	
		if Script.Functions.Alive(Target) then
			if getgenv().ShirouSettings.VisibleCheck then
				if Target.Character.Head.Transparency > 0.5 then
					return nil
				end
			end
			if getgenv().ShirouSettings.Crew_Whitelist and Script.Functions.FindCrew(Target) and Target.DataFolder.Information:FindFirstChild("Crew").Value == Client.DataFolder.Information:FindFirstChild("Crew").Value then
				return nil
			end
		end
		if getgenv().ShirouSettings.TeamCheck and Target then
			if Target.Team == Client.Team then
				return nil
			end
		end
		if getgenv().ShirouSettings.Friends_Whitelist then
			if table.find(Script.Friends, Target.UserId) then
				return nil
			end
		end
	
		AimTarget = Target
	end
	
	-- // Server Side Mouse Position Changer
	local OldIndex = nil 
	OldIndex = hookmetamethod(game, "__index", function(self, Index)
		if not checkcaller() and Mouse and self == Mouse and Index == "Hit" and getgenv().ShirouSettings.Enabled and Anti_AimViewer then
			if Script.Functions.Alive(SilentTarget) and Players[tostring(SilentTarget)].Character:FindFirstChild(getgenv().ShirouSettings.HitParts) then
				local EndPoint = nil
				local TargetCF = nil
				local TargetVel = Players[tostring(SilentTarget)].Character.HumanoidRootPart.Velocity
				local TargetMov = Players[tostring(SilentTarget)].Character.Humanoid.MoveDirection
	
				if getgenv().ShirouSettings.ClosestPoint then
					TargetCF = ClosestPointCF
				else
					TargetCF = Players[tostring(SilentTarget)].Character[getgenv().ShirouSettings.HitParts].CFrame
				end
	
				if getgenv().ShirouSettings.DetectDesync then
					local Magnitude = TargetVel.magnitude
					local Magnitude2 = TargetMov.magnitude
					if Magnitude > getgenv().ShirouSettings.DesyncDetection then
						DetectedDesync = true
					else
						DetectedDesync = false
					end
				else
					DetectedDesync = false
				end
				if getgenv().ShirouSettings.AntiGroundShots then
					if TargetVel.Y < getgenv().ShirouSettings.WhenAntiGroundActivate then
						DetectedFreeFall = true
					else
						DetectedFreeFall = false
					end
				end
				if getgenv().ShirouSettings.DetectUnderGround then 
					if TargetVel.Y < getgenv().ShirouSettings.UnderGroundDetection then            
						DetectedUnderGround = true
					else
						DetectedUnderGround = false
					end
				else
					DetectedUnderGround = false
				end
	
				if TargetCF ~= nil then
					if DetectedDesync then
						local MoveDirection = TargetMov * 16
						EndPoint = TargetCF + (MoveDirection * getgenv().ShirouSettings.Prediction)
					elseif DetectedUnderGround then
						EndPoint = TargetCF + (Vector3.new(TargetVel.X, 0, TargetVel.Z) * getgenv().ShirouSettings.Prediction)
					elseif DetectedFreeFall then
						EndPoint = TargetCF + (Vector3.new(TargetVel.X, (TargetVel.Y * getgenv().ShirouSettings.AntiGroundValue), TargetVel.Z) * getgenv().ShirouSettings.Prediction)
					elseif getgenv().ShirouSettings.PredictMovement then
						EndPoint = TargetCF + (Vector3.new(TargetVel.X, (TargetVel.Y * 0.5), TargetVel.Z) * getgenv().ShirouSettings.Prediction)
					else
						EndPoint = TargetCF
					end
					if getgenv().ShirouSettings.Humanize then
						local HumanizeValue = getgenv().ShirouSettings.HumanizeValue 
						EndPoint = (EndPoint + Script.Functions.RandomVec(HumanizeValue, 0.01))
					end
				end
	
				if EndPoint ~= nil then
					return (Index == "Hit" and EndPoint)
				end
			end
		end
		return OldIndex(self, Index)
	end)
	
	-- // Silent Aim Misc
	Script.Functions.SilentMisc = function()
		if getgenv().ShirouSettings.Enabled and Script.Functions.Alive(SilentTarget) then
			if getgenv().ShirouSettings.UseAirPart then
				if SilentTarget.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
					getgenv().ShirouSettings.HitParts = getgenv().ShirouSettings.AirPart
				else
					getgenv().ShirouSettings.HitParts = OldSilentAimPart
				end
			end
			if getgenv().ShirouSettings.TriggerBot then
				mouse1click()
			end
		end
		if getgenv().ShirouSettings.Auto_prediction then
			local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
			if ping < 10 then
				getgenv().ShirouSettings.Prediction = 0.07
			elseif ping < 20 then
				getgenv().ShirouSettings.Prediction = 0.155
			elseif ping < 30 then
				getgenv().ShirouSettings.Prediction = 0.132
			elseif ping < 40 then
				getgenv().ShirouSettings.Prediction = 0.136
			elseif ping < 50 then
				getgenv().ShirouSettings.Prediction = 0.130
			elseif ping < 60 then
				getgenv().ShirouSettings.Prediction = 0.136
			elseif ping < 70 then
				getgenv().ShirouSettings.Prediction = 0.138
			elseif ping < 80 then
				getgenv().ShirouSettings.Prediction = 0.138
			elseif ping < 90 then
				getgenv().ShirouSettings.Prediction = 0.146
			elseif ping < 100 then
				getgenv().ShirouSettings.Prediction = 0.14322
			elseif ping < 110 then
				getgenv().ShirouSettings.Prediction = 0.146
			elseif ping < 120 then
				getgenv().ShirouSettings.Prediction = 0.149
			elseif ping < 130 then
				getgenv().ShirouSettings.Prediction = 0.151
			elseif ping < 140 then
				getgenv().ShirouSettings.Prediction = 0.1223333
			elseif ping < 150 then
				getgenv().ShirouSettings.Prediction = 0.15
			elseif ping < 160 then
				getgenv().ShirouSettings.Prediction = 0.16
			elseif ping < 170 then
				getgenv().ShirouSettings.Prediction = 0.1923111
			elseif ping < 180 then
				getgenv().ShirouSettings.Prediction = 0.19284
			elseif ping > 180 then
				getgenv().ShirouSettings.Prediction = 0.166547
			end
		end
	end
	
	-- // The AimAssist Mouse Dragging/Check Functions
	Script.Functions.MouseChanger = function()
		if getgenv().ShirouSettings.AimAssistEnabled and Script.Functions.Alive(AimTarget) and Players[tostring(AimTarget)].Character:FindFirstChild(getgenv().ShirouSettings.Part) and Script.Functions.OnScreen(Players[tostring(AimTarget)].Character[getgenv().ShirouSettings.Part]) then
			local EndPosition = nil
			local TargetPos = Players[tostring(AimTarget)].Character[getgenv().ShirouSettings.Part].Position
			local TargetVel = Players[tostring(AimTarget)].Character[getgenv().ShirouSettings.Part].Velocity
			local TargetMov = Players[tostring(AimTarget)].Character.Humanoid.MoveDirection
	
			if getgenv().ShirouSettings.DetectDesync then
				local Magnitude = TargetVel.magnitude
				local Magnitude2 = TargetMov.magnitude
				if Magnitude > getgenv().ShirouSettings.DesyncDetection then
					DetectedDesyncV2 = true
				elseif Magnitude < 1 and Magnitude2 > 0.01 then
					DetectedDesyncV2 = true
				elseif Magnitude > 5 and Magnitude2 < 0.01 then
					DetectedDesyncV2 = true
				else
					DetectedDesyncV2 = false
				end
			else
				DetectedDesyncV2 = false
			end
			if getgenv().ShirouSettings.DetectUnderGround then 
				if TargetVel.Y < getgenv().ShirouSettings.UnderGroundDetection then            
					DetectedUnderGroundV2 = true
				else
					DetectedUnderGroundV2 = false
				end
			else
				DetectedUnderGroundV2 = false
			end
	
			if Script.Functions.Alive(Client) then
				if getgenv().ShirouSettings.KnockedCheck then
					if Client.Character.Humanoid.health < 4 then
						AimTarget = nil
						IsTargetting = false
						return
					end
				end
				if getgenv().ShirouSettings.DisableOutSideCircle then
					local Magnitude = Script.Functions.GetMagnitudeFromMouse(AimTarget.Character.HumanoidRootPart)
					if Script.Drawing.AimAssistCircle.Radius < Magnitude then
						AimTarget = nil
						IsTargetting = false
						return
					end
				end
			end
	
			if getgenv().ShirouSettings.KnockedCheck and AimTarget.Character:FindFirstChild("BodyEffects") then 
				local KoCheck = AimTarget.Character.BodyEffects:FindFirstChild("K.O").Value
				local Grabbed = AimTarget.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
				if KoCheck or Grabbed then
					AimTarget = nil
					IsTargetting = false
					return
				end
			end
			if getgenv().ShirouSettings.KnockedCheck then
				if AimTarget.Character.Humanoid.health < 4 then
					AimTarget = nil
					IsTargetting = false
					return
				end
			end
	
			if DetectedDesyncV2 and getgenv().ShirouSettings.EnablePrediction then
				local MoveDirection = TargetMov * 16
				EndPosition = Camera:WorldToScreenPoint(TargetPos + (MoveDirection * getgenv().ShirouSettings.Prediction))
			elseif DetectedUnderGroundV2 and getgenv().ShirouSettings.EnablePrediction then
				EndPosition = Camera:WorldToScreenPoint(TargetPos + (Vector3.new(TargetVel.X, 0, TargetVel.Z) * getgenv().ShirouSettings.Prediction))
			elseif getgenv().ShirouSettings.EnablePrediction then
				if getgenv().ShirouSettings.UseShake and Script.Functions.Alive(Client) then
					local Shake = getgenv().ShirouSettings.ShakeValue / 100
					local Mag = math.ceil((TargetPos - Client.Character.HumanoidRootPart.Position).Magnitude)
					EndPosition = Camera:WorldToScreenPoint(TargetPos + (TargetVel * getgenv().ShirouSettings.Prediction) + Script.Functions.RandomVec(Mag * Shake, 0.1))
				else
					EndPosition = Camera:WorldToScreenPoint(TargetPos + (TargetVel * getgenv().ShirouSettings.Prediction))
				end
			else
				if getgenv().ShirouSettings.UseShake and Script.Functions.Alive(Client) then
					local Shake = getgenv().ShirouSettings.ShakeValue / 100
					local Mag = math.ceil((TargetPos - Client.Character.HumanoidRootPart.Position).Magnitude)
					EndPosition = Camera:WorldToScreenPoint(TargetPos + Script.Functions.RandomVec(Mag * Shake, 0.1))
				else
					EndPosition = Camera:WorldToScreenPoint(TargetPos)
				end
			end
	
			if EndPosition ~= nil then
				local InCrementX = (EndPosition.X - Mouse.X) * getgenv().ShirouSettings.Smoothness_X
				local InCrementY = (EndPosition.Y - Mouse.Y) * getgenv().ShirouSettings.Smoothness_Y
				mousemoverel(InCrementX, InCrementY)
			end
		end
	end
	
	-- // Updates Esp Posistions
	Script.Functions.UpdateEsp = function()
		for i,v in pairs(Script.EspPlayers) do
			if getgenv().ShirouSettings.ESP and i ~= Client and i.Character and i.Character:FindFirstChild("Humanoid") and i.Character:FindFirstChild("HumanoidRootPart") and i.Character:FindFirstChild("Head") then
				local Hum = i.Character.Humanoid
				local Hrp = i.Character.HumanoidRootPart
	
				local Vector, OnScreen = Camera:WorldToViewportPoint(i.Character.HumanoidRootPart.Position)
				local Size = (Camera:WorldToViewportPoint(Hrp.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(Hrp.Position + Vector3.new(0, 2.6, 0)).Y) / 2
				local BoxSize = Vector2.new(math.floor(Size * 1.5), math.floor(Size * 1.9))
				local BoxPos = Vector2.new(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2))
				local BottomOffset = BoxSize.Y + BoxPos.Y + 1
	
				if OnScreen then
					if getgenv().ShirouSettings.Name.Enabled then
						v.Name.Position = Vector2.new(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
						v.Name.Outline = getgenv().ShirouSettings.Name.OutLine
						v.Name.Text = tostring(i)
						v.Name.Color = getgenv().ShirouSettings.Name.Color
						v.Name.OutlineColor = Color3.fromRGB(0, 0, 0)
						v.Name.Font = 0
						v.Name.Size = 16
	
						v.Name.Visible = true
					else
						v.Name.Visible = false
					end
					if getgenv().ShirouSettings.Distance.Enabled and Client.Character and Client.Character:FindFirstChild("HumanoidRootPart") then
						v.Distance.Position = Vector2.new(BoxSize.X / 2 + BoxPos.X, BottomOffset)
						v.Distance.Outline = getgenv().ShirouSettings.Distance.OutLine
						v.Distance.Text = "[" .. math.floor((Hrp.Position - Client.Character.HumanoidRootPart.Position).Magnitude) .. "m]"
						v.Distance.Color = getgenv().ShirouSettings.Distance.Color
						v.Distance.OutlineColor = Color3.fromRGB(0, 0, 0)
						BottomOffset = BottomOffset + 15
	
						v.Distance.Font = 0
						v.Distance.Size = 16
	
						v.Distance.Visible = true
					else
						v.Distance.Visible = false
					end
					if getgenv().ShirouSettings.Box.Enabled then
						v.BoxOutline.Size = BoxSize
						v.BoxOutline.Position = BoxPos
						v.BoxOutline.Visible = getgenv().ShirouSettings.Box.OutLine
						v.BoxOutline.Color = Color3.fromRGB(0, 0, 0)
	
						v.Box.Size = BoxSize
						v.Box.Position = BoxPos
						v.Box.Color = getgenv().ShirouSettings.Box.Color
						v.Box.Visible = true
					else
						v.BoxOutline.Visible = false
						v.Box.Visible = false
					end
					if getgenv().ShirouSettings.HealthBar.Enabled then
						v.HealthBar.From = Vector2.new((BoxPos.X - 5), BoxPos.Y + BoxSize.Y)
						v.HealthBar.To = Vector2.new(v.HealthBar.From.X, v.HealthBar.From.Y - (Hum.Health / Hum.MaxHealth) * BoxSize.Y)
						v.HealthBar.Color = getgenv().ShirouSettings.HealthBar.Color
						v.HealthBar.Visible = true
	
						v.HealthBarOutline.From = Vector2.new(v.HealthBar.From.X, BoxPos.Y + BoxSize.Y + 1)
						v.HealthBarOutline.To = Vector2.new(v.HealthBar.From.X, (v.HealthBar.From.Y - 1 * BoxSize.Y) -1)
						v.HealthBarOutline.Color = Color3.fromRGB(0, 0, 0)
						v.HealthBarOutline.Visible = getgenv().ShirouSettings.HealthBar.OutLine
					else
						v.HealthBarOutline.Visible = false
						v.healthBar.Visible = false
					end
					if getgenv().ShirouSettings.HealthText.Enabled then
						v.HealthText.Text = tostring(math.floor((Hum.Health / Hum.MaxHealth) * 100 + 0.5))
						v.HealthText.Position = Vector2.new((BoxPos.X - 20), (BoxPos.Y + BoxSize.Y - 1 * BoxSize.Y) -1)
						v.HealthText.Color = getgenv().ShirouSettings.HealthText.Color
						v.HealthText.OutlineColor = Color3.fromRGB(0, 0, 0)
						v.HealthText.Outline = getgenv().ShirouSettings.HealthText.OutLine
	
						v.HealthText.Font = 0
						v.HealthText.Size = 16
	
						v.HealthText.Visible = true
					else
						v.HealthText.Visible = false
					end
				else
					v.Name.Visible = false
					v.BoxOutline.Visible = false
					v.Box.Visible = false
					v.HealthBarOutline.Visible = false
					v.HealthBar.Visible = false
					v.HealthText.Visible = false
					v.Distance.Visible = false
				end
			else
				v.Name.Visible = false
				v.BoxOutline.Visible = false
				v.Box.Visible = false
				v.HealthBarOutline.Visible = false
				v.HealthBar.Visible = false
				v.HealthText.Visible = false
				v.Distance.Visible = false
			end
		end
	end
	
	-- // Client Fps (EXECUTES PER FRAME)
	RS.Heartbeat:Connect(function()
		Script.Functions.GetClosestPlayer()
		Script.Functions.SilentMisc()
		Script.Functions.MouseChanger()
	end)
	
	-- // Server Tick (EXECUTES PER TICK)
	RS.RenderStepped:Connect(function()
		Script.Functions.UpdateEsp()
		Script.Functions.UpdateFOV()
		if getgenv().ShirouSettings.Enabled and getgenv().ShirouSettings.ClosestPoint and Script.Functions.Alive(SilentTarget) and Players[tostring(SilentTarget)].Character:FindFirstChild(getgenv().ShirouSettings.HitParts) then
			local ClosestPoint = Script.Functions.GetClosestPointOfPart(Players[tostring(SilentTarget)].Character[getgenv().ShirouSettings.HitParts])
			ClosestPointCF = CFrame.new(ClosestPoint.X, ClosestPoint.Y, ClosestPoint.Z)
		end
		if getgenv().ShirouSettings.AimAssistEnabled and Script.Functions.Alive(AimTarget) and getgenv().ShirouSettings.ClosestMousePoint and Script.Functions.Alive(SilentTarget) then
			local currentpart = tostring(Script.Functions.GetClosestBodyPart(AimTarget.Character))
			if getgenv().ShirouSettings.ClosestMousePoint then
				getgenv().ShirouSettings.Part = currentpart
			end
			if getgenv().ShirouSettings.ClosestMousePoint then
				getgenv().ShirouSettings.Part = currentpart
				OldSilentAimPart = getgenv().ShirouSettings.Part
			end
			return
		end
		if getgenv().ShirouSettings.AimAssistEnabled and getgenv().ShirouSettings.ClosestMousePoint and Script.Functions.Alive(AimTarget) then
			getgenv().ShirouSettings.Part = tostring(Script.Functions.GetClosestBodyPart(AimTarget.Character))
		end
		if getgenv().ShirouSettings.Enabled and getgenv().ShirouSettings.NearestHitPart and Script.Functions.Alive(SilentTarget) then
			getgenv().ShirouSettings.HitParts = tostring(Script.Functions.GetClosestBodyPart(SilentTarget.Character))
			OldSilentAimPart = getgenv().ShirouSettings.HitParts
		end
	end)
	
	-- // Checks Everyone In The Server And Puts It In A Table
	for _, Player in ipairs(Players:GetPlayers()) do
		if (Player ~= Client and Client:IsFriendsWith(Player.UserId)) then
			table.insert(Script.Friends, Player)
		end
		Script.Functions.NewPlayer(Player)
	end
	
	-- // Checks When Players Joins And Adds Them To A Table
	Players.PlayerAdded:Connect(function(Player)
		if (Client:IsFriendsWith(Player.UserId)) then
			table.insert(Script.Friends, Player)
		end
		Script.Functions.NewPlayer(Player)
	end)
	
	-- // Checks If A Player Left And Removes Them From The Table
	Players.PlayerRemoving:Connect(function(Player)
		local i = table.find(Script.Friends, Player)
		if (i) then
			table.remove(Script.Friends, i)
		end
		for i,v in pairs(Script.EspPlayers[Player]) do
			v:Remove()
		end
		Script.EspPlayers[Player] = nil
	end)
	end
