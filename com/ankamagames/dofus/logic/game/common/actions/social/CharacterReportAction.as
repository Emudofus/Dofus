package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CharacterReportAction extends Object implements Action
    {
        public var reportedId:uint;
        public var reason:uint;

        public function CharacterReportAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : CharacterReportAction
        {
            var _loc_3:* = new CharacterReportAction;
            _loc_3.reportedId = param1;
            _loc_3.reason = param2;
            return _loc_3;
        }// end function

    }
}
