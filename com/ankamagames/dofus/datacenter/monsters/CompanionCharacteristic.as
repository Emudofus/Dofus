package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class CompanionCharacteristic extends Object implements IDataCenter
   {
      
      public function CompanionCharacteristic() {
         super();
      }
      
      public static const MODULE:String = "CompanionCharacteristics";
      
      public static function getCompanionCharacteristicById(id:uint) : CompanionCharacteristic {
         return GameData.getObject(MODULE,id) as CompanionCharacteristic;
      }
      
      public static function getCompanionCharacteristics() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var labelId:String;
      
      public var companionId:int;
      
      public var order:int;
      
      public var initialValue:int;
      
      public var levelPerValue:int;
      
      public var valuePerLevel:int;
      
      private var _label:String;
      
      public function get label() : String {
         if(!this._label)
         {
            this._label = I18n.getUiText("ui.stats." + this.labelId);
         }
         return this._label;
      }
   }
}
