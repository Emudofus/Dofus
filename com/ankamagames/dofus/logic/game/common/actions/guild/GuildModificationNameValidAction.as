package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildModificationNameValidAction extends Object implements Action
   {
      
      public function GuildModificationNameValidAction() {
         super();
      }
      
      public static function create(pGuildName:String) : GuildModificationNameValidAction {
         var action:GuildModificationNameValidAction = new GuildModificationNameValidAction();
         action.guildName = pGuildName;
         return action;
      }
      
      public var guildName:String;
   }
}
