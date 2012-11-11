package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TimelineEntityClickAction extends Object implements Action
    {
        public var fighterId:int;

        public function TimelineEntityClickAction()
        {
            return;
        }// end function

        public static function create(param1:int) : TimelineEntityClickAction
        {
            var _loc_2:* = new TimelineEntityClickAction;
            _loc_2.fighterId = param1;
            return _loc_2;
        }// end function

    }
}
