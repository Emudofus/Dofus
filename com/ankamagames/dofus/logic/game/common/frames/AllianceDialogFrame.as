package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceCreationValidAction;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceCreationValidMessage;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationValidAction;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationValidMessage;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationNameAndTagValidAction;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationNameAndTagValidMessage;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationEmblemValidAction;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationEmblemValidMessage;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAnswerAction;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   
   public class AllianceDialogFrame extends Object implements Frame
   {
      
      public function AllianceDialogFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceDialogFrame));
      
      private var allianceEmblem:GuildEmblem;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:AllianceCreationValidAction = null;
         var _loc3_:AllianceCreationValidMessage = null;
         var _loc4_:AllianceModificationValidAction = null;
         var _loc5_:AllianceModificationValidMessage = null;
         var _loc6_:AllianceModificationNameAndTagValidAction = null;
         var _loc7_:AllianceModificationNameAndTagValidMessage = null;
         var _loc8_:AllianceModificationEmblemValidAction = null;
         var _loc9_:AllianceModificationEmblemValidMessage = null;
         var _loc10_:AllianceInvitationAnswerAction = null;
         var _loc11_:AllianceInvitationAnswerMessage = null;
         var _loc12_:LeaveDialogMessage = null;
         switch(true)
         {
            case param1 is AllianceCreationValidAction:
               _loc2_ = param1 as AllianceCreationValidAction;
               this.allianceEmblem = new GuildEmblem();
               this.allianceEmblem.symbolShape = _loc2_.upEmblemId;
               this.allianceEmblem.symbolColor = _loc2_.upColorEmblem;
               this.allianceEmblem.backgroundShape = _loc2_.backEmblemId;
               this.allianceEmblem.backgroundColor = _loc2_.backColorEmblem;
               _loc3_ = new AllianceCreationValidMessage();
               _loc3_.initAllianceCreationValidMessage(_loc2_.allianceName,_loc2_.allianceTag,this.allianceEmblem);
               ConnectionsHandler.getConnection().send(_loc3_);
               return true;
            case param1 is AllianceModificationValidAction:
               _loc4_ = param1 as AllianceModificationValidAction;
               this.allianceEmblem = new GuildEmblem();
               this.allianceEmblem.symbolShape = _loc4_.upEmblemId;
               this.allianceEmblem.symbolColor = _loc4_.upColorEmblem;
               this.allianceEmblem.backgroundShape = _loc4_.backEmblemId;
               this.allianceEmblem.backgroundColor = _loc4_.backColorEmblem;
               _loc5_ = new AllianceModificationValidMessage();
               _loc5_.initAllianceModificationValidMessage(_loc4_.name,_loc4_.tag,this.allianceEmblem);
               ConnectionsHandler.getConnection().send(_loc5_);
               return true;
            case param1 is AllianceModificationNameAndTagValidAction:
               _loc6_ = param1 as AllianceModificationNameAndTagValidAction;
               _loc7_ = new AllianceModificationNameAndTagValidMessage();
               _loc7_.initAllianceModificationNameAndTagValidMessage(_loc6_.name,_loc6_.tag);
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is AllianceModificationEmblemValidAction:
               _loc8_ = param1 as AllianceModificationEmblemValidAction;
               this.allianceEmblem = new GuildEmblem();
               this.allianceEmblem.symbolShape = _loc8_.upEmblemId;
               this.allianceEmblem.symbolColor = _loc8_.upColorEmblem;
               this.allianceEmblem.backgroundShape = _loc8_.backEmblemId;
               this.allianceEmblem.backgroundColor = _loc8_.backColorEmblem;
               _loc9_ = new AllianceModificationEmblemValidMessage();
               _loc9_.initAllianceModificationEmblemValidMessage(this.allianceEmblem);
               ConnectionsHandler.getConnection().send(_loc9_);
               return true;
            case param1 is AllianceInvitationAnswerAction:
               _loc10_ = param1 as AllianceInvitationAnswerAction;
               _loc11_ = new AllianceInvitationAnswerMessage();
               _loc11_.initAllianceInvitationAnswerMessage(_loc10_.accept);
               ConnectionsHandler.getConnection().send(_loc11_);
               this.leaveDialog();
               return true;
            case param1 is LeaveDialogMessage:
               _loc12_ = param1 as LeaveDialogMessage;
               if(_loc12_.dialogType == DialogTypeEnum.DIALOG_ALLIANCE_CREATE || _loc12_.dialogType == DialogTypeEnum.DIALOG_ALLIANCE_INVITATION || _loc12_.dialogType == DialogTypeEnum.DIALOG_ALLIANCE_RENAME)
               {
                  this.leaveDialog();
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
      
      private function leaveDialog() : void {
         Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
         Kernel.getWorker().removeFrame(this);
      }
   }
}
