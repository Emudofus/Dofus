package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.components.Texture;
   
   public class TextureLoadFailMessage extends ComponentMessage
   {
      
      public function TextureLoadFailMessage(pTexture:Texture) {
         super(pTexture);
         this._texture = pTexture;
      }
      
      private var _texture:Texture;
      
      public function get texture() : Texture {
         return this._texture;
      }
   }
}
