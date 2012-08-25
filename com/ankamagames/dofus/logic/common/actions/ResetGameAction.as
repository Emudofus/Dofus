package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ResetGameAction extends Object implements Action
    {

        public function ResetGameAction()
        {
            return;
        }// end function

        public static function create() : ResetGameAction
        {
            return new ResetGameAction;
        }// end function

    }
}
