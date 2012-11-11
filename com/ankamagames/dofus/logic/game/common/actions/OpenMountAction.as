package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenMountAction extends Object implements Action
    {

        public function OpenMountAction()
        {
            return;
        }// end function

        public static function create() : OpenMountAction
        {
            return new OpenMountAction;
        }// end function

    }
}
