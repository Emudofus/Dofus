package com.ankamagames.berilia.components.messages
{
    import com.ankamagames.berilia.components.*;

    public class TextureReadyMessage extends ComponentMessage
    {
        private var _texture:Texture;

        public function TextureReadyMessage(param1:Texture)
        {
            super(param1);
            this._texture = param1;
            return;
        }// end function

        public function get texture() : Texture
        {
            return this._texture;
        }// end function

    }
}
