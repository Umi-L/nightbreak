//An implementation of the Actor solid physics system, based on this article: https://maddythorson.medium.com/celeste-and-towerfall-physics-d24bd2ae0fc5

import { DRAW } from "../Engine/DrawManager";
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

    canCollide: boolean;

    blacklistEnabled: boolean;
    collisionBlacklist:AABB[] = [];

    whitelistEnabled: boolean;
    collisionWhitelist:AABB[] = [];

    constructor(position: Vector2, width: number, height: number, exists: boolean = true, canCollide: boolean = true, blacklistEnabled: boolean = false, whitelistEnabled: boolean = false){
        this.canCollide = canCollide;
        this.whitelistEnabled = whitelistEnabled;
        this.blacklistEnabled = blacklistEnabled;

        this.position = position;

        this.width = width;
        this.height = height;

        this.p1 = new Vector2((-this.width/2) + this.position.x, (-this.height/2) + this.position.y);
        this.p2 = new Vector2((this.width/2) + this.position.x, (this.height/2) + this.position.y);


        if (exists){
            colliders.push(this);
        }
    }

    whitelistAdd(box:AABB){
        this.collisionWhitelist.push(box);
    }

    whitelistRemove(box:AABB){
        this.collisionWhitelist.splice(this.collisionWhitelist.indexOf(box), 1);
    }

    blacklistAdd(box:AABB){
        this.collisionBlacklist.push(box);
    }

    blacklistRemove(box:AABB){
        this.collisionBlacklist.splice(this.collisionBlacklist.indexOf(box), 1);
    }

    updatePosition(){
        this.p1 = new Vector2((-this.width/2) + this.position.x, (-this.height/2) + this.position.y);
        this.p2 = new Vector2((this.width/2) + this.position.x, (this.height/2) + this.position.y);
    }

    blacklistContains(box:AABB): boolean{
        if (!this.blacklistEnabled){return true}

        return this.collisionBlacklist.includes(box);
    }

    whitelistContains(box:AABB): boolean{
        if (!this.whitelistEnabled){return true}

        return this.collisionWhitelist.includes(box);
    }

    canCollideWith(other:AABB): boolean {
        if (this.canCollide && other.canCollide){
            if (!other.whitelistEnabled && !this.whitelistEnabled && 
                !this.blacklistEnabled && !other.blacklistEnabled){

                return true;
            }
            if (this.whitelistEnabled || other.whitelistEnabled){
                if (this.whitelistContains(other) && other.whitelistContains(this))
                    return true
            }
            if (this.blacklistEnabled || other.blacklistEnabled){
                if (!this.blacklistContains(other) && !other.blacklistContains(this))
                    return true
            }
        }

        return false
    }

    static IsColliding(box1: AABB, box2: AABB): boolean{

        if (!box1.canCollideWith(box2))
            return false;

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

    public PointIsColliding(point:Vector2){
        if (point.x > this.p1.x && point.x < this.p2.x && point.y < this.p1.y && point.y > this.p2.y){
            return true
        }
        return false
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

//https://stackoverflow.com/questions/3746274/line-intersection-with-aabb-rectangle
export function LineIntersects(a1:Vector2, a2:Vector2, b1:Vector2, b2:Vector2): Vector2|undefined
{
    let b = Vector2.subtract(a2, a1);
    let d = Vector2.subtract(b2, b1);
    let bDotDPerp:number = b.x * d.y - b.y * d.x;

    // if b dot d == 0, it means the lines are parallel so have infinite intersection points
    if (bDotDPerp == 0)
        return;

    let c = Vector2.subtract(b1, a1);
    let t = (c.x * d.y - c.y * d.x) / bDotDPerp;
    if (t < 0 || t > 1)
        return;

    let u = (c.x * b.y - c.y * b.x) / bDotDPerp;
    if (u < 0 || u > 1)
        return;

    b.x *= t
    b.y *= t

    let intersection:Vector2 = Vector2.add(a1, b);

    return intersection;
}

export function rayCast(pos:Vector2, angle:number, distance:number, blackList:AABB[] = [], draw:boolean = false):Vector2 | undefined{
    let x = distance*Math.sin(angle);
    let y = -(distance*Math.cos(angle));

    let pos2 = Vector2.add(pos, new Vector2(x, y));

    if (draw){
        DRAW(2, ()=>{
            love.graphics.line(pos.x, pos.y, pos2.x, pos2.y);
        })
    }


    for (let i = 0; i < colliders.length; i++){
        if (!blackList.includes(colliders[i])){
            let hit:Vector2|undefined;

            //top
            hit = LineIntersects(pos, pos2, colliders[i].p1, new Vector2(colliders[i].p2.x, colliders[i].p1.y));
            if (hit){
                if (draw){
                    DRAW(2, ()=>{
                        love.graphics.circle("line", hit!.x, hit!.y, 10);
                    })
                }
                return hit;
            }

            //bottom
            hit = LineIntersects(pos, pos2, new Vector2(colliders[i].p1.x, colliders[i].p2.y), colliders[i].p2);
            if (hit){

                if (draw){
                    DRAW(2, ()=>{
                        love.graphics.circle("line", hit!.x, hit!.y, 10);
                    })
                }

                return hit;
            }

            //left
            hit = LineIntersects(pos, pos2, colliders[i].p1, new Vector2(colliders[i].p1.x, colliders[i].p2.y));
            if (hit){

                if (draw){
                    DRAW(2, ()=>{
                        love.graphics.circle("line", hit!.x, hit!.y, 10);
                    })
                }

                return hit;
            }

            //right
            hit = LineIntersects(pos, pos2, new Vector2(colliders[i].p2.x, colliders[i].p1.y), colliders[i].p2);
            if (hit){

                if (draw){
                    DRAW(2, ()=>{
                        love.graphics.circle("line", hit!.x, hit!.y, 10);
                    })
                }

                return hit;
            }

            //checking if a point is in the rectangle
            if (colliders[i].PointIsColliding(pos)){
                console.log("point is in rect")
                if (draw){
                    DRAW(2, ()=>{
                        love.graphics.circle("line", pos!.x, pos!.y, 10);
                    })
                }

                return pos;
            }
            if (colliders[i].PointIsColliding(pos2)){
                console.log("point is in rect")

                if (draw){
                    DRAW(2, ()=>{
                        love.graphics.circle("line", pos2!.x, pos2!.y, 10);
                    })
                }

                return pos2;
            }
        }
    }

    return;
}

export function DEBUGDrawColliders(): void {
    for(let i = 0; i < colliders.length; i++){
        let collider = colliders[i];
        love.graphics.rectangle("line", collider.position.x - collider.width/2, collider.position.y - collider.height/2, collider.width, collider.height);

        love.graphics.circle("line", collider.p1.x,collider.p1.y, 10)

        love.graphics.circle("line", collider.p2.x,collider.p2.y, 10)
    }
}