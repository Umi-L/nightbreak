local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____DrawManager = require("Engine.DrawManager")
local DRAW = ____DrawManager.DRAW
local ____Entity = require("Entities.Entity")
local Entity = ____Entity.Entity
____exports.Debug = __TS__Class()
local Debug = ____exports.Debug
Debug.name = "Debug"
__TS__ClassExtends(Debug, Entity)
function Debug.prototype.update(self, dt)
    Entity.prototype.update(self, dt)
    DRAW(
        nil,
        5,
        function()
            love.graphics.print(
                "Current FPS: " .. tostring(love.timer.getFPS()),
                10,
                10
            )
        end,
        true
    )
end
return ____exports
