import { Drawable, Texture } from "love.graphics";
import { SpriteRender } from "../../Components/Components/SpriteRenderer";
import { Entity } from "../Entity";
import { Solid, AABB } from "../../libraries/Physics"
import { SolidCollider } from "../../Components/Components/SolidCollider";
import { Transform } from "../../Components/Components/Transform";
import { AABBFromSprite } from "../../libraries/ImageTools";

export class Tile extends Entity {
    collider: SolidCollider;

    constructor(){
        super();

        let image: Drawable = love.graphics.newImage("assets/icon.jpg");
        this.AddComponent(new SpriteRender(image));
        this.AddComponent(new SolidCollider(AABBFromSprite(this.transform, image)));


        this.collider = this.GetComponent(SolidCollider);
    }

    update(dt: number): void {
        super.update(dt);

        this.collider.solid.collider.position = this.transform.position;
    }
}