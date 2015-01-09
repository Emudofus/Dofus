package com.ankamagames.berilia.components.messages
{
    import com.ankamagames.berilia.components.Texture;

    public class TextureLoadFailMessage extends ComponentMessage 
    {

        private var _texture:Texture;

        public function TextureLoadFailMessage(pTexture:Texture)
        {
            super(pTexture);
            this._texture = pTexture;
        }

        public function get texture():Texture
        {
            return (this._texture);
        }


    }
}//package com.ankamagames.berilia.components.messages

