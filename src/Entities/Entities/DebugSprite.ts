import { Drawable, Texture } from "love.graphics";
import { transform } from "typescript";
import { Component } from "../../Components/Component";
import { RigidBody } from "../../Components/Components/RigidBody";
import { SpriteRender } from "../../Components/Components/SpriteRenderer";
import { Transform } from "../../Components/Components/Transform";
import { AABBFromSprite } from "../../libraries/ImageTools";
import { Input } from "../../libraries/Input";
import { AABB } from "../../libraries/Physics";
import { Vector2 } from "../../types";
import { Entity } from "../Entity";
import { Utils } from "../../libraries/Utils";

export class DebugSprite extends Entity {

    constructor(layer:number){
        super();

        let image: Drawable = love.graphics.newImage("assets/DebugSprite.jpg");
        this.AddComponent(new SpriteRender(image, layer));
    }
}