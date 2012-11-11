package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PivotCharacterAction extends Object implements Action
    {

        public function PivotCharacterAction()
        {
            return;
        }// end function

        public static function create() : PivotCharacterAction
        {
            var _loc_1:* = new PivotCharacterAction;
            return _loc_1;
        }// end function

    }
}
