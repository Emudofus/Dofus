package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class StatsUpgradeRequestAction extends Object implements Action
    {
        public var statId:uint;
        public var boostPoint:uint;

        public function StatsUpgradeRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : StatsUpgradeRequestAction
        {
            var _loc_3:* = new StatsUpgradeRequestAction;
            _loc_3.statId = param1;
            _loc_3.boostPoint = param2;
            return _loc_3;
        }// end function

    }
}
