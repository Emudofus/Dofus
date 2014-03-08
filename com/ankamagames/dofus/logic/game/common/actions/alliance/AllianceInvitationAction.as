package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceInvitationAction extends Object implements Action
   {
      
      public function AllianceInvitationAction() {
         super();
      }
      
      public static function create(pTargetId:uint) : AllianceInvitationAction {
         var action:AllianceInvitationAction = new AllianceInvitationAction();
         action.targetId = pTargetId;
         return action;
      }
      
      public var targetId:uint;
   }
}
