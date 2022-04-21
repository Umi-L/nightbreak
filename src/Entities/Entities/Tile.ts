import { Drawable, Quad, Texture } from "love.graphics";
import { SpriteRender } from "../../Components/Components/SpriteRenderer";
import { Entity } from "../Entity";
import { Solid, AABB } from "../../libraries/Physics"
import { SolidCollider } from "../../Components/Components/SolidCollider";
import { Transform } from "../../Components/Components/Transform";
import { AABBFromSprite } from "../../libraries/ImageTools";

export class Tile extends Entity {
    collider: SolidCollider;

    constructor(image:Drawable, layer:number, quad:Quad, tileWidth:number, tileHeight:number){
        super();

        this.AddComponent(new SpriteRender(image, layer, quad, "center", tileWidth, tileHeight));
        this.AddComponent(new SolidCollider(new AABB(this.transform.position, tileWidth, tileHeight)));


        this.collider = this.GetComponent(SolidCollider);
    }

    update(dt: number): void {
        super.update(dt);

        this.collider.solid.collider.position = this.transform.position;
    }
}