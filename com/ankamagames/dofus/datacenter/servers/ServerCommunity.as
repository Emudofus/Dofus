package com.ankamagames.dofus.datacenter.servers
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class ServerCommunity extends Object implements IDataCenter
   {
      
      public function ServerCommunity() {
         super();
      }
      
      public static const MODULE:String = "ServerCommunities";
      
      private static var _log:Logger;
      
      public static function getServerCommunityById(id:int) : ServerCommunity {
         return GameData.getObject(MODULE,id) as ServerCommunity;
      }
      
      public static function getServerCommunities() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var shortId:String;
      
      public var defaultCountries:Vector.<String>;
      
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
