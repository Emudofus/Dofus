package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuidedModeReturnRequestAction extends Object implements Action
    {

        public function GuidedModeReturnRequestAction()
        {
            return;
        }// end function

        public static function create() : GuidedModeReturnRequestAction
        {
            return new GuidedModeReturnRequestAction;
        }// end function

    }
}
