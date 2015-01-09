package com.ankamagames.atouin.types
{
    import flash.display.Sprite;
    import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
    import flash.display.DisplayObject;

    public class SpriteWrapper extends Sprite implements ICustomUnicNameGetter 
    {

        private var _name:String;

        public function SpriteWrapper(content:DisplayObject, identifier:uint)
        {
            addChild(content);
            this._name = ("mapGfx::" + identifier);
        }

        public function get customUnicName():String
        {
            return (this._name);
        }


    }
}//package com.ankamagames.atouin.types

