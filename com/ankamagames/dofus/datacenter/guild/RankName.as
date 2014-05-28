package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class RankName extends Object implements IDataCenter
   {
      
      public function RankName() {
         super();
      }
      
      public static const MODULE:String = "RankNames";
      
      protected static const _log:Logger;
      
      public static function getRankNameById(id:int) : RankName {
         return GameData.getObject(MODULE,id) as RankName;
      }
      
      public static function getRankNames() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var order:int;
      
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
