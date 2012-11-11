package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class EmptyStackAction extends Object implements Action
    {

        public function EmptyStackAction()
        {
            return;
        }// end function

        public static function create() : EmptyStackAction
        {
            return new EmptyStackAction;
        }// end function

    }
}
