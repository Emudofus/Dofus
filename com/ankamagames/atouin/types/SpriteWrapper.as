package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import flash.display.DisplayObject;
   
   public class SpriteWrapper extends Sprite implements ICustomUnicNameGetter
   {
      
      public function SpriteWrapper(param1:DisplayObject, param2:uint) {
         super();
         addChild(param1);
         this._name = "mapGfx::" + param2;
      }
      
      private var _name:String;
      
      public function get customUnicName() : String {
         return this._name;
      }
   }
}
