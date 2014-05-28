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
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var search:String = null;
         var bwai:BasicWhoAmIRequestMessage = null;
         var currentMap:String = null;
         var mapId:String = null;
         var currentCell:String = null;
         var date:Date = null;
         var bwrm:BasicWhoIsRequestMessage = null;
         switch(cmd)
         {
            case "whois":
               if(args.length == 0)
               {
                  return;
               }
               search = args.shift();
               if((search.length >= 1) && (search.length <= ProtocolConstantsEnum.MAX_PLAYER_OR_ACCOUNT_NAME_LEN))
               {
                  bwrm = new BasicWhoIsRequestMessage();
                  bwrm.initBasicWhoIsRequestMessage(true,search);
                  ConnectionsHandler.getConnection().send(bwrm);
               }
               break;
            case "version":
               console.output(this.getVersion());
               break;
            case "ver":
               console.output(this.getVersion());
               break;
            case "about":
               console.output(this.getVersion());
               break;
            case "whoami":
               bwai = new BasicWhoAmIRequestMessage();
               bwai.initBasicWhoAmIRequestMessage(true);
               ConnectionsHandler.getConnection().send(bwai);
               break;
            case "mapid":
               currentMap = MapDisplayManager.getInstance().currentMapPoint.x + "/" + MapDisplayManager.getInstance().currentMapPoint.y;
               mapId = MapDisplayManager.getInstance().currentMapPoint.mapId.toString();
               console.output(I18n.getUiText("ui.chat.console.currentMap",[PlayedCharacterManager.getInstance().currentMap.outdoorX + "/" + PlayedCharacterManager.getInstance().currentMap.outdoorY + ", " + currentMap,mapId]));
               break;
            case "cellid":
               currentCell = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id).position.cellId.toString();
               console.output(I18n.getUiText("ui.console.chat.currentCell",[currentCell]));
               break;
            case "time":
               date = new Date();
               console.output(TimeManager.getInstance().formatDateIG(0) + " - " + TimeManager.getInstance().formatClock(0,false));
               break;
         }
      }
      
      private function getVersion() : String {
         return "----------------------------------------------\n" + "DOFUS CLIENT v " + BuildInfos.BUILD_VERSION + "\n" + "(c) ANKAMA GAMES (" + BuildInfos.BUILD_DATE + ") \n" + "Flash player " + Capabilities.version + "\n----------------------------------------------";
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
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
               return I18n.getUiText("ui.chat.console.noHelp",[cmd]);
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         return [];
      }
   }
}
