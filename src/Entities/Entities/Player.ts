import { Drawable, Texture } from "love.graphics";
import { transform } from "typescript";
import { Component } from "../../Components/Component";
import { RigidBody } from "../../Components/Components/RigidBody";
import { SpriteRender } from "../../Components/Components/SpriteRenderer";
import { Transform } from "../../Components/Components/Transform";
import { AABBFromSprite } from "../../libraries/ImageTools";
import { Input } from "../../libraries/Input";
import { AABB, rayCast } from "../../libraries/Physics";
import { Vector2 } from "../../types";
import { Entity } from "../Entity";
import { Utils } from "../../libraries/Utils";
import { DRAW, MAIN_CAMERA } from "../../Engine/DrawManager";

export class Player extends Entity {

    speed: number = 300;
    maxSpeed: number = 10;
    jumpForce: number = 20;

    spriteWidth: number;
    spriteHeight: number;
    rb: RigidBody;

    constructor() {
        super();

        let image: Drawable = love.graphics.newImage("assets/icon.jpg");
        this.AddComponent(new SpriteRender(image, 1));
        this.AddComponent(new RigidBody(AABBFromSprite(this.transform, image), undefined, undefined, new Vector2(100, 5)));

        this.spriteWidth = (<Texture>image).getWidth();
        this.spriteHeight = (<Texture>image).getHeight();
        this.rb = this.GetComponent(RigidBody);


        Input.OnPressed((key: string) => {
            if (key == "start_console") {
                love.event.quit();
            }

            if (key == "space" || key == "a_console") {
                let hit = rayCast(Vector2.subtract(this.transform.position, new Vector2(this.spriteWidth / 2, (-this.spriteHeight / 2) - 5)), math.pi / 2, this.spriteWidth, true)

                if (hit) {
                    this.rb.velocity = Vector2.subtract(this.rb.velocity, new Vector2(0, this.jumpForce))
                }
            }
        })
    }

    load() {
        super.load();
    }

    update(dt: number): void {

        let movement = new Vector2(Input.GetAxis("Horizontal", "left") * this.speed * dt, 0);

        this.rb.velocity = Vector2.add(this.rb.velocity, movement);

        this.rb.velocity = new Vector2(Utils.clamp(this.rb.velocity.x, -this.maxSpeed, this.maxSpeed), this.rb.velocity.y);

        //apply velocity change to rigidb
        super.update(dt)

        MAIN_CAMERA.setPosition(this.transform.position)
    }
}