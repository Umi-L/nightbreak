local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____Component = require("Components.Component")
local Component = ____Component.Component
local ____types = require("types")
local Vector2 = ____types.Vector2
____exports.Transform = __TS__Class()
local Transform = ____exports.Transform
Transform.name = "Transform"
__TS__ClassExtends(Transform, Component)
function Transform.prototype.____constructor(self, position, rotation, scale)
    if position == nil then
        position = __TS__New(Vector2, 0, 0)
    end
    if rotation == nil then
        rotation = 0
    end
    if scale == nil then
        scale = __TS__New(Vector2, 1, 1)
    end
    Component.prototype.____constructor(self)
    self.position = position
    self.rotation = rotation
    self.scale = scale
end
return ____exports
