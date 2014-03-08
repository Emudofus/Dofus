package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFactsRequestAction extends Object implements Action
   {
      
      public function GuildFactsRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : GuildFactsRequestAction {
         var _loc2_:GuildFactsRequestAction = new GuildFactsRequestAction();
         _loc2_.guildId = param1;
         return _loc2_;
      }
      
      public var guildId:uint;
   }
}
