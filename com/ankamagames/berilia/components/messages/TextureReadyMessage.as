package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.components.Texture;
   
   public class TextureReadyMessage extends ComponentMessage
   {
      
      public function TextureReadyMessage(texture:Texture) {
         super(texture);
         this._texture = texture;
      }
      
      private var _texture:Texture;
      
      public function get texture() : Texture {
         return this._texture;
      }
   }
}
