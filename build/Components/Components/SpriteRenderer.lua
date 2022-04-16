local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____DrawManager = require("Engine.DrawManager")
local DRAW = ____DrawManager.DRAW
local ____Component = require("Components.Component")
local Component = ____Component.Component
local ____Transform = require("Components.Components.Transform")
local Transform = ____Transform.Transform
____exports.SpriteRender = __TS__Class()
local SpriteRender = ____exports.SpriteRender
SpriteRender.name = "SpriteRender"
__TS__ClassExtends(SpriteRender, Component)
function SpriteRender.prototype.____constructor(self, sprite, layer, origin)
    if layer == nil then
        layer = 1
    end
    if origin == nil then
        origin = "Center"
    end
    Component.prototype.____constructor(self)
    self.sprite = sprite
    self.layer = layer
    self.origin = origin
end
function SpriteRender.prototype.draw(self)
    Component.prototype.draw(self)
    local transform = self.entity:GetComponent(Transform)
    local offsetX = 0
    local offsetY = 0
    if self.origin == "Center" then
        offsetX = self.sprite:getWidth() / 2
        offsetY = self.sprite:getHeight() / 2
    end
    local function callback()
        love.graphics.draw(
            self.sprite,
            transform.position.x,
            transform.position.y,
            transform.rotation,
            transform.scale.x,
            transform.scale.y,
            offsetX,
            offsetY
        )
    end
    DRAW(nil, self.layer, callback)
end
return ____exports
