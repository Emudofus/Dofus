package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import flash.net.URLVariables;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.managers.OptionManager;
   
   public class Url extends Object implements IDataCenter
   {
      
      public function Url() {
         super();
      }
      
      public static const MODULE:String = "Url";
      
      public static function getUrlById(param1:int) : Url {
         return GameData.getObject(MODULE,param1) as Url;
      }
      
      public static function getAllUrl() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var browserId:int;
      
      public var url:String;
      
      public var param:String;
      
      public var method:String;
      
      public function get variables() : Object {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc1_:URLVariables = new URLVariables();
         var _loc2_:Array = this.param.split(",");
         for each (_loc4_ in _loc2_)
         {
            if(!(_loc4_ == null || _loc4_ == "null"))
            {
               _loc3_ = _loc4_.split(":");
               if(_loc3_[1].charAt(0) == "#")
               {
                  switch(String(_loc3_[1]).toUpperCase().substr(1))
                  {
                     case "TOKEN":
                        _loc3_[1] = AuthentificationManager.getInstance().ankamaPortalKey;
                        break;
                     case "LOGIN":
                        _loc3_[1] = AuthentificationManager.getInstance().username;
                        break;
                     case "NICKNAME":
                        _loc3_[1] = PlayerManager.getInstance().nickname;
                        break;
                     case "GAME":
                        _loc3_[1] = 1;
                        break;
                     case "ACCOUNT_ID":
                        _loc3_[1] = PlayerManager.getInstance().accountId;
                        break;
                     case "PLAYER_ID":
                        _loc3_[1] = PlayedCharacterManager.getInstance().id;
                        break;
                     case "SERVER_ID":
                        _loc3_[1] = PlayerManager.getInstance().server.id;
                        break;
                     case "LANG":
                        _loc3_[1] = XmlConfig.getInstance().getEntry("config.lang.current");
                        break;
                     case "THEME":
                        _loc3_[1] = OptionManager.getOptionManager("dofus").switchUiSkin;
                        break;
                  }
               }
               _loc1_[_loc3_[0]] = _loc3_[1];
            }
         }
         return _loc1_;
      }
   }
}
