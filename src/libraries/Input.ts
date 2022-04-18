import { GamepadAxis, Joystick } from "love.joystick"

let held:string[] = []
let joysticks:Joystick[] = love.joystick.getJoysticks()

interface IKeyCallback{
    key:string;
    callback:Function;
    type: string;
}


let onPressed:IKeyCallback[] = [];
let onReleased:IKeyCallback[] = [];



love.keypressed = (key) => {

    onPressed.forEach((keyCallback) =>{
        if (keyCallback.type == "keyboard" || keyCallback.type == "both"){
            if (key === keyCallback.key){
                keyCallback.callback();
            }
        }
    })

    if (typeof key === 'string')
        held.push(key)
}
love.keyreleased = (key) => {
    let index: number | undefined = Input.findInList(key);

    onReleased.forEach((keyCallback) =>{
        if (keyCallback.type == "keyboard" || keyCallback.type == "both"){
            if (key === keyCallback.key){
                keyCallback.callback();
            }
        }
    })

    if (index != undefined){
        if (index > -1) {
            held.splice(index, 1);
        }
    }
}

love.gamepadpressed = (joystick, button) => {

    onPressed.forEach((keyCallback) =>{
        if (keyCallback.type == "controller" || keyCallback.type == "both"){
            if (button === keyCallback.key){
                keyCallback.callback();
            }
        }
    })

    if (button){
        held.push(button);
    }
}

love.gamepadreleased = (joystick, button) => {
    let index: number | undefined = Input.findInList(button);

    onReleased.forEach((keyCallback) =>{
        if (keyCallback.type == "controller" || keyCallback.type == "both"){
            if (button === keyCallback.key){
                keyCallback.callback();
            }
        }
    })

    if (index != undefined){
        if (index > -1) {
            held.splice(index, 1);
        }
    }
}

export class Input{
    static KeyDown(key:string): boolean {
        if (Input.findInList(key)){
            return true;
        }
        return false;
    }

    static findInList(key:string): number | undefined {
        for (let i = 0; i < held.length; i++){
            if (held[i] === key){
                return i;
            }
        }
    }

    static OnPressed(key:string, callback:Function, type:string = "both"): void {
        const keyCallback:IKeyCallback = {
            key: key,
            callback: callback,
            type: type,
        }

        onPressed.push(keyCallback);
    }

    static GetAxis(axis:string, joyMode:string="none"): number{
        let value = 0

        if (axis == "Horizontal"){
            if (this.KeyDown("a") || this.KeyDown("dpleft")){
                value -= 1
            }
            if (this.KeyDown("d") || this.KeyDown("dpright")){
                value += 1
            }

            if (value == 0 && joyMode != "none" && joysticks.length > 0){
                value = joysticks[0].getGamepadAxis(<GamepadAxis>`${joyMode}x`);
            }
        }
        else if (axis == "Vertical"){
            if (this.KeyDown("w") || this.KeyDown("dpup")){
                value -= 1
            }
            if (this.KeyDown("s") || this.KeyDown("dpdown")){
                value += 1
            }

            if (value == 0 && joyMode != "none" && joysticks.length > 0){
                value = joysticks[0].getGamepadAxis(<GamepadAxis>`${joyMode}y`);
            }
        }
        

        return value;
    }
}