package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFarmTeleportRequestAction extends Object implements Action
   {
      
      public function GuildFarmTeleportRequestAction() {
         super();
      }
      
      public static function create(pFarmId:uint) : GuildFarmTeleportRequestAction {
         var action:GuildFarmTeleportRequestAction = new GuildFarmTeleportRequestAction();
         action.farmId = pFarmId;
         return action;
      }
      
      public var farmId:uint;
   }
}
