package com.ankamagames.berilia.types.event
{
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;

    public class TextureLoadFailedEvent extends Event
    {
        private var _behavior:DynamicSecureObject;
        private var _targetedTexture:Texture;
        public static const EVENT_TEXTURE_LOAD_FAILED:String = "TextureLoadFailedEvent";

        public function TextureLoadFailedEvent(param1:Texture, param2:DynamicSecureObject)
        {
            super(EVENT_TEXTURE_LOAD_FAILED, false, false);
            this._targetedTexture = param1;
            this._behavior = param2;
            return;
        }// end function

        public function get behavior() : DynamicSecureObject
        {
            return this._behavior;
        }// end function

        public function get targetedTexture() : Texture
        {
            return this._targetedTexture;
        }// end function

    }
}
