package com.ankamagames.dofus.datacenter.npcs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class TaxCollectorFirstname extends Object implements IDataCenter
   {
      
      public function TaxCollectorFirstname() {
         super();
      }
      
      protected static const _log:Logger;
      
      public static const MODULE:String = "TaxCollectorFirstnames";
      
      public static function getTaxCollectorFirstnameById(id:int) : TaxCollectorFirstname {
         return GameData.getObject(MODULE,id) as TaxCollectorFirstname;
      }
      
      public var id:int;
      
      public var firstnameId:uint;
      
      private var _firstname:String;
      
      public function get firstname() : String {
         if(!this._firstname)
         {
            this._firstname = I18n.getText(this.firstnameId);
         }
         return this._firstname;
      }
   }
}
