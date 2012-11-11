package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GameContextQuitAction extends Object implements Action
    {

        public function GameContextQuitAction()
        {
            return;
        }// end function

        public static function create() : GameContextQuitAction
        {
            return new GameContextQuitAction;
        }// end function

    }
}
