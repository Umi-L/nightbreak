local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__InstanceOf = ____lualib.__TS__InstanceOf
local __TS__Delete = ____lualib.__TS__Delete
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____Transform = require("Components.Components.Transform")
local Transform = ____Transform.Transform
local entities = {}
local Entity = __TS__Class()
Entity.name = "Entity"
function Entity.prototype.____constructor(self)
    self.components = {}
    entities[#entities + 1] = self
    self:AddComponent(__TS__New(Transform))
    self.transform = self:GetComponent(Transform)
end
function Entity.prototype.AddComponent(self, component)
    local ____self_components_0 = self.components
    ____self_components_0[#____self_components_0 + 1] = component
    component.entity = self
end
function Entity.prototype.GetComponent(self, constr)
    for ____, component in ipairs(self.components) do
        if __TS__InstanceOf(component, constr) then
            return component
        end
    end
    error((("Component " .. constr.name) .. " not found on Entity ") .. self.constructor.name)
end
function Entity.prototype.RemoveComponent(self, constr)
    do
        local i = 0
        while i < #self.components do
            if __TS__InstanceOf(self.components[i + 1], constr) then
                __TS__Delete(self.components, i + 1)
            end
            i = i + 1
        end
    end
end
function Entity.prototype.load(self)
    __TS__ArrayForEach(
        self.components,
        function(____, component)
            if component.load then
                component:load()
            end
        end
    )
end
function Entity.prototype.update(self, dt)
    __TS__ArrayForEach(
        self.components,
        function(____, component)
            if component.update then
                component:update(dt)
            end
        end
    )
end
function Entity.prototype.draw(self)
    __TS__ArrayForEach(
        self.components,
        function(____, component)
            if component.draw then
                component:draw()
            end
        end
    )
end
____exports.entities = entities
____exports.Entity = Entity
return ____exports
