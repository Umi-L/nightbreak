import { ENGINE_DRAW } from "./Engine/DrawManager";
import { ENGINE_UPDATE } from "./Engine/UpdateManager";
import { DebugSprite } from "./Entities/Entities/DebugSprite";
import { Player } from "./Entities/Entities/Player";
import { Tile } from "./Entities/Entities/Tile";
import { Entity, entities } from "./Entities/Entity";
import { DEBUGDrawColliders } from "./libraries/Physics";
import {Vector2, Color} from "./types"
// import { DEBUG_DRAW_COLLIDERS } from "./libraries/box2dPhysics"



love.load = () => {
    love.filesystem.setRequirePath(love.filesystem.getRequirePath() + ";node_modules/?/?.lua")

    let player = new Player();
    player.transform.position = new Vector2(300,0);
    let platform = new Tile();
    platform.transform.position = new Vector2(500,600);

    let debugSprite = new DebugSprite();
    debugSprite.transform.position = new Vector2(100,100);

    entities.forEach(entity =>{
        entity.load();
    });
};

love.update = (dt) => {
    ENGINE_UPDATE(dt); 
}

love.draw = () => {
    ENGINE_DRAW();
    
    // DEBUG_DRAW_COLLIDERS()

    DEBUGDrawColliders();
    
}