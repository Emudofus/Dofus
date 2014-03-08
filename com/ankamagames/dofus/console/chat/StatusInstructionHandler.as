package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.death.GameRolePlayFreeSoulRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateRequestMessage;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.data.I18n;
   
   public class StatusInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function StatusInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:PlayerStatus = null;
         var _loc6_:GameRolePlayFreeSoulRequestMessage = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc5_:PlayerStatusUpdateRequestMessage = new PlayerStatusUpdateRequestMessage();
         switch(param2)
         {
            case "away":
            case I18n.getUiText("ui.chat.status.away").toLocaleLowerCase():
               if(param3.length > 0)
               {
                  _loc7_ = "";
                  for each (_loc8_ in param3)
                  {
                     _loc7_ = _loc7_ + (_loc8_ + " ");
                  }
                  _loc4_ = new PlayerStatusExtended();
                  PlayerStatusExtended(_loc4_).initPlayerStatusExtended(PlayerStatusEnum.PLAYER_STATUS_AFK,_loc7_);
                  KernelEventsManager.getInstance().processCallback(SocialHookList.NewAwayMessage,_loc7_);
               }
               else
               {
                  _loc4_ = new PlayerStatus();
                  _loc4_.initPlayerStatus(PlayerStatusEnum.PLAYER_STATUS_AFK);
               }
               _loc5_.initPlayerStatusUpdateRequestMessage(_loc4_);
               ConnectionsHandler.getConnection().send(_loc5_);
               break;
            case I18n.getUiText("ui.chat.status.solo").toLocaleLowerCase():
               _loc4_ = new PlayerStatus();
               _loc4_.initPlayerStatus(PlayerStatusEnum.PLAYER_STATUS_SOLO);
               _loc5_.initPlayerStatusUpdateRequestMessage(_loc4_);
               ConnectionsHandler.getConnection().send(_loc5_);
               break;
            case I18n.getUiText("ui.chat.status.private").toLocaleLowerCase():
               _loc4_ = new PlayerStatus();
               _loc4_.initPlayerStatus(PlayerStatusEnum.PLAYER_STATUS_PRIVATE);
               _loc5_.initPlayerStatusUpdateRequestMessage(_loc4_);
               ConnectionsHandler.getConnection().send(_loc5_);
               break;
            case I18n.getUiText("ui.chat.status.availiable").toLocaleLowerCase():
               _loc4_ = new PlayerStatus();
               _loc4_.initPlayerStatus(PlayerStatusEnum.PLAYER_STATUS_AVAILABLE);
               _loc5_.initPlayerStatusUpdateRequestMessage(_loc4_);
               ConnectionsHandler.getConnection().send(_loc5_);
               break;
            case "release":
               _loc6_ = new GameRolePlayFreeSoulRequestMessage();
               ConnectionsHandler.getConnection().send(_loc6_);
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "away":
            case I18n.getUiText("ui.chat.status.away").toLocaleLowerCase():
               return "- /" + I18n.getUiText("ui.chat.status.away".toLocaleLowerCase()) + I18n.getUiText("ui.common.colon") + I18n.getUiText("ui.chat.status.awaytooltip");
            case I18n.getUiText("ui.chat.status.solo").toLocaleLowerCase():
               return "- /" + I18n.getUiText("ui.chat.status.solo").toLocaleLowerCase() + I18n.getUiText("ui.common.colon") + I18n.getUiText("ui.chat.status.solotooltip");
            case I18n.getUiText("ui.chat.status.private").toLocaleLowerCase():
               return "- /" + I18n.getUiText("ui.chat.status.private").toLocaleLowerCase() + I18n.getUiText("ui.common.colon") + I18n.getUiText("ui.chat.status.privatetooltip");
            case I18n.getUiText("ui.chat.status.availiable").toLocaleLowerCase():
               return "- /" + I18n.getUiText("ui.chat.status.availiable").toLocaleLowerCase() + I18n.getUiText("ui.common.colon") + I18n.getUiText("ui.chat.status.availiabletooltip");
            case "release":
               return I18n.getUiText("ui.common.freeSoul");
            default:
               return I18n.getUiText("ui.chat.console.noHelp",[param1]);
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
