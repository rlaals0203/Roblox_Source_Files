< �����Ͽ� ������ �̵��ϴ� �ڵ�>
local plrs = game:GetService("Players") --GetService �Լ��� �÷��̾���� ���Ѵ�
local plr = plrs.LocalPlayer --���� �÷��̾� ���� ����

while wait() do
	
	if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") then --�޸ӳ��̵� �Ӽ��� �ִ��� Ȯ���ϴ� �κ�

		if plr.Character.Humanoid.Jump then
			
			plr.Character.Humanoid.WalkSpeed = 60
		else
			plr.Character.Humanoid.WalkSpeed = 45
		end
	end
end

===================================================================

<������ �ڵ�>

local UIS = game:GetService("UserInputService") --GetService �Լ��� �̿��� �Է��� �����ϴ� �̺�Ʈ�� ���Ѵ�.

local RS = game:GetService("ReplicatedStorage") --GetService �Լ��� �̿��� �����̳� ReplicatedStorage�� ���Ѵ�.


UIS.InputBegan:Connect(function(input) --�Է��� �����Ǿ��� �� �۵��ϴ� �Լ�
	
	if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D then
		
		RS["HasMovedEvent"]:FireServer() --������ ���� �̺�Ʈ�� ������ ��������.
	end
end)

===================================================================

<���踦 ��� ����� �� ���� ������ �ڵ�>

local plrs = game:GetService("Players") --GetService�� �̿��� �÷��̾���� ���Ѵ�.
local plr = plrs.LocalPlayer --���� �÷��̾� ���� ����

local W = game:GetService("Workspace")
local Inventory = W:FindFirstChild("Inventory")


repeat wait() until Inventory:FindFirstChild(plr.Name .."'s Inventory")
local inv = Inventory:FindFirstChild(plr.Name .."'s Inventory")
local Conditions = inv:FindFirstChild("Conditions")


local success = false --���踦 ��� ã�Ҵ��� �����ϴ� ���� ����
while true do --��� �ݺ��Ͽ� ���谡 �ִ��� Ȯ���Ѵ�.
	
	if not success then 
		
		if Conditions["KeyOpen1"].Value then --���� 1�� ������ ������
			
			W.Key1.Transparency = 0
		else
			W.Key1.Transparency = 1
		end
		
		if Conditions["KeyOpen2"].Value then --���� 2�� ������ ������
			
			W.Key2.Transparency = 0
		else
			W.Key2.Transparency = 1
		end
		
		if Conditions["KeyOpen3"].Value then --���� 3�� ������ ������
			
			W.Key3.Transparency = 0
		else
			W.Key3.Transparency = 1
		end
	end
	
	if Conditions["KeyOpen1"].Value and Conditions["KeyOpen2"].value and Conditions["KeyOpen3"].Value then
		
		success = true --��� ���踦 ������ ������ success�� true�� �ٲ۴�.
		
		W.WoodenDoor.Transparency = 1
		W.WoodenDoor.CanCollide = false
		
		W.Key1.Transparency = 1
		W.Key2.Transparency = 1
		W.Key3.Transparency = 1
		
		for _,v in pairs (W["���� ���� 1"]:GetChildren()) do
			
			v.Transparency = 1
		end
		
		for _,v in pairs (W["���� ���� 2"]:GetChildren()) do
			
			v.Transparency = 1
		end
		
		for _,v in pairs (W["���� ���� 3"]:GetChildren()) do
			
			v.Transparency = 1
		end
	end
	
	wait()
end

===================================================================

<�÷��̾� ���� �浹 ���� �ڵ�>

local PhysService = game:GetService("PhysicsService") --GetService �Լ��� �̿��� �κ�Ͻ��� ���� ���񽺸� ���Ѵ�.
local PlayerGroup = PhysService:CreateCollisionGroup("p")

PhysService:CollisionGroupSetCollidable("p", "p", false)


local plrs = game:GetService("Players")

function CantCollide(char) --�浹�� �ȵǰ� �ϴ� �Լ�
	
	for _,v in pairs (char:GetChildren()) do
		
		if v:IsA("BasePart") then
			
			PhysService:SetPartCollisionGroup(v, "p")
		end
	end
end


plrs.PlayerAdded:Connect(function(plr) --�÷��̾ �������� �� �۵��ϴ� �Լ�
	
	plr.CharacterAdded:Connect(function(char) wait(1) --ĳ���Ͱ� �������� �� �۵��ϴ� �Լ�
		
		repeat wait() until plr.Character ~= nil
		
		CantCollide(plr.Character) --�÷��̾�� ĳ������ ���� ��ȯ�����ش�.
	end)
end)

===================================================================

<���� �ڵ�> 

local Item =  "Key1"

local W = game:GetService("Workspace")

local Inventory = W:FindFirstChild("Inventory")

local C = script.Parent.ClickDetector --Ŭ�� ������ ���� ����
C.MouseClick:Connect(function(plr) --Ŭ���� �����Ǿ��� �� �۵��ϴ� �Լ�
	
	local char = plr.Character
	if char ~= nil then
		
		local hum = char:FindFirstChild("Humanoid")
		if hum and hum.Health > 0 then
			
			if not plr.Backpack:FindFirstChild(Item) and not char:FindFirstChild(Item) then
				
				local new = game.ServerStorage[Item]:Clone()
				new.Parent = plr.Backpack --�÷��̾� �κ��丮�� ���谡 ������ ���踦 �߰����ش�.
				
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

<�׾��� �� �۵��ϴ� ī�޶� �ڵ�>

local RunService = game:GetService("RunService") --�ð� ������ ��ũ��Ʈ�� ����Ǵ� ���ؽ�Ʈ�� �����ϴ� ����

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

< �� ���� �ڵ� >
local Bot = script.Parent
local myHuman = Bot:WaitForChild("Humanoid")
local myRoot = Bot:WaitForChild("HumanoidRootPart")
local myHead = Bot:WaitForChild("Head")

local tweenService = game:GetService("TweenService")
local curTarget

local plrs = game:GetService("Players")


function findTarget() --�÷��̾ ã�� �Լ�
	
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

function checkSight(target) --�÷��̾�� ��Ҵ��� Ȯ���ϴ� �Լ�
	
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
			
			local path = game:GetService("PathfindingService"):CreatePath() --��ã�� ���� ����
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
				
				if door then --�տ� ���� ���� �� �۵��ϴ� �ڵ�
					
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
