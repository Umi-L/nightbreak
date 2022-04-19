import { Body, Fixture, newWorld, PolygonShape, Shape, World } from "love.physics";
import { Vector2 } from "../../types";

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
        const index = colliders.indexOf(this, 0);
        if (index > -1) {
            colliders.splice(index, 1);
        }
    }
}

class RectCollider extends Collider{

    width: number;
    height: number;
    position: Vector2;

    constructor(world:World, width:number, height:number, position:Vector2){
        let body = love.physics.newBody(world, position.x, position.y);
        let shape = love.physics.newRectangleShape(width, height);
        let fixture = love.physics.newFixture(body, shape);

        super(body, shape, fixture);

        this.width = width;
        this.height = height;
        this.position = position;
    }
}

export function DEBUG_DRAW_COLLIDERS(){
    for (let i = 0; i < colliders.length; i++){
        if (colliders[i]){
            let args = (<PolygonShape>colliders[i].shape).getPoints()

            love.graphics.polygon("line", colliders[i].body.getWorldPoints(...args))
        }
    }
}