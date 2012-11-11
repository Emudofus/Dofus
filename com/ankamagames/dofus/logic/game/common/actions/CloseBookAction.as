package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CloseBookAction extends Object implements Action
    {
        private var _name:String;
        public var value:String;

        public function CloseBookAction()
        {
            return;
        }// end function

        public static function create() : CloseBookAction
        {
            return new CloseBookAction;
        }// end function

    }
}
