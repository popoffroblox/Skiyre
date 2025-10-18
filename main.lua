local shared = getgenv and getgenv() or _G
local cloneref = cloneref or function(obj)
        return obj
end
shared.throwawayService = cloneref(game:GetService('ReplicatedStorage'))
shared.workspace = cloneref(workspace or game:GetService('Workspace'))
shared.identifyscript = 'Skiyre'
shared.identifyversion = ((game:HttpGet('https://github.com/popoffroblox/Skiyre/raw/refs/heads/main/.version', true):gsub('\n', '')) or 'version couldn\'t be fetched.')
local playersService = cloneref(game:GetService('Players'))
local coreGui = cloneref(game:GetService('CoreGui'))
local starterGui = cloneref(game:GetService('StarterGui'))
local lightingService = cloneref(game:GetService('Lighting'))
local tweenService = cloneref(game:GetService('TweenService'))
local debris = cloneref(game:GetService('Debris'))
local lplr = playersService.LocalPlayer
shared.queue_on_teleport = queue_on_teleport or function(obj)
        return obj
end
queue_on_teleport([[
        repeat task.wait() until game:IsLoaded()
        task.delay(0.1, function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/popoffroblox/Skiyre/refs/heads/main/main.lua', true))()
        end)
]])
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
        debris:AddItem(startup, 3)
        shared.startup.Parent = lplr.PlayerGui
        shared.startup.ResetOnSpawn = false
        shared.startup.IgnoreGuiInset = true

        local image = Instance.new('ImageLabel')
        image.Parent = shared.startup
        image.Size = UDim2.new(0, 400, 0, 400)
        image.BackgroundTransparency = 1
        image.AnchorPoint = Vector2.new(0.5, 0.5)
        image.Position = UDim2.new(0.5, 0, 0.5, 0)
        image.Image = shared.assets.images.skiyre
        createTween(image, {Size = UDim2.new(0, 250, 0, 250)}, 1)
        task.delay(1.5, function()
                createTween(image, {ImageTransparency = 1}, 0.5)
        end)
end

initiateStartup()
