local ____lualib = require("lualib_bundle")
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____Entity = require("Entities.Entity")
local entities = ____Entity.entities
function ____exports.ENGINE_LOAD(self)
    __TS__ArrayForEach(
        entities,
        function(____, entity)
            entity:load()
        end
    )
end
return ____exports
