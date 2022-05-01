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
function SpriteRender.prototype.____constructor(self, sprite, layer, quad, origin, width, height)
    if layer == nil then
        layer = 1
    end
    if origin == nil then
        origin = "center"
    end
    Component.prototype.____constructor(self)
    self.sprite = sprite
    self.layer = layer
    self.origin = origin
    self.quad = quad
    self.width = width
    self.height = height
end
function SpriteRender.prototype.draw(self)
    local transform = self.entity:GetComponent(Transform)
    local offsetX = 0
    local offsetY = 0
    if self.origin == "center" and not self.width and not self.height then
        offsetX = self.sprite:getWidth() / 2
        offsetY = self.sprite:getHeight() / 2
    else
        if not self.width or not self.height then
            error("Proveded only 1 param for width and height")
        end
        offsetX = self.width / 2
        offsetY = self.height / 2
    end
    local function callback()
        if self.quad then
            love.graphics.draw(
                self.sprite,
                self.quad,
                transform.position.x,
                transform.position.y,
                transform.rotation,
                transform.scale.x,
                transform.scale.y,
                offsetX,
                offsetY
            )
        else
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
    end
    DRAW(nil, self.layer, callback)
end
return ____exports
