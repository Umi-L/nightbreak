local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____Entity = require("Entities.Entity")
local Entity = ____Entity.Entity
____exports.ExampleEntity = __TS__Class()
local ExampleEntity = ____exports.ExampleEntity
ExampleEntity.name = "ExampleEntity"
__TS__ClassExtends(ExampleEntity, Entity)
function ExampleEntity.prototype.____constructor(self)
    Entity.prototype.____constructor(self)
end
function ExampleEntity.prototype.load(self)
    Entity.prototype.load(self)
end
function ExampleEntity.prototype.update(self, dt)
    Entity.prototype.update(self, dt)
end
function ExampleEntity.prototype.draw(self)
    Entity.prototype.draw(self)
end
return ____exports
