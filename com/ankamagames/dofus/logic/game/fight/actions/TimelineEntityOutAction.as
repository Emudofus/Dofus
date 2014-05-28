package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TimelineEntityOutAction extends Object implements Action
   {
      
      public function TimelineEntityOutAction() {
         super();
      }
      
      public static function create(target:int) : TimelineEntityOutAction {
         var a:TimelineEntityOutAction = new TimelineEntityOutAction();
         a.targetId = target;
         return a;
      }
      
      public var targetId:int;
   }
}
