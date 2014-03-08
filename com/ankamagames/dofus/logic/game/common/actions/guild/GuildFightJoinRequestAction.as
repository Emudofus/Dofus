package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFightJoinRequestAction extends Object implements Action
   {
      
      public function GuildFightJoinRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : GuildFightJoinRequestAction {
         var _loc2_:GuildFightJoinRequestAction = new GuildFightJoinRequestAction();
         _loc2_.taxCollectorId = param1;
         return _loc2_;
      }
      
      public var taxCollectorId:uint;
   }
}
