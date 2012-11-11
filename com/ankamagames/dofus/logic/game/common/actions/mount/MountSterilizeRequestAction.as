package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MountSterilizeRequestAction extends Object implements Action
    {

        public function MountSterilizeRequestAction()
        {
            return;
        }// end function

        public static function create() : MountSterilizeRequestAction
        {
            return new MountSterilizeRequestAction;
        }// end function

    }
}
