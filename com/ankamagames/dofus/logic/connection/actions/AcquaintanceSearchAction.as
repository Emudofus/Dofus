package com.ankamagames.dofus.logic.connection.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AcquaintanceSearchAction extends Object implements Action
    {
        public var friendName:String;

        public function AcquaintanceSearchAction()
        {
            return;
        }// end function

        public static function create(param1:String) : AcquaintanceSearchAction
        {
            var _loc_2:* = new AcquaintanceSearchAction;
            _loc_2.friendName = param1;
            return _loc_2;
        }// end function

    }
}
