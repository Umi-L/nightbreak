local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____Component = require("Components.Component")
local Component = ____Component.Component
local ____physics = require("libraries.physics")
local Actor = ____physics.Actor
local ____types = require("types")
local Vector2 = ____types.Vector2
local ____Transform = require("Components.Components.Transform")
local Transform = ____Transform.Transform
____exports.RigidBody = __TS__Class()
local RigidBody = ____exports.RigidBody
RigidBody.name = "RigidBody"
__TS__ClassExtends(RigidBody, Component)
function RigidBody.prototype.____constructor(self, boundingBox, gravity, velocity, drag)
    if gravity == nil then
        gravity = __TS__New(Vector2, 0, 50)
    end
    if velocity == nil then
        velocity = __TS__New(Vector2, 0, 0)
    end
    if drag == nil then
        drag = __TS__New(Vector2, 1, 1)
    end
    Component.prototype.____constructor(self)
    self.actor = __TS__New(Actor, boundingBox)
    self.gravity = gravity
    self.velocity = velocity
    self.drag = drag
end
function RigidBody.prototype.update(self, dt)
    Component.prototype.update(self, dt)
    local ____self_velocity_0, ____y_1 = self.velocity, "y"
    ____self_velocity_0[____y_1] = ____self_velocity_0[____y_1] + self.gravity.y * dt
    local ____self_velocity_2, ____x_3 = self.velocity, "x"
    ____self_velocity_2[____x_3] = ____self_velocity_2[____x_3] + self.gravity.x * dt
    if self.velocity.x < 0 then
        local ____self_velocity_4, ____x_5 = self.velocity, "x"
        ____self_velocity_4[____x_5] = ____self_velocity_4[____x_5] + self.drag.x * dt
        if self.velocity.x > 0 then
            self.velocity.x = 0
        end
    elseif self.velocity.x > 0 then
        local ____self_velocity_6, ____x_7 = self.velocity, "x"
        ____self_velocity_6[____x_7] = ____self_velocity_6[____x_7] - self.drag.x * dt
        if self.velocity.x < 0 then
            self.velocity.x = 0
        end
    end
    if self.velocity.y < 0 then
        local ____self_velocity_8, ____y_9 = self.velocity, "y"
        ____self_velocity_8[____y_9] = ____self_velocity_8[____y_9] + self.drag.x * dt
        if self.velocity.y > 0 then
            self.velocity.y = 0
        end
    elseif self.velocity.y > 0 then
        local ____self_velocity_10, ____y_11 = self.velocity, "y"
        ____self_velocity_10[____y_11] = ____self_velocity_10[____y_11] - self.drag.x * dt
        if self.velocity.y < 0 then
            self.velocity.y = 0
        end
    end
    local transform = self.entity:GetComponent(Transform)
    self.actor.collider.position = transform.position
    self.actor:moveX(
        self.velocity.x,
        function()
            self.velocity.x = 0
        end
    )
    self.actor:moveY(
        self.velocity.y,
        function()
            self.velocity.y = 0
        end
    )
    self.actor.collider:updatePosition()
    transform.position = self.actor.collider.position
end
return ____exports
