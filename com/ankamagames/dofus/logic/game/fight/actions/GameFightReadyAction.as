package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GameFightReadyAction extends Object implements Action
    {
        public var isReady:Boolean;

        public function GameFightReadyAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : GameFightReadyAction
        {
            var _loc_2:* = new GameFightReadyAction;
            _loc_2.isReady = param1;
            return _loc_2;
        }// end function

    }
}
