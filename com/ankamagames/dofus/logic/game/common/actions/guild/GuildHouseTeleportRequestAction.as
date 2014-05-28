package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildHouseTeleportRequestAction extends Object implements Action
   {
      
      public function GuildHouseTeleportRequestAction() {
         super();
      }
      
      public static function create(pHouseId:uint) : GuildHouseTeleportRequestAction {
         var action:GuildHouseTeleportRequestAction = new GuildHouseTeleportRequestAction();
         action.houseId = pHouseId;
         return action;
      }
      
      public var houseId:uint;
   }
}
