package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TimelineEntityOutAction extends Object implements Action
   {
      
      public function TimelineEntityOutAction() {
         super();
      }
      
      public static function create(param1:int) : TimelineEntityOutAction {
         var _loc2_:TimelineEntityOutAction = new TimelineEntityOutAction();
         _loc2_.targetId = param1;
         return _loc2_;
      }
      
      public var targetId:int;
   }
}
