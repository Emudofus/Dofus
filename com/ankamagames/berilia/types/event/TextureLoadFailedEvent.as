package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   import com.ankamagames.jerakine.types.DynamicSecureObject;
   import com.ankamagames.berilia.components.Texture;
   
   public class TextureLoadFailedEvent extends Event
   {
      
      public function TextureLoadFailedEvent(param1:Texture, param2:DynamicSecureObject) {
         super(EVENT_TEXTURE_LOAD_FAILED,false,false);
         this._targetedTexture = param1;
         this._behavior = param2;
      }
      
      public static const EVENT_TEXTURE_LOAD_FAILED:String = "TextureLoadFailedEvent";
      
      private var _behavior:DynamicSecureObject;
      
      private var _targetedTexture:Texture;
      
      public function get behavior() : DynamicSecureObject {
         return this._behavior;
      }
      
      public function get targetedTexture() : Texture {
         return this._targetedTexture;
      }
   }
}
