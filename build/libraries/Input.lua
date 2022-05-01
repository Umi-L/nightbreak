local ____lualib = require("lualib_bundle")
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
local held = {}
local joysticks = love.joystick.getJoysticks()
local onPressed = {}
local onReleased = {}
love.keypressed = function(key)
    __TS__ArrayForEach(
        onPressed,
        function(____, keyCallback)
            if keyCallback.type == "keyboard" or keyCallback.type == "both" then
                keyCallback:callback(key)
            end
        end
    )
    if type(key) == "string" then
        held[#held + 1] = key
    end
end
love.keyreleased = function(key)
    local index = ____exports.Input:findInList(key)
    __TS__ArrayForEach(
        onReleased,
        function(____, keyCallback)
            if keyCallback.type == "keyboard" or keyCallback.type == "both" then
                keyCallback:callback(key)
            end
        end
    )
    if index ~= nil then
        if index > -1 then
            __TS__ArraySplice(held, index, 1)
        end
    end
end
love.gamepadpressed = function(joystick, _button)
    local button = _button .. "_console"
    __TS__ArrayForEach(
        onPressed,
        function(____, keyCallback)
            if keyCallback.type == "controller" or keyCallback.type == "both" then
                keyCallback:callback(button)
            end
        end
    )
    if button then
        held[#held + 1] = button
    end
end
love.gamepadreleased = function(joystick, _button)
    local button = _button .. "_console"
    local index = ____exports.Input:findInList(button)
    __TS__ArrayForEach(
        onReleased,
        function(____, keyCallback)
            if keyCallback.type == "controller" or keyCallback.type == "both" then
                keyCallback:callback(button)
            end
        end
    )
    if index ~= nil then
        if index > -1 then
            __TS__ArraySplice(held, index, 1)
        end
    end
end
____exports.Input = __TS__Class()
local Input = ____exports.Input
Input.name = "Input"
function Input.prototype.____constructor(self)
end
function Input.KeyDown(self, key)
    if ____exports.Input:findInList(key) then
        return true
    end
    return false
end
function Input.findInList(self, key)
    do
        local i = 0
        while i < #held do
            if held[i + 1] == key then
                return i
            end
            i = i + 1
        end
    end
end
function Input.OnPressed(self, callback, ____type)
    if ____type == nil then
        ____type = "both"
    end
    local keyCallback = {callback = callback, type = ____type}
    onPressed[#onPressed + 1] = keyCallback
end
function Input.GetAxis(self, axis, joyMode)
    if joyMode == nil then
        joyMode = "none"
    end
    local value = 0
    if axis == "Horizontal" then
        if self:KeyDown("a") or self:KeyDown("dpleft_console") then
            value = value - 1
        end
        if self:KeyDown("d") or self:KeyDown("dpright_console") then
            value = value + 1
        end
        if value == 0 and joyMode ~= "none" and #joysticks > 0 then
            value = joysticks[1]:getGamepadAxis(joyMode .. "x")
        end
    elseif axis == "Vertical" then
        if self:KeyDown("w") or self:KeyDown("dpup_console") then
            value = value - 1
        end
        if self:KeyDown("s") or self:KeyDown("dpdown_console") then
            value = value + 1
        end
        if value == 0 and joyMode ~= "none" and #joysticks > 0 then
            value = joysticks[1]:getGamepadAxis(joyMode .. "y")
        end
    end
    return value
end
return ____exports
