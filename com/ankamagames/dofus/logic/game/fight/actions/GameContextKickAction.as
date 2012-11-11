package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GameContextKickAction extends Object implements Action
    {
        public var targetId:uint;

        public function GameContextKickAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : GameContextKickAction
        {
            var _loc_2:* = new GameContextKickAction;
            _loc_2.targetId = param1;
            return _loc_2;
        }// end function

    }
}
