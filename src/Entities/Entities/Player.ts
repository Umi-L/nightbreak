import { Drawable, Texture } from "love.graphics";
import { transform } from "typescript";
import { Component } from "../../Components/Component";
import { RigidBody } from "../../Components/Components/RigidBody";
import { SpriteRender } from "../../Components/Components/SpriteRenderer";
import { Transform } from "../../Components/Components/Transform";
import { AABBFromSprite } from "../../libraries/ImageTools";
import { Input } from "../../libraries/Input";
import { AABB, rayCast} from "../../libraries/Physics";
import { Vector2 } from "../../types";
import { Entity } from "../Entity";
import { Utils } from "../../libraries/Utils";
import { DRAW } from "../../Engine/DrawManager";

export class Player extends Entity {

    speed: number = 300;
    maxSpeed: number = 10;
    jumpForce:number = 400;

    spriteWidth:number;
    spriteHeight: number;
    rb:RigidBody;
    
    constructor(){
        super();

        let image: Drawable = love.graphics.newImage("assets/icon.jpg");
        this.AddComponent(new SpriteRender(image, 1));
        this.AddComponent(new RigidBody(AABBFromSprite(this.transform, image),undefined, undefined, new Vector2(20,5)));

        this.spriteWidth = (<Texture>image).getWidth();
        this.spriteHeight = (<Texture>image).getHeight();
        this.rb = this.GetComponent(RigidBody);


        Input.OnPressed((key:string) =>{
            if (key == "space" || key == "a_console"){
                let hit = rayCast(Vector2.subtract(this.transform.position, new Vector2(this.spriteWidth/2, (-this.spriteHeight/2) - 5)), math.pi / 2, this.spriteWidth, true)

                if (hit){
                    console.log("jumped")
                    this.rb.velocity = Vector2.add(this.rb.velocity, new Vector2(0, -this.jumpForce))

                    console.log(this.rb.velocity.y)
                }
            }
        })
    }

    load(){
        super.load();
    }

    update(dt: number): void {

        let movement = new Vector2(Input.GetAxis("Horizontal", "left")*this.speed * dt, 0);

        if (Input.KeyDown("space")){
            
        }

        this.rb.velocity = Vector2.add(this.rb.velocity, movement);

        this.rb.velocity = new Vector2(Utils.clamp(this.rb.velocity.x, -this.maxSpeed, this.maxSpeed), Utils.clamp(this.rb.velocity.y, -this.maxSpeed, this.maxSpeed));
        
        //apply velocity change to rigidb
        super.update(dt)        

    }
}