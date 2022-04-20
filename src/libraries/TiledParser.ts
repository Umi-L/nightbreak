import { Quad, Texture } from "love.graphics";

export class TiledParser{
    map:object;
    tiles:Quad[];
    spriteSheet:Texture;

    tileWidth:number;
    tileHeight:number;

    constructor(map:object, spriteSheet:Texture){

        this.spriteSheet = spriteSheet;

        this.map = map;

        //@ts-ignore
        this.tileWidth = this.map.tilewidth;
        //@ts-ignore
        this.tileHeight = this.map.tileheight;
        
        this.tiles = TiledParser.spriteSheetToQuads(spriteSheet, this.tileHeight, this.tileWidth);

    }

    static spriteSheetToQuads(spriteSheet:Texture, tileWidth:number, tileHeight:number):Quad[]{
        let quads:Quad[] = [];

        let dimentions = spriteSheet.getDimensions()

        for (let y = 0; y < spriteSheet.getHeight()/tileHeight; y++){
            for (let x = 0; x < spriteSheet.getWidth()/tileWidth; x++){
                quads.push(love.graphics.newQuad(x*tileWidth, y*tileHeight, tileWidth, tileHeight, dimentions[0], dimentions[1]));
            }
        }
        
        return quads;
    }

    drawMap(){
        //@ts-ignore
        let layers = this.map.layers;

        for (let i = 0; i < layers.length; i++){
            let layer = layers[i];
            if (layer.type == "tilelayer"){
                for (let y = 0; y < layer.height!; y++){
                    for (let x = 0; x < layer.width!; x++){
                        let tileIndex = y*layer.width! + x;
                        let spriteIndex = layer.data![tileIndex];

                        love.graphics.draw(this.spriteSheet, this.tiles[spriteIndex], x*this.tileWidth, y*this.tileHeight)

                    }
                }
            }
        }
    }
}