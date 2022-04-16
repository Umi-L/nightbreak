import { Component } from "../Component";
import {Actor, AABB} from "../../libraries/Physics"
import { Vector2 } from "../../types";
import { Transform } from "./Transform";

export class RigidBody extends Component {
    actor: Actor;
    gravity: Vector2;
    velocity: Vector2;
    drag: Vector2;

    constructor(boundingBox: AABB, gravity: Vector2 = new Vector2(0,50), velocity: Vector2 = new Vector2(0,0), drag: Vector2 = new Vector2(1,1)) {
        super();
        this.actor = new Actor(boundingBox);

        this.gravity = gravity;
        this.velocity = velocity;
        this.drag = drag;
    }

    update(dt:number): void {
        super.update(dt);

        this.velocity.y += this.gravity.y * dt;
        this.velocity.x += this.gravity.x * dt;

        //apply drag
        if (this.velocity.x < 0){
            this.velocity.x += this.drag.x * dt;
            
            if (this.velocity.x > 0){
                this.velocity.x = 0;
            }
        }
        else if (this.velocity.x > 0){
            this.velocity.x -= this.drag.x * dt;
            
            if (this.velocity.x < 0){
                this.velocity.x = 0;
            }
        }

        if (this.velocity.y < 0){
            this.velocity.y += this.drag.x * dt;
            
            if (this.velocity.y > 0){
                this.velocity.y = 0;
            }
        }
        else if (this.velocity.y > 0){
            this.velocity.y -= this.drag.x * dt;
            
            if (this.velocity.y < 0){
                this.velocity.y = 0;
            }
        }

        let transform = this.entity!.GetComponent(Transform);

        this.actor.collider.position = transform.position;



        //apply forces to the Actor
        this.actor.moveX(this.velocity.x, ()=>{
            this.velocity.x = 0;
        });
        this.actor.moveY(this.velocity.y, ()=>{
            this.velocity.y = 0;
        });
        this.actor.collider.updatePosition();


        transform.position = this.actor.collider.position;
    }
}