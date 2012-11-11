package com.ankamagames.dofus.logic.game.fight.messages
{
    import com.ankamagames.dofus.network.messages.game.actions.fight.*;
    import com.ankamagames.jerakine.messages.*;

    public class GameActionFightLeaveMessage extends GameActionFightDeathMessage implements Message
    {

        public function GameActionFightLeaveMessage()
        {
            return;
        }// end function

        public function initGameActionFightLeaveMessage(param1:uint = 0, param2:int = 0, param3:int = 0) : GameActionFightLeaveMessage
        {
            super.initGameActionFightDeathMessage(param1, param2, param3);
            return this;
        }// end function

    }
}
