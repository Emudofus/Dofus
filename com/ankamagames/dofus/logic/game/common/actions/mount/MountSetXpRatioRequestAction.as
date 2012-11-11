package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MountSetXpRatioRequestAction extends Object implements Action
    {
        public var xpRatio:uint;

        public function MountSetXpRatioRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : MountSetXpRatioRequestAction
        {
            var _loc_2:* = new MountSetXpRatioRequestAction;
            _loc_2.xpRatio = param1;
            return _loc_2;
        }// end function

    }
}
