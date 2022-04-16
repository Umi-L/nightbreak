local ____lualib = require("lualib_bundle")
local __TS__ArrayPush = ____lualib.__TS__ArrayPush
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
local held = {}
local joysticks = love.joystick.getJoysticks()
love.keypressed = function(key)
    if type(key) == "string" then
        __TS__ArrayPush(held, key)
    end
end
love.keyreleased = function(key)
    local index = ____exports.Input:findInList(key)
    if index ~= nil then
        if index > -1 then
            __TS__ArraySplice(held, index, 1)
        end
    end
end
love.gamepadpressed = function(joystick, button)
    if button then
        __TS__ArrayPush(held, button)
    end
end
love.gamepadreleased = function(joystick, button)
    local index = ____exports.Input:findInList(button)
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
function Input.GetAxis(self, axis, joyMode)
    if joyMode == nil then
        joyMode = "none"
    end
    local value = 0
    if axis == "Horizontal" then
        if self:KeyDown("a") or self:KeyDown("dpleft") then
            value = value - 1
        end
        if self:KeyDown("d") or self:KeyDown("dpright") then
            value = value + 1
        end
        if value == 0 and joyMode ~= "none" then
            value = joysticks[1]:getGamepadAxis(joyMode .. "x")
        end
    elseif axis == "Vertical" then
        if self:KeyDown("w") or self:KeyDown("dpup") then
            value = value - 1
        end
        if self:KeyDown("s") or self:KeyDown("dpdown") then
            value = value + 1
        end
        if value == 0 and joyMode ~= "none" then
            value = joysticks[1]:getGamepadAxis(joyMode .. "y")
        end
    end
    return value
end
return ____exports
