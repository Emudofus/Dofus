package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MountReleaseRequestAction extends Object implements Action
    {

        public function MountReleaseRequestAction()
        {
            return;
        }// end function

        public static function create() : MountReleaseRequestAction
        {
            return new MountReleaseRequestAction;
        }// end function

    }
}
