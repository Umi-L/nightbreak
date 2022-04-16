export class Vector2{
    x: number;
    y: number;

    constructor(x: number, y: number){
        this.x = x;
        this.y = y;
    }

    static add(v1: Vector2, v2: Vector2): Vector2{
        return new Vector2(v1.x + v2.x, v1.y + v2.y);
    }
    static subtract(v1: Vector2, v2: Vector2): Vector2{
        return new Vector2(v1.x - v2.x, v1.y - v2.y);
    }
}

export class Color{
    r: number;
    g: number;
    b: number;
    a: number;

    constructor(r: number, g: number, b: number, a: number){
        this.r = r;
        this.g = g;
        this.b = b;
        this.a = a;
    }
}