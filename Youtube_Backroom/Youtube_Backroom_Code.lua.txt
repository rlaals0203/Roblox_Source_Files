< 점프하여 빠르게 이동하는 코드>
local plrs = game:GetService("Players") --GetService 함수로 플레이어들을 구한다
local plr = plrs.LocalPlayer --개인 플레이어 변수 선언

while wait() do
	
	if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") then --휴머노이드 속성이 있는지 확인하는 부분

		if plr.Character.Humanoid.Jump then
			
			plr.Character.Humanoid.WalkSpeed = 60
		else
			plr.Character.Humanoid.WalkSpeed = 45
		end
	end
end

===================================================================

<움직임 코드>

local UIS = game:GetService("UserInputService") --GetService 함수를 이용해 입력을 감지하는 이벤트를 구한다.

local RS = game:GetService("ReplicatedStorage") --GetService 함수를 이용해 컨테이너 ReplicatedStorage를 구한다.


UIS.InputBegan:Connect(function(input) --입력이 감지되었을 때 작동하는 함수
	
	if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D then
		
		RS["HasMovedEvent"]:FireServer() --움직임 감지 이벤트를 서버로 내보낸다.
	end
end)

===================================================================

<열쇠를 모두 모았을 때 문이 열리는 코드>

local plrs = game:GetService("Players") --GetService를 이용해 플레이어들을 구한다.
local plr = plrs.LocalPlayer --개인 플레이어 변수 선언

local W = game:GetService("Workspace")
local Inventory = W:FindFirstChild("Inventory")


repeat wait() until Inventory:FindFirstChild(plr.Name .."'s Inventory")
local inv = Inventory:FindFirstChild(plr.Name .."'s Inventory")
local Conditions = inv:FindFirstChild("Conditions")


local success = false --열쇠를 모두 찾았는지 감지하는 변수 선언
while true do --계속 반복하여 열쇠가 있는지 확인한다.
	
	if not success then 
		
		if Conditions["KeyOpen1"].Value then --열쇠 1을 가지고 있을때
			
			W.Key1.Transparency = 0
		else
			W.Key1.Transparency = 1
		end
		
		if Conditions["KeyOpen2"].Value then --열쇠 2을 가지고 있을때
			
			W.Key2.Transparency = 0
		else
			W.Key2.Transparency = 1
		end
		
		if Conditions["KeyOpen3"].Value then --열쇠 3을 가지고 있을때
			
			W.Key3.Transparency = 0
		else
			W.Key3.Transparency = 1
		end
	end
	
	if Conditions["KeyOpen1"].Value and Conditions["KeyOpen2"].value and Conditions["KeyOpen3"].Value then
		
		success = true --모든 열쇠를 가지고 있으면 success를 true로 바꾼다.
		
		W.WoodenDoor.Transparency = 1
		W.WoodenDoor.CanCollide = false
		
		W.Key1.Transparency = 1
		W.Key2.Transparency = 1
		W.Key3.Transparency = 1
		
		for _,v in pairs (W["열쇠 구멍 1"]:GetChildren()) do
			
			v.Transparency = 1
		end
		
		for _,v in pairs (W["열쇠 구멍 2"]:GetChildren()) do
			
			v.Transparency = 1
		end
		
		for _,v in pairs (W["열쇠 구멍 3"]:GetChildren()) do
			
			v.Transparency = 1
		end
	end
	
	wait()
end

===================================================================

<플레이어 간의 충돌 방지 코드>

local PhysService = game:GetService("PhysicsService") --GetService 함수를 이용해 로블록스의 물리 서비스를 구한다.
local PlayerGroup = PhysService:CreateCollisionGroup("p")

PhysService:CollisionGroupSetCollidable("p", "p", false)


local plrs = game:GetService("Players")

function CantCollide(char) --충돌이 안되게 하는 함수
	
	for _,v in pairs (char:GetChildren()) do
		
		if v:IsA("BasePart") then
			
			PhysService:SetPartCollisionGroup(v, "p")
		end
	end
end


plrs.PlayerAdded:Connect(function(plr) --플레이어가 접속했을 때 작동하는 함수
	
	plr.CharacterAdded:Connect(function(char) wait(1) --캐릭터가 접속했을 때 작동하는 함수
		
		repeat wait() until plr.Character ~= nil
		
		CantCollide(plr.Character) --플레이어와 캐릭터의 값을 반환시켜준다.
	end)
end)

===================================================================

<열쇠 코드> 

local Item =  "Key1"

local W = game:GetService("Workspace")

local Inventory = W:FindFirstChild("Inventory")

local C = script.Parent.ClickDetector --클릭 감지기 변수 선언
C.MouseClick:Connect(function(plr) --클릭이 감지되었을 때 작동하는 함수
	
	local char = plr.Character
	if char ~= nil then
		
		local hum = char:FindFirstChild("Humanoid")
		if hum and hum.Health > 0 then
			
			if not plr.Backpack:FindFirstChild(Item) and not char:FindFirstChild(Item) then
				
				local new = game.ServerStorage[Item]:Clone()
				new.Parent = plr.Backpack --플레이어 인벤토리에 열쇠가 없으면 열쇠를 추가해준다.
				
				local inv = Inventory:FindFirstChild(plr.Name .."'s Inventory")
				if inv then
					
					if not inv["Items"]:FindFirstChild(Item) then
						
						local newVal = Instance.new("NumberValue", inv["Items"])
						newVal.Name = Item
					end
				end
			end
		end
	end
end)

===================================================================

