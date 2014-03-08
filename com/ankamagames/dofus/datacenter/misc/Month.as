package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Month extends Object implements IDataCenter
   {
      
      public function Month() {
         super();
      }
      
      public static const MODULE:String = "Months";
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(Month));
      
      public static function getMonthById(param1:int) : Month {
         return GameData.getObject(MODULE,param1) as Month;
      }
      
      public static function getMonths() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
