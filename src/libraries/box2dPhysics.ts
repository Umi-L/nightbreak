import { Body, Fixture, newWorld, Shape, World } from "love.physics";
import { Vector2 } from "../types";

export interface ICollider{
   
}

export function createWorld(gravity:Vector2, sleep?:boolean):World{
    return newWorld(gravity.x, gravity.y, sleep);
}

let colliders: Collider[] = [];

class Collider{

    body: Body;
    shape: Shape;
    fixture: Fixture;

    constructor(body:Body, shape:Shape, fixture:Fixture, exists:Boolean = true){
        this.body = body;
        this.fixture = fixture;
        this.shape = shape;

        //allows for temporary colliders.
        if (exists){
            colliders.push(this);
        }
    }

    public Destroy() {
        delete colliders[colliders.indexOf(this)]
    }
}