<죽었을 때 작동하는 카메라 코드>

local RunService = game:GetService("RunService") --시간 관리와 스크립트가 실행되는 컨텍스트를 관리하는 서비스

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

local W = game:GetService("Workspace")
local CurrentCamera = W.CurrentCamera


RunService.RenderStepped:Connect(function() --
	
	if W:FindFirstChild(plr.Name .."'s Cam") then
		
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		
		local char = plr.Character
		local hum = char.Humanoid
		if hum.Health <= 0 then
			
			W[plr.Name .."'s Cam"].Orientation = Vector3.new(-10, workspace.Part.CFrame.Rotation.Y, 0)
			CurrentCamera.CFrame = W[plr.Name .."'s Cam"].CFrame
		end
	else
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end
end)

===================================================================

< 봇 동작 코드 >
local Bot = script.Parent
local myHuman = Bot:WaitForChild("Humanoid")
local myRoot = Bot:WaitForChild("HumanoidRootPart")
local myHead = Bot:WaitForChild("Head")

local tweenService = game:GetService("TweenService")
local curTarget

local plrs = game:GetService("Players")


function findTarget() --플레이어를 찾는 함수
	
	local target
	local dist = 1000
	for _,v in pairs (plrs:GetChildren()) do
		
		local char = v.Character
		if char ~= nil then
			
			local h = char:FindFirstChild("Humanoid")
			local b = char:FindFirstChild("HumanoidRootPart")
			if h and b and h.Health > 0 and (myRoot.Position - b.Position).Magnitude <= dist then
				
				dist = (myRoot.Position - b.Position).Magnitude
				target = b
			end
		end
	end
	
	return target
end

function checkSight(target) --플레이어와 닿았는지 확인하는 함수
	
	local ray = Ray.new(myHead.Position,(target.Position - myHead.Position).Unit * 1000)
	local hit,position = workspace:FindPartOnRayWithIgnoreList(ray,{script.Parent})
	if hit then
		if hit:FindFirstChild("Humanoid") or hit.Parent:FindFirstChild("Humanoid") or hit.Parent.Parent:FindFirstChild("Humanoid") then
			
			if math.abs(hit.Position.Y - myRoot.Position.Y) < 2 then
				
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end


local doorDebounce = true

myHuman.Touched:Connect(function(obj)
	
	if obj.Name == "DoorFrame" and doorDebounce == true then
		
		doorDebounce = false
		
		local opened = obj.Parent:FindFirstChild("Opened")
		local hinge = obj.Parent:FindFirstChild("Hinge")
		local hingeOpened = obj.Parent:FindFirstChild("HingeOpened")
		local doorLock = obj:FindFirstChild("DoorLock")
		local doorOpen = obj:FindFirstChild("DoorOpen")
		if opened and hinge and hingeOpened and doorLock and doorOpen then
			
			if opened.Value == false then
				
				doorLock:Play()
				opened.Value = true
				
				myHuman.WalkSpeed = 0
				obj.CanCollide = false
				
				wait(.25)
				
				doorOpen:Play()
				tweenService:Create(hinge,TweenInfo.new(.35,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{CFrame = hingeOpened.CFrame}):Play()
				wait(.45)
				
				coroutine.resume(coroutine.create(function()
					wait(2)
					obj.CanCollide = true
				end))
				
				myHuman.WalkSpeed = 14
			end
		end
	end
	
	doorDebounce = true
end)


while true do
	
	local target = findTarget()
	if target then
		
		local sight = checkSight(target)
		if sight == true then
			
			repeat wait() myHuman:MoveTo(target.Position) until checkSight(target) == false
			
		elseif sight == false then
			
			local path = game:GetService("PathfindingService"):CreatePath() --길찾는 변수 선언
			path:ComputeAsync(myRoot.Position,target.Position)
			
			if path.Status == Enum.PathStatus.Success then
				
				for i,v in pairs(path:GetWaypoints()) do
					myHuman:MoveTo(v.Position)
					
					if v.Action == Enum.PathWaypointAction.Jump then
						myHuman.Jump = true
					end
					
					if checkSight(target) == true then
						break
					end
					
					local timeOut = myHuman.MoveToFinished:Wait(.5)
					if not timeOut then
						break
					end
				end
			else
				local door
				local dist = 1000
				
				for i,v in pairs(workspace:GetDescendants()) do
					
					local doorFrame = v:FindFirstChild("DoorFrame")
					if doorFrame then
						
						local doorClose = doorFrame:FindFirstChild("DoorClose")
						local opened = v:FindFirstChild("Opened")
						if opened and doorClose then
							if (myRoot.Position - doorFrame.Position).Magnitude <= dist then
								
								dist = (myRoot.Position - doorFrame.Position).Magnitude
								door = doorFrame
							end
						end
					end
				end
				
				if door then --앞에 문이 있을 때 작동하는 코드
					
					local path = game:GetService("PathfindingService"):CreatePath()
					path:ComputeAsync(myRoot.Position,door.Position)
					
					if path.Status == Enum.PathStatus.Success then
						
						for i,v in pairs(path:GetWaypoints()) do
							myHuman:MoveTo(v.Position)
							
							if v.Action == Enum.PathWaypointAction.Jump then
								myHuman.Jump = true
							end
							
							if checkSight(target) == true then
								break
							end
							
							local timeOut = myHuman.MoveToFinished:Wait(.5)
							
							if not timeOut then
								break
							end
						end
					end
				end
			end
		end
	end
	
	wait(.25)
end
===================================================================
