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
      
      public static function getUrlById(id:int) : Url {
         return GameData.getObject(MODULE,id) as Url;
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
         var split2:Array = null;
         var it:String = null;
         var data:URLVariables = new URLVariables();
         var split1:Array = this.param.split(",");
         for each (it in split1)
         {
            if(!((it == null) || (it == "null")))
            {
               split2 = it.split(":");
               if(split2[1].charAt(0) == "#")
               {
                  switch(String(split2[1]).toUpperCase().substr(1))
                  {
                     case "TOKEN":
                        split2[1] = AuthentificationManager.getInstance().ankamaPortalKey;
                        break;
                     case "LOGIN":
                        split2[1] = AuthentificationManager.getInstance().username;
                        break;
                     case "NICKNAME":
                        split2[1] = PlayerManager.getInstance().nickname;
                        break;
                     case "GAME":
                        split2[1] = 1;
                        break;
                     case "ACCOUNT_ID":
                        split2[1] = PlayerManager.getInstance().accountId;
                        break;
                     case "PLAYER_ID":
                        split2[1] = PlayedCharacterManager.getInstance().id;
                        break;
                     case "SERVER_ID":
                        split2[1] = PlayerManager.getInstance().server.id;
                        break;
                     case "LANG":
                        split2[1] = XmlConfig.getInstance().getEntry("config.lang.current");
                        break;
                     case "THEME":
                        split2[1] = OptionManager.getOptionManager("dofus").switchUiSkin;
                        break;
                  }
               }
               data[split2[0]] = split2[1];
            }
         }
         return data;
      }
   }
}
