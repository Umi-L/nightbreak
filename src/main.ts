import { ENGINE_DRAW } from "./Engine/DrawManager";
import { ENGINE_UPDATE } from "./Engine/UpdateManager";
import { DebugSprite } from "./Entities/Entities/DebugSprite";
import { Player } from "./Entities/Entities/Player";
import { Tile } from "./Entities/Entities/Tile";
import { entities } from "./Entities/Entity";
import { Vector2 } from "./types"
import { Debug } from "./Entities/Entities/Debug";
import { ENGINE_LOAD } from './Engine/LoadManager';
import {TiledParser } from './libraries/TiledParser';
import * as map from "./assets/testmap.json";

let parser = new TiledParser(map, love.graphics.newImage("assets/sheet.png"));


love.load = () => {


    new Debug()

    let player = new Player();
    player.transform.position = new Vector2(300, 0);
    let platform = new Tile();
    platform.transform.position = new Vector2(300, 350);
    let platform2 = new Tile();
    platform2.transform.position = new Vector2(556, 500);
    let platform3 = new Tile();
    platform3.transform.position = new Vector2(812, 500);

    platform3.collider.solid.collider.blacklistEnabled = true;
    platform3.collider.solid.collider.blacklistAdd(player.rb.actor.collider);

    let debugSprite = new DebugSprite(0);
    debugSprite.transform.position = new Vector2(100, 100);
    let debugSprite2 = new DebugSprite(2);
    debugSprite2.transform.position = new Vector2(500, 100);

    ENGINE_LOAD();
};

love.update = (dt) => {
    ENGINE_UPDATE(dt);
}

love.draw = () => {
    // parser.drawMap();

    ENGINE_DRAW();

    //DEBUGDrawColliders();

}