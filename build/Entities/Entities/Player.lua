local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____RigidBody = require("Components.Components.RigidBody")
local RigidBody = ____RigidBody.RigidBody
local ____SpriteRenderer = require("Components.Components.SpriteRenderer")
local SpriteRender = ____SpriteRenderer.SpriteRender
local ____ImageTools = require("libraries.ImageTools")
local AABBFromSprite = ____ImageTools.AABBFromSprite
local ____Input = require("libraries.Input")
local Input = ____Input.Input
local ____types = require("types")
local Vector2 = ____types.Vector2
local ____Entity = require("Entities.Entity")
local Entity = ____Entity.Entity
local ____Utils = require("libraries.Utils")
local Utils = ____Utils.Utils
____exports.Player = __TS__Class()
local Player = ____exports.Player
Player.name = "Player"
__TS__ClassExtends(Player, Entity)
function Player.prototype.____constructor(self)
    Entity.prototype.____constructor(self)
    self.speed = 300
    self.maxSpeed = 10
    local image = love.graphics.newImage("assets/icon.jpg")
    self:AddComponent(__TS__New(SpriteRender, image, 1))
    self:AddComponent(__TS__New(
        RigidBody,
        AABBFromSprite(nil, self.transform, image),
        nil,
        nil,
        __TS__New(Vector2, 20, 5)
    ))
end
function Player.prototype.load(self)
    Entity.prototype.load(self)
end
function Player.prototype.update(self, dt)
    Entity.prototype.update(self, dt)
    local movement = __TS__New(
        Vector2,
        Input:GetAxis("Horizontal", "left") * self.speed * dt,
        Input:GetAxis("Vertical", "left") * self.speed * dt
    )
    local rb = self:GetComponent(RigidBody)
    rb.velocity = Vector2:add(rb.velocity, movement)
    rb.velocity = __TS__New(
        Vector2,
        Utils:clamp(rb.velocity.x, -self.maxSpeed, self.maxSpeed),
        Utils:clamp(rb.velocity.y, -self.maxSpeed, self.maxSpeed)
    )
end
return ____exports
