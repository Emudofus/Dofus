package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MountInformationInPaddockRequestAction extends Object implements Action
    {
        public var mountId:uint;

        public function MountInformationInPaddockRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : MountInformationInPaddockRequestAction
        {
            var _loc_2:* = new MountInformationInPaddockRequestAction;
            _loc_2.mountId = param1;
            return _loc_2;
        }// end function

    }
}
