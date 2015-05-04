package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StatsUpgradeRequestAction extends Object implements Action
   {
      
      public function StatsUpgradeRequestAction()
      {
         super();
      }
      
      public static function create(param1:Boolean, param2:uint, param3:uint) : StatsUpgradeRequestAction
      {
         var _loc4_:StatsUpgradeRequestAction = new StatsUpgradeRequestAction();
         _loc4_.useAdditionnal = param1;
         _loc4_.statId = param2;
         _loc4_.boostPoint = param3;
         return _loc4_;
      }
      
      public var useAdditionnal:Boolean;
      
      public var statId:uint;
      
      public var boostPoint:uint;
   }
}
