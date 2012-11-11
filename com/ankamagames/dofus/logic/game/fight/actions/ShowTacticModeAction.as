package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ShowTacticModeAction extends Object implements Action
    {

        public function ShowTacticModeAction()
        {
            return;
        }// end function

        public static function create() : ShowTacticModeAction
        {
            var _loc_1:* = new ShowTacticModeAction;
            return _loc_1;
        }// end function

    }
}
