package com.ankamagames.dofus.logic.game.common.actions.spectator
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MapRunningFightDetailsRequestAction extends Object implements Action
    {
        public var fightId:uint;

        public function MapRunningFightDetailsRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : MapRunningFightDetailsRequestAction
        {
            var _loc_2:* = new MapRunningFightDetailsRequestAction;
            _loc_2.fightId = param1;
            return _loc_2;
        }// end function

    }
}
