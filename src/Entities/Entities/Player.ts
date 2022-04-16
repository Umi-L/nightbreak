import { Drawable, Texture } from "love.graphics";
import { transform } from "typescript";
import { Component } from "../../Components/Component";
import { RigidBody } from "../../Components/Components/RigidBody";
import { SpriteRender } from "../../Components/Components/SpriteRenderer";
import { Transform } from "../../Components/Components/Transform";
import { AABBFromSprite } from "../../libraries/ImageTools";
import { Input } from "../../libraries/Input";
import { AABB } from "../../libraries/physics";
import { Vector2 } from "../../types";
import { Entity } from "../Entity";
import { Utils } from "../../libraries/Utils";

export class Player extends Entity {

    speed: number = 300;
    maxSpeed: number = 10;

    constructor(){
        super();

        let image: Drawable = love.graphics.newImage("assets/icon.jpg");
        this.AddComponent(new SpriteRender(image, 1));
        this.AddComponent(new RigidBody(AABBFromSprite(this.transform, image),undefined, undefined, new Vector2(20,5)));

    }

    load(){
        super.load();
    }

    update(dt: number): void {
        super.update(dt)

        let movement = new Vector2(Input.GetAxis("Horizontal", "left")*this.speed * dt, Input.GetAxis("Vertical", "left")*this.speed*dt);
        let rb = this.GetComponent(RigidBody);

        rb.velocity = Vector2.add(rb.velocity, movement);

        rb.velocity = new Vector2(Utils.clamp(rb.velocity.x, -this.maxSpeed, this.maxSpeed), Utils.clamp(rb.velocity.y, -this.maxSpeed, this.maxSpeed));
        
    }
}