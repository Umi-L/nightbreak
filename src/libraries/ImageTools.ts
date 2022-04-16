import { Drawable, Texture } from "love.graphics";
import { Transform } from "../Components/Components/Transform";
import { Vector2 } from "../types";
import { AABB } from "./Physics";

export function AABBFromSprite(transform:Transform, sprite:Drawable): AABB{
    return new AABB(transform.position, (<Texture>sprite).getWidth()*transform.scale.x, (<Texture>sprite).getHeight()*transform.scale.y);
}