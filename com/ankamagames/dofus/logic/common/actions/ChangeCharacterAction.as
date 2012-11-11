package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChangeCharacterAction extends Object implements Action
    {
        public var serverId:uint;

        public function ChangeCharacterAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : ChangeCharacterAction
        {
            var _loc_2:* = new ChangeCharacterAction;
            _loc_2.serverId = param1;
            return _loc_2;
        }// end function

    }
}
