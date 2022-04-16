//An implementation of the Actor solid physics system, based on this article: https://maddythorson.medium.com/celeste-and-towerfall-physics-d24bd2ae0fc5

import { Vector2 } from "../types";

let colliders: AABB[] = [];
let actors: Actor[] = [];
let solids: Solid[] = []

//AABB Stands for axis aligned bounding box.
export class AABB{
    position: Vector2;

    p1: Vector2;
    p2: Vector2;

    width: number;
    height: number;

    constructor(position: Vector2, width: number, height: number, exists: boolean = true){
        this.position = position;

        this.width = width;
        this.height = height;

        this.p1 = new Vector2((-this.width/2) + this.position.x, (-this.height/2) + this.position.y);
        this.p2 = new Vector2((this.width/2) + this.position.x, (this.height/2) + this.position.y);


        if (exists){
            colliders.push(this);

            console.log("A collider was added")
        }
    }

    updatePosition(){
        this.p1 = new Vector2((-this.width/2) + this.position.x, (-this.height/2) + this.position.y);
        this.p2 = new Vector2((this.width/2) + this.position.x, (this.height/2) + this.position.y);
    }

    static IsColliding(box1: AABB, box2: AABB): boolean{
        if (box1.p1.y > box2.p2.y 
        || box1.p2.y < box2.p1.y) {
            return false;
        }
        if (box1.p1.x > box2.p2.x 
        || box1.p2.x < box2.p1.x) {
            return false;
        }
        return true;
    }

    Destroy() {
        delete colliders[colliders.indexOf(this)]
    }
}

export class Actor{
    collider: AABB;

    constructor(collider: AABB){
        this.collider = collider;

        actors.push(this);
    }

    collideAt(position:Vector2): boolean {
        let tempCollider: AABB = new AABB(position, this.collider.width, this.collider.height, false);
        
        for (let i = 0; i < colliders.length; i++){
            if (this.collider !== colliders[i] || colliders[i] === tempCollider){
                if (AABB.IsColliding(tempCollider, colliders[i])){
                    //cleaning up tempCollider
                    tempCollider.Destroy();
                    return true;
                }
            }
        }
        tempCollider.Destroy();
        return false;
    }

    //ported from https://maddythorson.medium.com/celeste-and-towerfall-physics-d24bd2ae0fc5
    public moveX(amount: number, onCollide?: Function): void{
        let xRemainder = amount; 
        let move:number = Math.round(xRemainder);   

        if (move != 0) { 
            xRemainder -= move; 
            let sign:number = Math.sign(move);     
            while (move != 0) { 
                if (!this.collideAt(Vector2.add(this.collider.position, new Vector2(sign, 0)))) { 
                    //There is no Solid immediately beside us 
                    this.collider.position.x += sign; 
                    move -= sign; 
                } 
                else { 
                    //Hit a solid!
                    if (onCollide) 
                        onCollide();                     
                    break; 
                } 
            } 
        } 
    }
    //ported from https://maddythorson.medium.com/celeste-and-towerfall-physics-d24bd2ae0fc5
    public moveY(amount: number, onCollide?: Function): void{
        let yRemainder = amount; 
        let move:number = Math.round(yRemainder);   

        if (move != 0) { 
            yRemainder -= move; 
            let sign:number = Math.sign(move); 

            while (move != 0) { 
                if (!this.collideAt(Vector2.add(this.collider.position, new Vector2(0, sign)))) { 
                    //There is no Solid immediately beside us 
                    this.collider.position.y += sign; 
                    move -= sign; 
                } 
                else { 
                    //Hit a solid!
                    if (onCollide) {
                        onCollide(); 
                    }
                    
                    break; 
                } 
            } 
        } 
    }
}

export class Solid{
    collider: AABB;

    constructor(collider: AABB){
        this.collider = collider;

        solids.push(this);
    }

    
}

export function DEBUGDrawColliders(): void {
    for(let i = 0; i < colliders.length; i++){
        let collider = colliders[i];
        love.graphics.rectangle("line", collider.position.x - collider.width/2, collider.position.y - collider.height/2, collider.width, collider.height);

        love.graphics.circle("line", collider.p1.x,collider.p1.y, 10)

        love.graphics.circle("line", collider.p2.x,collider.p2.y, 10)
    }
}