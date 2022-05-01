local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____SpriteRenderer = require("Components.Components.SpriteRenderer")
local SpriteRender = ____SpriteRenderer.SpriteRender
local ____Entity = require("Entities.Entity")
local Entity = ____Entity.Entity
____exports.DebugSprite = __TS__Class()
local DebugSprite = ____exports.DebugSprite
DebugSprite.name = "DebugSprite"
__TS__ClassExtends(DebugSprite, Entity)
function DebugSprite.prototype.____constructor(self, layer)
    Entity.prototype.____constructor(self)
    local image = love.graphics.newImage("assets/DebugSprite.jpg")
    self:AddComponent(__TS__New(SpriteRender, image, layer))
end
return ____exports
