import { Canvas, Drawable, Quad, SpriteBatch, Texture } from "love.graphics";
import { DRAW } from "../Engine/DrawManager";
import { Tile } from "../Entities/Entities/Tile";

export class TiledParser{
    map:any;
    tiles:Quad[];
    spriteSheet:Texture;

    tileWidth:number;
    tileHeight:number;

    canvas:Canvas;

    constructor(map:any, spriteSheet:Texture){

        this.spriteSheet = spriteSheet;
        this.canvas = love.graphics.newCanvas();


        this.map = map;

        this.tileWidth = this.map.tilewidth;

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

    initmap(){

        let layers = this.map.layers;
        love.graphics.setCanvas(this.canvas);
        love.graphics.clear();

        for (let i = 1; i <= 2; i++){
            let layer = layers[i];
            if (layer.type == "tilelayer"){
                for (let y = 0; y < layer.height!; y++){
                    for (let x = 0; x < layer.width!; x++){

                        let tileIndex = y*layer.width! + x;
                        let spriteIndex = layer.data![tileIndex+1];

                        if (spriteIndex != 0){

                            let tilex = x*this.tileWidth;
                            let tiley = y*this.tileHeight;

                            love.graphics.draw(this.spriteSheet, this.tiles[spriteIndex], tilex, tiley);
                        }
                    }
                }
            }
        }
        love.graphics.setCanvas();
    }

    
    draw(layer:number, x:number, y:number){
        DRAW(layer, ()=>{
            love.graphics.draw(this.canvas, x, y);
        });
    }
}