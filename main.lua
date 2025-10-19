local shared = shared or getgenv and getgenv() or _G
local selfdestruct = function()
        while task.wait() do end
end
if shared.startup then
        selfdestruct()
end
local cloneref = cloneref or function(obj)
        return obj
end
local queue_on_teleport = queue_on_teleport or function(obj)
        return obj
end
shared.introFinished = false
shared.workspace = cloneref(workspace or game:GetService('Workspace'))
shared.identifydevelopers = {
        ['Main Developer'] = 'Sakaris (PopOff)'
}
for _, folder in {'skiyre', 'skiyre/assets'} do
        if not isfolder(folder) then
                makefolder(folder)
        end
end
writefile('skiyre/.alias', game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/.alias', true))
writefile('skiyre/.gitignore', game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/.gitignore', true))
writefile('skiyre/.loadstring', game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/.loadstring', true))
writefile('skiyre/.version', game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/.version', true))
writefile('skiyre/LICENSE', game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/LICENSE', true))
writefile('skiyre/main.lua', game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/main.lua', true))
writefile('skiyre/assets/skiyrelogo.png', game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/skiyrelogo.png', true))
shared.identifydevice = cloneref(game:GetService('UserInputService')).TouchEnabled and 'Mobile' or 'PC'
shared.identifyscript = ((game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/.alias', true):gsub('\n', '')) or 'Skiyre')
shared.identifyversion = ((game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/.version', true):gsub('\n', '')) or 'version couldn\'t be fetched.')
local playersService = cloneref(game:GetService('Players'))
local coreGui = cloneref(game:GetService('CoreGui'))
local userInputService = cloneref(game:GetService('UserInputService'))
local chatService = cloneref(game:GetService('TextChatService'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local httpService = cloneref(game:GetService('HttpService'))
local starterGui = cloneref(game:GetService('StarterGui'))
local lightingService = cloneref(game:GetService('Lighting'))
local tweenService = cloneref(game:GetService('TweenService'))
local debris = cloneref(game:GetService('Debris'))
local textService = game:GetService('TextService')
local lplr = playersService.LocalPlayer
local checkForSkiyreItems = {
        workspace,
        lightingService,
        tweenService,
        replicatedStorage,
        lplr.PlayerGui,
        coreGui
}
for _, service in ipairs(checkForSkiyreItems) do
        for _, skiyreItems in ipairs(service:GetDescendants()) do
                if skiyreItems.Name:find('skiyre') then
                        skiyreItems:Destroy()
                end
        end
end
--[[
Scrapped sounds & Images:
startup: rbxassetid://140419294351439
]]
shared.trollassets = {
        images = {
                obama = 'rbxassetid://4968764407'
        },
        sounds = {
                obama = 'rbxassetid://133250227'
        }
}
shared.assets = {
        images = {
                skiyre = 'rbxassetid://88510213951751',
        },
        sounds = {
                startup = {
                        soundId = 'rbxassetid://8486683243',
                        playbackSpeed = 0.6,
                        volume = 1,
                        looped = false,
                        name = 'startup:skiyre'
                },
                error = {
                        soundId = 'rbxassetid://2390695935',
                        playbackSpeed = 0.9,
                        volume = 4,
                        looped = false,
                        name = 'error:skiyre'
                },
                click = {
                        soundId = 'rbxassetid://4499400560',
                        playbackSpeed = 0.9,
                        volume = 0.6,
                        looped = false,
                        name = 'click:skiyre'
    --[[ amogus ]]            },
                notification = {
                        soundId = 'rbxassetid://94730000915932',
                        playbackSpeed = 0.9,
                        volume = 0.5,
                        looped = false,
                        name = 'notification:skiyre'
                }
        }
}
local cachedstartup = {
        sound = shared.assets.sounds.startup.soundId,
        image = shared.assets.images.skiyre
}
local OBAMA = math.random(1, 300)
if OBAMA == 150 then
        shared.assets.sounds.startup.Volume = 2
        shared.assets.sounds.startup.playbackSpeed = 1
        shared.assets.sounds.startup.soundId = shared.trollassets.sounds.obama
        shared.assets.images.skiyre = shared.trollassets.images.obama
end
local loadSound = function(data, ignoreifsoundexists)
        if ignoreifsoundexists == false or ignoreifsoundexists == '' or ignoreifsoundexists == nil then
                if shared.sound then
                        shared.sound:Destroy()
                end
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
                        blureffect.Parent = replicatedStorage
                end
        end
        blur.Size = size or 10
        blur.Parent = lightingService
        debris:AddItem(blur, duration or 1)
        task.delay(duration or 1, function()
                for _, blureffect in ipairs(replicatedStorage:GetChildren()) do
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
        shared.assets.sounds.startup.Volume = 0.6
        shared.assets.sounds.startup.playbackSpeed = 0.9
        shared.assets.sounds.startup.soundId = cachedstartup.sound -- ok
        shared.assets.images.skiyre = cachedstartup.image
end

--[[
wow what scrapped real??
local loading = function(active)
        local blur = Instance.new('BlurEffect')
        blur.Name = 'loadingblur:skiyre'
        blur.Size = 0
        blur.Parent = lightingService
        createTween(blur, {Size = 15}, 0.8)
        local filegui = Instance.new("ScreenGui")
        debris:AddItem(filegui, 5)
        filegui.Name = "filegui:skiyre"
        filegui.IgnoreGuiInset = true
        filegui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        filegui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        filegui.Parent = game.Players.LocalPlayer.PlayerGui

        local background = Instance.new("Frame")
        background.Size = UDim2.new(1, 0, 0, 0)
        background.Active = true
        background.BorderColor3 = Color3.fromRGB(255, 255, 255)
        background.AnchorPoint = Vector2.new(0.5, 0.5)
        background.BackgroundTransparency = 0.30000001192092896
        background.Position = UDim2.new(0.5, 0, 0.5, 0)
        background.Name = "background"
        createTween(background, {Size = UDim2.new(1, 0, 0.20000000298023224, 0)}, 0.5)
        background.BorderSizePixel = 2
        background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        background.Parent = filegui

        task.wait(0.3)

        local loadingtext = Instance.new("TextLabel")
        loadingtext.TextTransparency = 1
        createTween(loadingtext, {TextTransparency = 0}, 0.5)
        loadingtext.TextWrapped = true
        loadingtext.TextColor3 = Color3.fromRGB(255, 255, 255)
        loadingtext.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        loadingtext.Name = "loadingtext"
        loadingtext.Size = UDim2.new(1, 0, 0.4000000059604645, 0)
        loadingtext.BorderColor3 = Color3.fromRGB(0, 0, 0)
        loadingtext.AnchorPoint = Vector2.new(0.5, 0.5)
        loadingtext.BorderSizePixel = 0
        loadingtext.BackgroundTransparency = 1
        loadingtext.Position = UDim2.new(0.5, 0, 0.5, 1)
        loadingtext.FontFace = Font.new("rbxasset://fonts/families/Michroma.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        loadingtext.TextSize = 14
        loadingtext.TextScaled = true
        loadingtext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        loadingtext.Parent = background

        task.delay(3, function()
                createTween(blur, {Size = 0}, 0.8)
                createTween(background, {Size = UDim2.new(1, 0, 0, 0)}, 0.5)
                debris:AddItem(blur, 0.8)
                debris:AddItem(background, 0.5)
                createTween(loadingtext, {TextTransparency = 1}, 0.5)
                debris:AddItem(loadingtext, 0.5)
        end)
end
]]

if shared.identifydevice == 'Mobile' then
        local blur = Instance.new('BlurEffect')
        blur.Parent = lightingService
        blur.Name = 'mobileblur:skiyre'
        blur.Size = 0
        createTween(blur, {Size = 20}, 1)
        task.wait(0.5)
        local mobileAlert = Instance.new('ScreenGui')
        mobileAlert.IgnoreGuiInset = true
        mobileAlert.Name = 'mobileAlert:skiyre'
        mobileAlert.Parent = lplr.PlayerGui
        mobileAlert.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local text = Instance.new('TextLabel')
        loadSound(shared.assets.sounds.error):Play()
        text.Parent = mobileAlert
        text.TextSize = 45
        text.Size = UDim2.new(0.8, 0, 0.1, 0)
        text.Position = UDim2.new(0.1, 0, 0.45, 0)
        text.TextTransparency = 1
        createTween(text, {TextTransparency = 0}, 1.5)
        local message = 'Skiyre is not available for the mobile use.'
        text.Text = ''

        task.spawn(function()
                for sequence = 1, #message do
                        loadSound(shared.assets.sounds.click, true):Play()
                        text.Text = message:sub(1,sequence)
                        task.wait(0.02)
                end
        end)
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.new(1,1,1)
        text.TextStrokeTransparency = 0
        text.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        task.wait(5)
        repeat
                text.Text = text.Text:sub(1, #text.Text - 1)
                task.wait(0.02)
        until (text.Text == '')
        local message = 'Loading Skiyre on mobile...'

        task.spawn(function()
                for sequence = 1, #message do
                        loadSound(shared.assets.sounds.click, true):Play()
                        text.Text = message:sub(1,sequence)
                        task.wait(0.02)
                end
        end)
        task.wait(5)
        task.spawn(function()
                repeat
                        text.Text = text.Text:sub(1, #text.Text - 1)
                        task.wait(0.02)
                until (text.Text == '')
        end)
        createTween(text, {TextTransparency = 1}, 2)
        debris:AddItem(mobileAlert, 2)
        task.wait(0.5)
        createTween(blur, {Size = 0}, 2)
        debris:AddItem(blur, 2)
        task.wait(2)
        initiateStartup()
else
        initiateStartup()
end

repeat
        task.wait()
until shared.introFinished
local livenotifs = {}
local notif = function(titlemessage, description, duration)
        local skiyreNotification = Instance.new('ScreenGui')
        skiyreNotification.Name = 'notificationwindow:skiyre'
        skiyreNotification.Parent = lplr.PlayerGui
        skiyreNotification.ResetOnSpawn = false

        local window = Instance.new('Frame')
        window.BackgroundTransparency = 1
        window.Name = 'window'
        window.Size = UDim2.new(0, 500, 0.9, 0)
        window.BorderSizePixel = 0
        window.BackgroundColor3 = Color3.fromRGB(255,255,255)
        window.Parent = skiyreNotification

        local notif = Instance.new('Frame')
        notif.Name = 'notification'
        notif.BackgroundTransparency = 0.4
        notif.BorderColor3 = Color3.fromRGB(255,255,255)
        notif.BorderSizePixel = 0
        notif.Size = UDim2.new(0, 382, 0, 101)
        notif.BackgroundColor3 = Color3.fromRGB(255,255,255)
        notif.Parent = window

        local corner = Instance.new('UICorner')
        corner.CornerRadius = UDim.new(0,6)
        corner.Parent = notif

        local stroke = Instance.new('UIStroke')
        stroke.Thickness = 2
        stroke.Color = Color3.fromRGB(220,220,220)
        stroke.Parent = notif

        local strokegradient = Instance.new('UIGradient')
        strokegradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255,134,233)),ColorSequenceKeypoint.new(1, Color3.fromRGB(190,118,253))}
        strokegradient.Parent = stroke

        local gradient = Instance.new('UIGradient')
        gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(26,26,26)),ColorSequenceKeypoint.new(1, Color3.fromRGB(80,80,80))}
        gradient.Parent = notif

        local logo = Instance.new('ImageLabel')
        logo.Image = shared.assets.images.skiyre
        logo.BackgroundTransparency = 1
        logo.Position = UDim2.new(0.02, 0, 0.08, 0)
        logo.Size = UDim2.new(0, 88, 0, 88)
        logo.BorderSizePixel = 0
        logo.Parent = notif
        logo.Rotation = math.random(-360, 360)
        createTween(logo, {Rotation = 0}, 1)

        local title = Instance.new('TextLabel')
        title.Text = titlemessage or shared.identifyscript
        title.Size = UDim2.new(0, 268, 0, 44)
        title.BackgroundTransparency = 1
        title.TextColor3 = Color3.fromRGB(255,255,255)
        title.FontFace = Font.new('rbxasset://fonts/families/Ubuntu.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        title.TextScaled = true
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.TextWrapped = true
        title.Parent = notif

        local titlegradient = Instance.new('UIGradient')
        titlegradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255,134,233)),ColorSequenceKeypoint.new(1, Color3.fromRGB(190,118,253))}
        titlegradient.Parent = title

        local desc = Instance.new('TextLabel')
        desc.Text = description or 'Nothing here..?'
        desc.Size = UDim2.new(0, 268, 0, 52)
        desc.BackgroundTransparency = 1
        desc.TextColor3 = Color3.fromRGB(202,202,202)
        desc.TextWrapped = true
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.TextYAlignment = Enum.TextYAlignment.Top
        desc.FontFace = Font.new('rbxasset://fonts/families/Ubuntu.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        desc.TextSize = 20
        desc.Parent = notif
        title.Position = UDim2.new(0, 95, 0.12, 0)
        desc.Position  = UDim2.new(0, 95, 0.55, 0)
        local descriptiongradient = Instance.new('UIGradient')
        descriptiongradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(190,118,253))
        }
        descriptiongradient.Parent = desc
        local list = Instance.new('UIListLayout')
        list.VerticalAlignment = Enum.VerticalAlignment.Bottom
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Padding = UDim.new(0,15)
        list.Parent = window
        local padding = Instance.new('UIPadding')
        padding.PaddingLeft = UDim.new(0,15)
        padding.Parent = window

        task.wait()
        local viewPort = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)
        local screenWidth = viewPort.X
        local padX = 120
        local maxAllowedWidth = math.min(800, screenWidth - 40)
        local titleSize = textService:GetTextSize(title.Text, 14, Enum.Font.Ubuntu, Vector2.new(maxAllowedWidth, 1000))
        local descriptionSize  = textService:GetTextSize(desc.Text, 20, Enum.Font.Ubuntu, Vector2.new(maxAllowedWidth, 1000))
        local notifWidth = math.max(382, math.ceil(math.max(titleSize.X, descriptionSize.X) + padX))
        notifWidth = math.min(notifWidth, screenWidth - 20)
        local notifHeight = math.max(110, math.ceil(descriptionSize.Y + 85))
        title.Size = UDim2.new(0, notifWidth - padX, 0, 44)
        desc.Size = UDim2.new(0, notifWidth - padX, 0, notifHeight - 60)
        notif.Size = UDim2.new(0, notifWidth, 0, notifHeight)
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
                        notif:Destroy()
                        for i, v in ipairs(livenotifs) do
                                if v == notif then
                                        table.remove(livenotifs, i)
                                        break
                                end
                        end
                end)
        end)
end

notif('Skiyre', 'Loading Skiyre on ' .. ({identifyexecutor()})[1], 4)
notif('Skiyre', 'Created by: ' .. shared.identifydevelopers['Main Developer'], 6)
notif('Skiyre', 'The script is currently in demo! Please wait :)', 10)
