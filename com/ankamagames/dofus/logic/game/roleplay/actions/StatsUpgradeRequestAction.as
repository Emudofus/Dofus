package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StatsUpgradeRequestAction extends Object implements Action
   {
      
      public function StatsUpgradeRequestAction() {
         super();
      }
      
      public static function create(statId:uint, boostPoint:uint) : StatsUpgradeRequestAction {
         var a:StatsUpgradeRequestAction = new StatsUpgradeRequestAction();
         a.statId = statId;
         a.boostPoint = boostPoint;
         return a;
      }
      
      public var statId:uint;
      
      public var boostPoint:uint;
   }
}
