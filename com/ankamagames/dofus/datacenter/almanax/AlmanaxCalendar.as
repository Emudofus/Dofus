package com.ankamagames.dofus.datacenter.almanax
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AlmanaxCalendar extends Object implements IDataCenter
   {
      
      public function AlmanaxCalendar() {
         super();
      }
      
      public static const MODULE:String = "AlmanaxCalendars";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlmanaxCalendar));
      
      public static function getAlmanaxCalendarById(id:int) : AlmanaxCalendar {
         return GameData.getObject(MODULE,id) as AlmanaxCalendar;
      }
      
      public static function getAlmanaxCalendars() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var descId:uint;
      
      public var npcId:int;
      
      private var _name:String;
      
      private var _description:String;
      
      public function get bonusName() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get bonusDescription() : String {
         if(!this._description)
         {
            this._description = I18n.getText(this.descId);
         }
         return this._description;
      }
   }
}
