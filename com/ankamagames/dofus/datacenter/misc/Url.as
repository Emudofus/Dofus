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
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
