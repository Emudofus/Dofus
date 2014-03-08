package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TimelineEntityOverAction extends Object implements Action
   {
      
      public function TimelineEntityOverAction() {
         super();
      }
      
      public static function create(target:int, showRange:Boolean) : TimelineEntityOverAction {
         var a:TimelineEntityOverAction = new TimelineEntityOverAction();
         a.targetId = target;
         a.showRange = showRange;
         return a;
      }
      
      public var targetId:int;
      
      public var showRange:Boolean;
   }
}
