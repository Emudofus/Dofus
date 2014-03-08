package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TimelineEntityOverAction extends Object implements Action
   {
      
      public function TimelineEntityOverAction() {
         super();
      }
      
      public static function create(param1:int, param2:Boolean) : TimelineEntityOverAction {
         var _loc3_:TimelineEntityOverAction = new TimelineEntityOverAction();
         _loc3_.targetId = param1;
         _loc3_.showRange = param2;
         return _loc3_;
      }
      
      public var targetId:int;
      
      public var showRange:Boolean;
   }
}
