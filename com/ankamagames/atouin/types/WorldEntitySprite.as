package com.ankamagames.atouin.types
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class WorldEntitySprite extends TiphonSprite implements ICustomUnicNameGetter
   {
      
      public function WorldEntitySprite(param1:TiphonEntityLook, param2:int, param3:int)
      {
         super(param1);
         this._name = "mapGfx::" + param3;
         this._cellId = param2;
         this._identifier = param3;
      }
      
      private var _cellId:int;
      
      private var _identifier:int;
      
      private var _name:String;
      
      public function get cellId() : int
      {
         return this._cellId;
      }
      
      public function get identifier() : int
      {
         return this._identifier;
      }
      
      public function get customUnicName() : String
      {
         return this._name;
      }
   }
}
