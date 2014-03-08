package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import flash.display.DisplayObject;
   
   public class SpriteWrapper extends Sprite implements ICustomUnicNameGetter
   {
      
      public function SpriteWrapper(content:DisplayObject, identifier:uint) {
         super();
         addChild(content);
         this._name = "mapGfx::" + identifier;
      }
      
      private var _name:String;
      
      public function get customUnicName() : String {
         return this._name;
      }
   }
}
