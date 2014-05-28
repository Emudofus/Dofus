package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildListRequestAction extends Object implements Action
   {
      
      public function GuildListRequestAction() {
         super();
      }
      
      public static function create() : GuildListRequestAction {
         var action:GuildListRequestAction = new GuildListRequestAction();
         return action;
      }
   }
}
