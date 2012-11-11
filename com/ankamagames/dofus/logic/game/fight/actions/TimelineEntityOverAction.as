package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TimelineEntityOverAction extends Object implements Action
    {
        public var targetId:int;
        public var showRange:Boolean;

        public function TimelineEntityOverAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:Boolean) : TimelineEntityOverAction
        {
            var _loc_3:* = new TimelineEntityOverAction;
            _loc_3.targetId = param1;
            _loc_3.showRange = param2;
            return _loc_3;
        }// end function

    }
}
