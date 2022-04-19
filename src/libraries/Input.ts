
/**
 * 
 * The input system merges the love2d input systems for keyboard and joystick inputs into one.
 * 
 * the getAxis method of gathering input works for dpad, wasd, and joystick.
 * 
 * Input.keyDown() allows for non event based input checking.
 * 
 * all keynames are strings, (eg. "a") and all console keys have the "_console" salt (eg. "a_console")
 * 
 * you can register a callback function using the Input.OnPressed() & Input.OnReleased. 
 * These are meant to be put into the constructor of Entities.
 * 
 */

import { GamepadAxis, Joystick } from "love.joystick"

let held:string[] = []
let joysticks:Joystick[] = love.joystick.getJoysticks()

interface IKeyCallback{
    callback:Function;
    type: string;
}


let onPressed:IKeyCallback[] = [];
let onReleased:IKeyCallback[] = [];



love.keypressed = (key) => {

    onPressed.forEach((keyCallback) =>{
        if (keyCallback.type == "keyboard" || keyCallback.type == "both"){
            keyCallback.callback(key);
        }
    })

    if (typeof key === 'string')
        held.push(key)
}
love.keyreleased = (key) => {
    let index: number | undefined = Input.findInList(key);

    onReleased.forEach((keyCallback) =>{
        if (keyCallback.type == "keyboard" || keyCallback.type == "both"){
            keyCallback.callback(key);

        }
    })

    if (index != undefined){
        if (index > -1) {
            held.splice(index, 1);
        }
    }
}

love.gamepadpressed = (joystick, _button) => {

    let button = _button + "_console"

    onPressed.forEach((keyCallback) =>{
        if (keyCallback.type == "controller" || keyCallback.type == "both"){
            keyCallback.callback(button);

        }
    })

    if (button){
        held.push(button);
    }
}

love.gamepadreleased = (joystick, _button) => {
    let button = _button + "_console"

    let index: number | undefined = Input.findInList(button);

    onReleased.forEach((keyCallback) =>{
        if (keyCallback.type == "controller" || keyCallback.type == "both"){
            keyCallback.callback(button);

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

    static OnPressed(callback:Function, type:string = "both"): void {
        const keyCallback:IKeyCallback = {
            callback: callback,
            type: type,
        }

        onPressed.push(keyCallback);
    }

    static GetAxis(axis:string, joyMode:string="none"): number{
        let value = 0

        if (axis == "Horizontal"){
            if (this.KeyDown("a") || this.KeyDown("dpleft_console")){
                value -= 1
            }
            if (this.KeyDown("d") || this.KeyDown("dpright_console")){
                value += 1
            }

            if (value == 0 && joyMode != "none" && joysticks.length > 0){
                value = joysticks[0].getGamepadAxis(<GamepadAxis>`${joyMode}x`);
            }
        }
        else if (axis == "Vertical"){
            if (this.KeyDown("w") || this.KeyDown("dpup_console")){
                value -= 1
            }
            if (this.KeyDown("s") || this.KeyDown("dpdown_console")){
                value += 1
            }

            if (value == 0 && joyMode != "none" && joysticks.length > 0){
                value = joysticks[0].getGamepadAxis(<GamepadAxis>`${joyMode}y`);
            }
        }
        

        return value;
    }
}