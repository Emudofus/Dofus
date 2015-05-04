package com.ankamagames.dofus.datacenter.characteristics
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Characteristic extends Object implements IDataCenter
   {
      
      public function Characteristic()
      {
         super();
      }
      
      public static const MODULE:String = "Characteristics";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Characteristic));
      
      public static function getCharacteristicById(param1:int) : Characteristic
      {
         return GameData.getObject(MODULE,param1) as Characteristic;
      }
      
      public static function getCharacteristics() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var keyword:String;
      
      public var nameId:uint;
      
      public var asset:String;
      
      public var categoryId:int;
      
      public var visible:Boolean;
      
      public var order:int;
      
      public var upgradable:Boolean;
      
      private var _name:String;
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
