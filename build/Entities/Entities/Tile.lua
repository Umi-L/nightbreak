local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____SpriteRenderer = require("Components.Components.SpriteRenderer")
local SpriteRender = ____SpriteRenderer.SpriteRender
local ____Entity = require("Entities.Entity")
local Entity = ____Entity.Entity
local ____Physics = require("libraries.Physics")
local AABB = ____Physics.AABB
local ____SolidCollider = require("Components.Components.SolidCollider")
local SolidCollider = ____SolidCollider.SolidCollider
____exports.Tile = __TS__Class()
local Tile = ____exports.Tile
Tile.name = "Tile"
__TS__ClassExtends(Tile, Entity)
function Tile.prototype.____constructor(self, image, layer, quad, tileWidth, tileHeight)
    Entity.prototype.____constructor(self)
    self:AddComponent(__TS__New(
        SpriteRender,
        image,
        layer,
        quad,
        "center",
        tileWidth,
        tileHeight
    ))
    self:AddComponent(__TS__New(
        SolidCollider,
        __TS__New(AABB, self.transform.position, tileWidth, tileHeight)
    ))
    self.collider = self:GetComponent(SolidCollider)
end
function Tile.prototype.update(self, dt)
    Entity.prototype.update(self, dt)
    self.collider.solid.collider.position = self.transform.position
end
return ____exports
