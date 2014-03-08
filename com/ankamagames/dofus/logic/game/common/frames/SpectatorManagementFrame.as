package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.types.game.context.fight.FightExternalInformations;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightListMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.MapRunningFightDetailsRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightDetailsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.StopToListenRunningFightRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightDetailsMessage;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.JoinAsSpectatorRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.JoinFightRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.GameFightSpectatePlayerRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectatePlayerRequestMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.game.common.actions.OpenCurrentFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.StopToListenRunningFightAction;
   
   public class SpectatorManagementFrame extends Object implements Frame
   {
      
      public function SpectatorManagementFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpectatorManagementFrame));
      
      private static function sortFights(param1:FightExternalInformations, param2:FightExternalInformations) : int {
         if(param1.fightStart == param2.fightStart)
         {
            return 0;
         }
         if(param1.fightStart == 0)
         {
            return -1;
         }
         if(param2.fightStart == 0)
         {
            return 1;
         }
         return param2.fightStart - param1.fightStart;
      }
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:MapRunningFightListRequestMessage = null;
         var _loc3_:MapRunningFightListMessage = null;
         var _loc4_:Vector.<FightExternalInformations> = null;
         var _loc5_:MapRunningFightDetailsRequestAction = null;
         var _loc6_:MapRunningFightDetailsRequestMessage = null;
         var _loc7_:StopToListenRunningFightRequestMessage = null;
         var _loc8_:MapRunningFightDetailsMessage = null;
         var _loc9_:JoinAsSpectatorRequestAction = null;
         var _loc10_:GameFightJoinRequestMessage = null;
         var _loc11_:JoinFightRequestAction = null;
         var _loc12_:GameFightSpectatePlayerRequestAction = null;
         var _loc13_:GameFightSpectatePlayerRequestMessage = null;
         var _loc14_:FightExternalInformations = null;
         switch(true)
         {
            case param1 is OpenCurrentFightAction:
               _loc2_ = new MapRunningFightListRequestMessage();
               _loc2_.initMapRunningFightListRequestMessage();
               ConnectionsHandler.getConnection().send(_loc2_);
               return true;
            case param1 is MapRunningFightListMessage:
               _loc3_ = param1 as MapRunningFightListMessage;
               _loc4_ = new Vector.<FightExternalInformations>();
               for each (_loc14_ in _loc3_.fights)
               {
                  _loc4_.push(_loc14_);
               }
               _loc4_.sort(sortFights);
               KernelEventsManager.getInstance().processCallback(HookList.MapRunningFightList,_loc4_);
               return true;
            case param1 is MapRunningFightDetailsRequestAction:
               _loc5_ = param1 as MapRunningFightDetailsRequestAction;
               _loc6_ = new MapRunningFightDetailsRequestMessage();
               _loc6_.initMapRunningFightDetailsRequestMessage(_loc5_.fightId);
               ConnectionsHandler.getConnection().send(_loc6_);
               return true;
            case param1 is StopToListenRunningFightAction:
               _loc7_ = new StopToListenRunningFightRequestMessage();
               _loc7_.initStopToListenRunningFightRequestMessage();
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is MapRunningFightDetailsMessage:
               _loc8_ = param1 as MapRunningFightDetailsMessage;
               KernelEventsManager.getInstance().processCallback(HookList.MapRunningFightDetails,_loc8_.fightId,_loc8_.attackers,_loc8_.defenders);
               return true;
            case param1 is JoinAsSpectatorRequestAction:
               _loc9_ = param1 as JoinAsSpectatorRequestAction;
               _loc10_ = new GameFightJoinRequestMessage();
               _loc10_.initGameFightJoinRequestMessage(0,_loc9_.fightId);
               ConnectionsHandler.getConnection().send(_loc10_);
               return true;
            case param1 is JoinFightRequestAction:
               _loc11_ = param1 as JoinFightRequestAction;
               _loc10_ = new GameFightJoinRequestMessage();
               _loc10_.initGameFightJoinRequestMessage(_loc11_.teamLeaderId,_loc11_.fightId);
               ConnectionsHandler.getConnection().send(_loc10_);
               return true;
            case param1 is GameFightSpectatePlayerRequestAction:
               _loc12_ = param1 as GameFightSpectatePlayerRequestAction;
               _loc13_ = new GameFightSpectatePlayerRequestMessage();
               _loc13_.initGameFightSpectatePlayerRequestMessage(_loc12_.playerId);
               ConnectionsHandler.getConnection().send(_loc13_);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
