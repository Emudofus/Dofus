package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFightJoinRequestAction extends Object implements Action
   {
      
      public function GuildFightJoinRequestAction() {
         super();
      }
      
      public static function create(pTaxCollectorId:uint) : GuildFightJoinRequestAction {
         var action:GuildFightJoinRequestAction = new GuildFightJoinRequestAction();
         action.taxCollectorId = pTaxCollectorId;
         return action;
      }
      
      public var taxCollectorId:uint;
   }
}
