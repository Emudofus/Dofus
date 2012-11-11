package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildKickRequestAction extends Object implements Action
    {
        public var targetId:uint;

        public function GuildKickRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : GuildKickRequestAction
        {
            var _loc_2:* = new GuildKickRequestAction;
            _loc_2.targetId = param1;
            return _loc_2;
        }// end function

    }
}
