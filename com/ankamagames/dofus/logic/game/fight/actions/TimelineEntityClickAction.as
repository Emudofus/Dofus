package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TimelineEntityClickAction extends Object implements Action
   {
      
      public function TimelineEntityClickAction() {
         super();
      }
      
      public static function create(param1:int) : TimelineEntityClickAction {
         var _loc2_:TimelineEntityClickAction = new TimelineEntityClickAction();
         _loc2_.fighterId = param1;
         return _loc2_;
      }
      
      public var fighterId:int;
   }
}
