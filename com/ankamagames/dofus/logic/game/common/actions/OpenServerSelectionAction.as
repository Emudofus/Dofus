package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenServerSelectionAction extends Object implements Action
    {
        private var _name:String;
        public var value:String;

        public function OpenServerSelectionAction()
        {
            return;
        }// end function

        public static function create() : OpenServerSelectionAction
        {
            return new OpenServerSelectionAction;
        }// end function

    }
}
