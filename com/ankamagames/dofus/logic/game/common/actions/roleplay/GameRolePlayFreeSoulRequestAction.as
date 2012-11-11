package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GameRolePlayFreeSoulRequestAction extends Object implements Action
    {

        public function GameRolePlayFreeSoulRequestAction()
        {
            return;
        }// end function

        public static function create() : GameRolePlayFreeSoulRequestAction
        {
            return new GameRolePlayFreeSoulRequestAction;
        }// end function

    }
}
