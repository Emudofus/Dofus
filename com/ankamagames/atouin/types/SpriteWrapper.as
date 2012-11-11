package com.ankamagames.atouin.types
{
    import com.ankamagames.jerakine.interfaces.*;
    import flash.display.*;

    public class SpriteWrapper extends Sprite implements ICustomUnicNameGetter
    {
        private var _name:String;

        public function SpriteWrapper(param1:DisplayObject, param2:uint)
        {
            addChild(param1);
            this._name = "mapGfx::" + param2;
            return;
        }// end function

        public function get customUnicName() : String
        {
            return this._name;
        }// end function

    }
}
