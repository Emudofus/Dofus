package com.ankamagames.dofus.datacenter.servers
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class ServerPopulation extends Object implements IDataCenter
   {
      
      public function ServerPopulation() {
         super();
      }
      
      public static const MODULE:String = "ServerPopulations";
      
      private static var _log:Logger;
      
      public static function getServerPopulationById(id:int) : ServerPopulation {
         return GameData.getObject(MODULE,id) as ServerPopulation;
      }
      
      public static function getServerPopulations() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var weight:int;
      
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
