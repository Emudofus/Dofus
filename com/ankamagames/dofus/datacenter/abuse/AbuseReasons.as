package com.ankamagames.dofus.datacenter.abuse
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AbuseReasons extends Object implements IDataCenter
   {
      
      public function AbuseReasons() {
         super();
      }
      
      public static const MODULE:String = "AbuseReasons";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbuseReasons));
      
      public static function getReasonNameById(param1:uint) : AbuseReasons {
         return GameData.getObject(MODULE,param1) as AbuseReasons;
      }
      
      public static function getReasonNames() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var _abuseReasonId:uint;
      
      public var _mask:uint;
      
      public var _reasonTextId:int;
      
      private var _name:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this._reasonTextId);
         }
         return this._name;
      }
   }
}
