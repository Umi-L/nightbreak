local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____SpriteRenderer = require("Components.Components.SpriteRenderer")
local SpriteRender = ____SpriteRenderer.SpriteRender
local ____Entity = require("Entities.Entity")
local Entity = ____Entity.Entity
local ____SolidCollider = require("Components.Components.SolidCollider")
local SolidCollider = ____SolidCollider.SolidCollider
local ____ImageTools = require("libraries.ImageTools")
local AABBFromSprite = ____ImageTools.AABBFromSprite
____exports.Tile = __TS__Class()
local Tile = ____exports.Tile
Tile.name = "Tile"
__TS__ClassExtends(Tile, Entity)
function Tile.prototype.____constructor(self)
    Entity.prototype.____constructor(self)
    local image = love.graphics.newImage("assets/icon.jpg")
    self:AddComponent(__TS__New(SpriteRender, image))
    self:AddComponent(__TS__New(
        SolidCollider,
        AABBFromSprite(nil, self.transform, image)
    ))
    self.collider = self:GetComponent(SolidCollider)
end
function Tile.prototype.update(self, dt)
    Entity.prototype.update(self, dt)
    self.collider.solid.collider.position = self.transform.position
end
return ____exports
