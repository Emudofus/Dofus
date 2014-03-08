package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseGuildRightsViewAction extends Object implements Action
   {
      
      public function HouseGuildRightsViewAction() {
         super();
      }
      
      public static function create() : HouseGuildRightsViewAction {
         var _loc1_:HouseGuildRightsViewAction = new HouseGuildRightsViewAction();
         return _loc1_;
      }
   }
}
