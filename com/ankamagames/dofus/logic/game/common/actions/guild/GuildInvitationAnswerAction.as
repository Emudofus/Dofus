package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildInvitationAnswerAction extends Object implements Action
   {
      
      public function GuildInvitationAnswerAction() {
         super();
      }
      
      public static function create(pAccept:Boolean) : GuildInvitationAnswerAction {
         var action:GuildInvitationAnswerAction = new GuildInvitationAnswerAction();
         action.accept = pAccept;
         return action;
      }
      
      public var accept:Boolean;
   }
}
