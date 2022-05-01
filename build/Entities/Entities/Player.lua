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
local ____Physics = require("libraries.Physics")
local rayCast = ____Physics.rayCast
local ____types = require("types")
local Vector2 = ____types.Vector2
local ____Entity = require("Entities.Entity")
local Entity = ____Entity.Entity
local ____Utils = require("libraries.Utils")
local Utils = ____Utils.Utils
local ____DrawManager = require("Engine.DrawManager")
local MAIN_CAMERA = ____DrawManager.MAIN_CAMERA
____exports.Player = __TS__Class()
local Player = ____exports.Player
Player.name = "Player"
__TS__ClassExtends(Player, Entity)
function Player.prototype.____constructor(self)
    Entity.prototype.____constructor(self)
    self.speed = 300
    self.maxSpeed = 10
    self.jumpForce = 20
    local image = love.graphics.newImage("assets/icon.jpg")
    self:AddComponent(__TS__New(SpriteRender, image, 1))
    self:AddComponent(__TS__New(
        RigidBody,
        AABBFromSprite(nil, self.transform, image),
        __TS__New(Vector2, 0, 0),
        nil,
        __TS__New(Vector2, 100, 100)
    ))
    self.spriteWidth = image:getWidth()
    self.spriteHeight = image:getHeight()
    self.rb = self:GetComponent(RigidBody)
    Input:OnPressed(function(____, key)
        if key == "start_console" then
            love.event.quit()
        end
        if key == "space" or key == "a_console" then
            local hit = rayCast(
                nil,
                Vector2:subtract(
                    self.transform.position,
                    __TS__New(Vector2, self.spriteWidth / 2, -self.spriteHeight / 2 - 5)
                ),
                math.pi / 2,
                self.spriteWidth,
                nil,
                true
            )
            if hit then
                self.rb.velocity = Vector2:subtract(
                    self.rb.velocity,
                    __TS__New(Vector2, 0, self.jumpForce)
                )
            end
        end
    end)
end
function Player.prototype.load(self)
    Entity.prototype.load(self)
end
function Player.prototype.update(self, dt)
    local movement = __TS__New(
        Vector2,
        Input:GetAxis("Horizontal", "left") * self.speed * dt,
        Input:GetAxis("Vertical", "left") * self.speed * dt
    )
    self.rb.velocity = Vector2:add(self.rb.velocity, movement)
    self.rb.velocity = __TS__New(
        Vector2,
        Utils:clamp(self.rb.velocity.x, -self.maxSpeed, self.maxSpeed),
        Utils:clamp(self.rb.velocity.y, -self.maxSpeed, self.maxSpeed)
    )
    Entity.prototype.update(self, dt)
    MAIN_CAMERA:setPosition(self.transform.position)
end
return ____exports
