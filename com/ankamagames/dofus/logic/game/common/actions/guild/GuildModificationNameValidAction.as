package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildModificationNameValidAction extends Object implements Action
    {
        public var guildName:String;

        public function GuildModificationNameValidAction()
        {
            return;
        }// end function

        public static function create(param1:String) : GuildModificationNameValidAction
        {
            var _loc_2:* = new GuildModificationNameValidAction;
            _loc_2.guildName = param1;
            return _loc_2;
        }// end function

    }
}
