package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildInvitationAction extends Object implements Action
   {
      
      public function GuildInvitationAction() {
         super();
      }
      
      public static function create(pTargetId:uint) : GuildInvitationAction {
         var action:GuildInvitationAction = new GuildInvitationAction();
         action.targetId = pTargetId;
         return action;
      }
      
      public var targetId:uint;
   }
}
