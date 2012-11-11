package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChangeServerAction extends Object implements Action
    {

        public function ChangeServerAction()
        {
            return;
        }// end function

        public static function create() : ChangeServerAction
        {
            return new ChangeServerAction;
        }// end function

    }
}
