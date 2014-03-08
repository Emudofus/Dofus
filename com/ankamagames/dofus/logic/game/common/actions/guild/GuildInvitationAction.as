package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildInvitationAction extends Object implements Action
   {
      
      public function GuildInvitationAction() {
         super();
      }
      
      public static function create(param1:uint) : GuildInvitationAction {
         var _loc2_:GuildInvitationAction = new GuildInvitationAction();
         _loc2_.targetId = param1;
         return _loc2_;
      }
      
      public var targetId:uint;
   }
}
