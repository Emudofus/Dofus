package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TimelineEntityOutAction extends Object implements Action
    {
        public var targetId:int;

        public function TimelineEntityOutAction()
        {
            return;
        }// end function

        public static function create(param1:int) : TimelineEntityOutAction
        {
            var _loc_2:* = new TimelineEntityOutAction;
            _loc_2.targetId = param1;
            return _loc_2;
        }// end function

    }
}
