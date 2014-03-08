package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.components.Texture;
   
   public class TextureLoadFailMessage extends ComponentMessage
   {
      
      public function TextureLoadFailMessage(param1:Texture) {
         super(param1);
         this._texture = param1;
      }
      
      private var _texture:Texture;
      
      public function get texture() : Texture {
         return this._texture;
      }
   }
}
