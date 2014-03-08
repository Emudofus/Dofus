package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildModificationNameValidAction extends Object implements Action
   {
      
      public function GuildModificationNameValidAction() {
         super();
      }
      
      public static function create(param1:String) : GuildModificationNameValidAction {
         var _loc2_:GuildModificationNameValidAction = new GuildModificationNameValidAction();
         _loc2_.guildName = param1;
         return _loc2_;
      }
      
      public var guildName:String;
   }
}
