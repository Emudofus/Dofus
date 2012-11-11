package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class BasicWhoIsRequestAction extends Object implements Action
    {
        public var playerName:String;

        public function BasicWhoIsRequestAction()
        {
            return;
        }// end function

        public static function create(param1:String) : BasicWhoIsRequestAction
        {
            var _loc_2:* = new BasicWhoIsRequestAction;
            _loc_2.playerName = param1;
            return _loc_2;
        }// end function

    }
}
