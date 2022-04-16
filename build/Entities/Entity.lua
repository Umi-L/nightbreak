local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ArrayPush = ____lualib.__TS__ArrayPush
local __TS__New = ____lualib.__TS__New
local __TS__InstanceOf = ____lualib.__TS__InstanceOf
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
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
    self.id = #entities
    __TS__ArrayPush(entities, self)
    self:AddComponent(__TS__New(Transform))
    self.transform = self:GetComponent(Transform)
end
function Entity.prototype.AddComponent(self, component)
    __TS__ArrayPush(self.components, component)
    component.entity = self
end
function Entity.prototype.GetComponent(self, constr)
    for ____, component in ipairs(self.components) do
        if __TS__InstanceOf(component, constr) then
            return component
        end
    end
    error(
        __TS__New(Error, (("Component " .. constr.name) .. " not found on Entity ") .. self.constructor.name),
        0
    )
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
    print("loaded Entity")
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
