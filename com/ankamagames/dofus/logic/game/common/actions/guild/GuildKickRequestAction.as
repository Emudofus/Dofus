package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildKickRequestAction extends Object implements Action
   {
      
      public function GuildKickRequestAction() {
         super();
      }
      
      public static function create(pTargetId:uint) : GuildKickRequestAction {
         var action:GuildKickRequestAction = new GuildKickRequestAction();
         action.targetId = pTargetId;
         return action;
      }
      
      public var targetId:uint;
   }
}
