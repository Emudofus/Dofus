package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceInvitationAnswerAction extends Object implements Action
   {
      
      public function AllianceInvitationAnswerAction() {
         super();
      }
      
      public static function create(pAccept:Boolean) : AllianceInvitationAnswerAction {
         var action:AllianceInvitationAnswerAction = new AllianceInvitationAnswerAction();
         action.accept = pAccept;
         return action;
      }
      
      public var accept:Boolean;
   }
}
