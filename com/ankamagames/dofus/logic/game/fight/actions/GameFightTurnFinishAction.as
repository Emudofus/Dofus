package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GameFightTurnFinishAction extends Object implements Action
    {

        public function GameFightTurnFinishAction()
        {
            return;
        }// end function

        public static function create() : GameFightTurnFinishAction
        {
            return new GameFightTurnFinishAction;
        }// end function

    }
}
