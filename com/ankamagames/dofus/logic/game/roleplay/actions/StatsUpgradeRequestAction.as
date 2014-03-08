package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StatsUpgradeRequestAction extends Object implements Action
   {
      
      public function StatsUpgradeRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : StatsUpgradeRequestAction {
         var _loc3_:StatsUpgradeRequestAction = new StatsUpgradeRequestAction();
         _loc3_.statId = param1;
         _loc3_.boostPoint = param2;
         return _loc3_;
      }
      
      public var statId:uint;
      
      public var boostPoint:uint;
   }
}
