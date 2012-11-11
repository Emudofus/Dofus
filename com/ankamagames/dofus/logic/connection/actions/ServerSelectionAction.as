package com.ankamagames.dofus.logic.connection.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ServerSelectionAction extends Object implements Action
    {
        public var serverId:int;

        public function ServerSelectionAction()
        {
            return;
        }// end function

        public static function create(param1:int) : ServerSelectionAction
        {
            var _loc_2:* = new ServerSelectionAction;
            _loc_2.serverId = param1;
            return _loc_2;
        }// end function

    }
}
