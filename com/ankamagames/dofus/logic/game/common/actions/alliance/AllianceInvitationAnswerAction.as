package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceInvitationAnswerAction extends Object implements Action
   {
      
      public function AllianceInvitationAnswerAction() {
         super();
      }
      
      public static function create(param1:Boolean) : AllianceInvitationAnswerAction {
         var _loc2_:AllianceInvitationAnswerAction = new AllianceInvitationAnswerAction();
         _loc2_.accept = param1;
         return _loc2_;
      }
      
      public var accept:Boolean;
   }
}
