package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class JobAllowMultiCraftRequestSetAction extends Object implements Action
    {
        public var isPublic:Boolean;

        public function JobAllowMultiCraftRequestSetAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : JobAllowMultiCraftRequestSetAction
        {
            var _loc_2:* = new JobAllowMultiCraftRequestSetAction;
            _loc_2.isPublic = param1;
            return _loc_2;
        }// end function

    }
}
