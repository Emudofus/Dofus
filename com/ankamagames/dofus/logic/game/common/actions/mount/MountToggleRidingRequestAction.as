package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MountToggleRidingRequestAction extends Object implements Action
    {

        public function MountToggleRidingRequestAction()
        {
            return;
        }// end function

        public static function create() : MountToggleRidingRequestAction
        {
            return new MountToggleRidingRequestAction;
        }// end function

    }
}
