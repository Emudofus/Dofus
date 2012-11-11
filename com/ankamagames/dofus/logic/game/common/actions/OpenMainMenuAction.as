package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenMainMenuAction extends Object implements Action
    {

        public function OpenMainMenuAction()
        {
            return;
        }// end function

        public static function create() : OpenMainMenuAction
        {
            return new OpenMainMenuAction;
        }// end function

    }
}
