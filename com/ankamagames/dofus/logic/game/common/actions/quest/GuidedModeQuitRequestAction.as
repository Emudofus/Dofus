package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuidedModeQuitRequestAction extends Object implements Action
    {

        public function GuidedModeQuitRequestAction()
        {
            return;
        }// end function

        public static function create() : GuidedModeQuitRequestAction
        {
            return new GuidedModeQuitRequestAction;
        }// end function

    }
}
