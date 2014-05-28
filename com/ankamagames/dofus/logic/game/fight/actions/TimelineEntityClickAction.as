package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TimelineEntityClickAction extends Object implements Action
   {
      
      public function TimelineEntityClickAction() {
         super();
      }
      
      public static function create(id:int) : TimelineEntityClickAction {
         var a:TimelineEntityClickAction = new TimelineEntityClickAction();
         a.fighterId = id;
         return a;
      }
      
      public var fighterId:int;
   }
}
