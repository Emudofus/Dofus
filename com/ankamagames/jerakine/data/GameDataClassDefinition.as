package com.ankamagames.jerakine.data
{
   import __AS3__.vec.Vector;
   import flash.utils.IDataInput;
   import flash.utils.getDefinitionByName;
   
   public class GameDataClassDefinition extends Object
   {
      
      public function GameDataClassDefinition(param1:String, param2:String) {
         super();
         this._class = getDefinitionByName(param1 + "." + param2) as Class;
         this._fields = new Vector.<GameDataField>();
      }
      
      private var _class:Class;
      
      private var _fields:Vector.<GameDataField>;
      
      public function get fields() : Vector.<GameDataField> {
         return this._fields;
      }
      
      public function read(param1:String, param2:IDataInput) : * {
         var _loc4_:GameDataField = null;
         var _loc3_:* = new this._class();
         for each (_loc4_ in this._fields)
         {
            _loc3_[_loc4_.name] = _loc4_.readData(param1,param2);
         }
         if(_loc3_ is IPostInit)
         {
            IPostInit(_loc3_).postInit();
         }
         return _loc3_;
      }
      
      public function addField(param1:String, param2:IDataInput) : void {
         var _loc3_:GameDataField = new GameDataField(param1);
         _loc3_.readType(param2);
         this._fields.push(_loc3_);
      }
   }
}
