local shared = shared or getgenv and getgenv() or _G
if shared.startup then
        while task.wait() do end
end
local cloneref = cloneref or function(obj)
        return obj
end
local queue_on_teleport = queue_on_teleport or function(obj)
        return obj
end
if not shared.SkiyreLoaded then
        queue_on_teleport([[
                repeat task.wait() until game:IsLoaded()
                task.delay(0.1, function()
                        loadstring(game:HttpGet('https://raw.githubusercontent.com/popoffroblox/Skiyre/refs/heads/main/main.lua', true))()
                end)
        ]])
end
shared.SkiyreLoaded = true
shared.introFinished = false
shared.throwawayService = cloneref(game:GetService('ReplicatedStorage'))
shared.workspace = cloneref(workspace or game:GetService('Workspace'))
shared.identifyscript = ((game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/.alias', true):gsub('\n', '')) or 'Skiyre')
shared.identifyversion = ((game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/.version', true):gsub('\n', '')) or 'version couldn\'t be fetched.')
local playersService = cloneref(game:GetService('Players'))
local coreGui = cloneref(game:GetService('CoreGui'))
local starterGui = cloneref(game:GetService('StarterGui'))
local lightingService = cloneref(game:GetService('Lighting'))
local tweenService = cloneref(game:GetService('TweenService'))
local debris = cloneref(game:GetService('Debris'))
local textService = game:GetService("TextService")
local lplr = playersService.LocalPlayer
for _, activeskiyregui in ipairs(lplr.PlayerGui:GetDescendants()) do
        if activeskiyregui.Name:find('skiyre') then
                activeskiyregui:Destroy()
        end
end
for _, activeskiyregui in ipairs(coreGui:GetDescendants()) do
        if activeskiyregui.Name:find('skiyre') then
                activeskiyregui:Destroy()
        end
end
shared.assets = {
        images = {
                skiyre = 'rbxassetid://88510213951751'
        },
        sounds = {
                startup = {
                        soundId = 'rbxassetid://140419294351439',
                        playbackSpeed = math.random() * 0.3 + 0.5,
                        volume = 5,
                        looped = false,
                        name = 'startup'
                }
        }
}
local loadSound = function(data)
        if shared.sound then
                shared.sound:Destroy()
        end
        shared.sound = Instance.new('Sound')
        task.spawn(function()
                repeat task.wait() until not (shared.sound.Playing)
                shared.sound:Destroy()
        end)
        for property, value in pairs(data) do
                if property ~= 'parent' then
                        shared.sound[property:sub(1,1):upper()..property:sub(2)] = value
                end
        end
        shared.sound.Parent = data.parent or workspace
        return shared.sound
end
local createTween = function(item, effectList, duration)
        if not item then return end
        local tween = tweenService:Create(item, TweenInfo.new(duration or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), effectList)
        tween:Play()
        return tween
end
local blurFade = function(duration, size)
        local blur = Instance.new('BlurEffect')
        blur.Name = 'blur:skiyre'
        for _, blureffect in ipairs(lightingService:GetChildren()) do
                if blureffect:IsA('BlurEffect') then
                        blureffect.Parent = shared.throwawayService
                end
        end
        blur.Size = size or 10
        blur.Parent = lightingService
        debris:AddItem(blur, duration or 1)
        task.delay(duration or 1, function()
                for _, blureffect in ipairs(shared.throwawayService:GetChildren()) do
                        if blureffect:IsA('BlurEffect') then
                                blureffect.Parent = lightingService
                        end
                end
        end)
        createTween(blur, {Size = 0}, duration)
end
local initiateStartup = function()
        if shared.startup then
                shared.startup:Destroy()
        end
        blurFade(3, 20)
        loadSound(shared.assets.sounds.startup):Play()
        shared.startup = Instance.new('ScreenGui')
        shared.startup.Name = 'startup:skiyre'
        debris:AddItem(shared.startup, 2.5)
        task.delay(2.5, function()
                shared.startup = nil
        end)
        shared.startup.Parent = lplr.PlayerGui
        shared.startup.ResetOnSpawn = false
        shared.startup.IgnoreGuiInset = true

        local image = Instance.new('ImageLabel')
        image.Parent = shared.startup
        image.Size = UDim2.new(0, 400, 0, 400)
        image.BackgroundTransparency = 1
        image.AnchorPoint = Vector2.new(0.5, 0.5)
        image.Position = UDim2.new(0.5, 0, 0.5, 0)
        image.Rotation = math.random(-360, 360)
        image.Image = shared.assets.images.skiyre
        createTween(image, {Rotation = 0, Size = UDim2.new(0, 250, 0, 250)}, 1)
        task.delay(1.5, function()
                createTween(image, {ImageTransparency = 1}, 0.5)
        end)
        wait(3)
        shared.introFinished = true
end

initiateStartup()

repeat
        task.wait()
until shared.introFinished

local livenotifs = {}
local notif = function(titlemessage, description, duration)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "notificationwindow:skiyre"
        screenGui.Parent = lplr.PlayerGui
        screenGui.ResetOnSpawn = false
        local window = Instance.new("Frame")
        window.BackgroundTransparency = 1
        window.Parent = screenGui
        local notif = Instance.new("Frame")
        notif.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        notif.BackgroundTransparency = 0.2
        notif.BorderSizePixel = 0
        notif.Parent = window
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = notif
        local logo = Instance.new("ImageLabel")
        logo.Size = UDim2.new(0, 80, 0, 80)
        logo.Position = UDim2.new(0, 10, 0, 10)
        logo.BackgroundTransparency = 1
        logo.Rotation = math.random(-360, 360)
        createTween(logo, {Rotation = 0}, 1)
        logo.Image = shared.assets.images.skiyre
        logo.Parent = notif
        local title = Instance.new("TextLabel")
        title.Text = titlemessage or shared.identifyscript
        title.Size = UDim2.new(0, 280, 0, 30)
        title.Position = UDim2.new(0, 100, 0, 10)
        title.BackgroundTransparency = 1
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.Font = Enum.Font.Ubuntu
        title.TextScaled = false
        title.TextSize = 20
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.TextWrapped = false
        title.Parent = notif
        local desc = Instance.new("TextLabel")
        desc.Text = description or "Nothing here..?"
        desc.Size = UDim2.new(0, 280, 0, 50)
        desc.Position = UDim2.new(0, 100, 0, 40)
        desc.BackgroundTransparency = 1
        desc.TextColor3 = Color3.fromRGB(200, 200, 200)
        desc.TextWrapped = true
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.TextYAlignment = Enum.TextYAlignment.Top
        desc.Font = Enum.Font.Ubuntu
        desc.TextScaled = false
        desc.TextSize = 18
        desc.Parent = notif
        task.wait()
        local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)
        local screenW = vp.X
        local padX = 120
        local maxAllowedW = math.min(800, screenW - 40)
        local titleSize = textService:GetTextSize(title.Text, title.TextSize, title.Font, Vector2.new(maxAllowedW, 1000))
        local descSize  = textService:GetTextSize(desc.Text, desc.TextSize, desc.Font, Vector2.new(maxAllowedW, 1000))
        local notifWidth = math.max(382, math.ceil(math.max(titleSize.X, descSize.X) + padX))
        notifWidth = math.min(notifWidth, screenW - 20)
        local notifHeight = math.max(101, math.ceil(descSize.Y + 70))
        title.Size = UDim2.new(0, notifWidth - padX, 0, 30)
        desc.Size  = UDim2.new(0, notifWidth - padX, 0, notifHeight - 50)
        notif.Size  = UDim2.new(0, notifWidth, 0, notifHeight)
        window.Size = notif.Size
        local baseY = 0.8
        local offset = 0
        for _, active in ipairs(livenotifs) do
                offset = offset + (active.AbsoluteSize.Y + 10) / workspace.CurrentCamera.ViewportSize.Y
        end
        window.Position = UDim2.new(1, 10, baseY - offset, 0)
        table.insert(livenotifs, notif)
        local targetPos = UDim2.new(1, -window.Size.X.Offset - 10, baseY - offset, 0)
        createTween(window, {Position = targetPos}, 1)
        task.delay(duration or 3, function()
                createTween(logo, {Rotation = math.random(1, 2) == 2 and 360 or -360}, 2)
                createTween(window, {Position = UDim2.new(1, 10, baseY - offset, 0)}, 1)
                task.delay(1, function()
                        screenGui:Destroy()
                        for i, v in ipairs(livenotifs) do
                                if v == notif then
                                        table.remove(livenotifs, i)
                                        break
                                end
                        end
                end)
        end)
end

notif("Skiyre", "Loading Skiyre on " .. ({identifyexecutor()})[1], 4)

notif("Skiyre", "The script is currently in demo! Please wait :)", 10)
