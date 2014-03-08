package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildInvitationAnswerAction extends Object implements Action
   {
      
      public function GuildInvitationAnswerAction() {
         super();
      }
      
      public static function create(param1:Boolean) : GuildInvitationAnswerAction {
         var _loc2_:GuildInvitationAnswerAction = new GuildInvitationAnswerAction();
         _loc2_.accept = param1;
         return _loc2_;
      }
      
      public var accept:Boolean;
   }
}
