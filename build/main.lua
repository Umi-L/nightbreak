local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____DrawManager = require("Engine.DrawManager")
local ENGINE_DRAW = ____DrawManager.ENGINE_DRAW
local ____UpdateManager = require("Engine.UpdateManager")
local ENGINE_UPDATE = ____UpdateManager.ENGINE_UPDATE
local ____DebugSprite = require("Entities.Entities.DebugSprite")
local DebugSprite = ____DebugSprite.DebugSprite
local ____Player = require("Entities.Entities.Player")
local Player = ____Player.Player
local ____types = require("types")
local Vector2 = ____types.Vector2
local ____Debug = require("Entities.Entities.Debug")
local Debug = ____Debug.Debug
local ____LoadManager = require("Engine.LoadManager")
local ENGINE_LOAD = ____LoadManager.ENGINE_LOAD
local ____TiledParser = require("libraries.TiledParser")
local TiledParser = ____TiledParser.TiledParser
local map = require("assets.testmap")
local ____Physics = require("libraries.Physics")
local DEBUGDrawColliders = ____Physics.DEBUGDrawColliders
local parser = __TS__New(
    TiledParser,
    map,
    love.graphics.newImage("assets/sheet.png")
)
love.load = function()
    __TS__New(Debug)
    local player = __TS__New(Player)
    player.transform.position = __TS__New(Vector2, 300, -200)
    local debugSprite = __TS__New(DebugSprite, 0)
    debugSprite.transform.position = __TS__New(Vector2, 100, 100)
    local debugSprite2 = __TS__New(DebugSprite, 2)
    debugSprite2.transform.position = __TS__New(Vector2, 500, 100)
    parser:initmap()
    ENGINE_LOAD(nil)
end
love.update = function(dt)
    ENGINE_UPDATE(nil, dt)
end
love.draw = function()
    parser:draw(5, 0, 0)
    ENGINE_DRAW(nil)
    DEBUGDrawColliders(nil)
end
return ____exports
