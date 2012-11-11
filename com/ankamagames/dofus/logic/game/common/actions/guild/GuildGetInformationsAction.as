package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildGetInformationsAction extends Object implements Action
    {
        public var infoType:uint;

        public function GuildGetInformationsAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : GuildGetInformationsAction
        {
            var _loc_2:* = new GuildGetInformationsAction;
            _loc_2.infoType = param1;
            return _loc_2;
        }// end function

    }
}
