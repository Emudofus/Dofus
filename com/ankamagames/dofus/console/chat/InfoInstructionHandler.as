package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.network.messages.game.basic.BasicWhoAmIRequestMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicWhoIsRequestMessage;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.BuildInfos;
   import flash.system.Capabilities;
   
   public class InfoInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function InfoInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:String = null;
         var _loc5_:BasicWhoAmIRequestMessage = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Date = null;
         var _loc10_:BasicWhoIsRequestMessage = null;
         switch(param2)
         {
            case "whois":
               if(param3.length == 0)
               {
                  return;
               }
               _loc4_ = param3.shift();
               if(_loc4_.length >= 1 && _loc4_.length <= ProtocolConstantsEnum.MAX_PLAYER_OR_ACCOUNT_NAME_LEN)
               {
                  _loc10_ = new BasicWhoIsRequestMessage();
                  _loc10_.initBasicWhoIsRequestMessage(true,_loc4_);
                  ConnectionsHandler.getConnection().send(_loc10_);
               }
               break;
            case "version":
               param1.output(this.getVersion());
               break;
            case "ver":
               param1.output(this.getVersion());
               break;
            case "about":
               param1.output(this.getVersion());
               break;
            case "whoami":
               _loc5_ = new BasicWhoAmIRequestMessage();
               _loc5_.initBasicWhoAmIRequestMessage(true);
               ConnectionsHandler.getConnection().send(_loc5_);
               break;
            case "mapid":
               _loc6_ = MapDisplayManager.getInstance().currentMapPoint.x + "/" + MapDisplayManager.getInstance().currentMapPoint.y;
               _loc7_ = MapDisplayManager.getInstance().currentMapPoint.mapId.toString();
               param1.output(I18n.getUiText("ui.chat.console.currentMap",[PlayedCharacterManager.getInstance().currentMap.outdoorX + "/" + PlayedCharacterManager.getInstance().currentMap.outdoorY + ", " + _loc6_,_loc7_]));
               break;
            case "cellid":
               _loc8_ = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id).position.cellId.toString();
               param1.output(I18n.getUiText("ui.console.chat.currentCell",[_loc8_]));
               break;
            case "time":
               _loc9_ = new Date();
               param1.output(TimeManager.getInstance().formatDateIG(0) + " - " + TimeManager.getInstance().formatClock(0,false));
               break;
         }
      }
      
      private function getVersion() : String {
         return "----------------------------------------------\n" + "DOFUS CLIENT v " + BuildInfos.BUILD_VERSION + "\n" + "(c) ANKAMA GAMES (" + BuildInfos.BUILD_DATE + ") \n" + "Flash player " + Capabilities.version + "\n----------------------------------------------";
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "version":
               return I18n.getUiText("ui.chat.console.help.version");
            case "v":
               return I18n.getUiText("ui.chat.console.help.version");
            case "about":
               return I18n.getUiText("ui.chat.console.help.version");
            case "whois":
               return I18n.getUiText("ui.chat.console.help.whois");
            case "whoami":
               return I18n.getUiText("ui.chat.console.help.whoami");
            case "cellid":
               return I18n.getUiText("ui.chat.console.help.cellid");
            case "mapid":
               return I18n.getUiText("ui.chat.console.help.mapid");
            case "time":
               return I18n.getUiText("ui.chat.console.help.time");
            default:
               return I18n.getUiText("ui.chat.console.noHelp",[param1]);
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
