package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenCurrentFightAction extends Object implements Action
    {
        private var _name:String;
        public var value:String;

        public function OpenCurrentFightAction()
        {
            return;
        }// end function

        public static function create() : OpenCurrentFightAction
        {
            return new OpenCurrentFightAction;
        }// end function

    }
}
