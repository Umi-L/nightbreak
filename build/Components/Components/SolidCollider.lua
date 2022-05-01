local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____Component = require("Components.Component")
local Component = ____Component.Component
local ____Physics = require("libraries.Physics")
local Solid = ____Physics.Solid
____exports.SolidCollider = __TS__Class()
local SolidCollider = ____exports.SolidCollider
SolidCollider.name = "SolidCollider"
__TS__ClassExtends(SolidCollider, Component)
function SolidCollider.prototype.____constructor(self, boundingBox)
    Component.prototype.____constructor(self)
    self.solid = __TS__New(Solid, boundingBox)
end
function SolidCollider.prototype.update(self, dt)
    self.solid.collider:updatePosition()
end
return ____exports
