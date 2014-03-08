package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFarmTeleportRequestAction extends Object implements Action
   {
      
      public function GuildFarmTeleportRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : GuildFarmTeleportRequestAction {
         var _loc2_:GuildFarmTeleportRequestAction = new GuildFarmTeleportRequestAction();
         _loc2_.farmId = param1;
         return _loc2_;
      }
      
      public var farmId:uint;
   }
}
