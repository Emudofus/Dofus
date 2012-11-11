package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildModificationValidAction extends Object implements Action
    {
        public var guildName:String;
        public var upEmblemId:uint;
        public var upColorEmblem:uint;
        public var backEmblemId:uint;
        public var backColorEmblem:uint;

        public function GuildModificationValidAction()
        {
            return;
        }// end function

        public static function create(param1:String, param2:uint, param3:uint, param4:uint, param5:uint) : GuildModificationValidAction
        {
            var _loc_6:* = new GuildModificationValidAction;
            new GuildModificationValidAction.guildName = param1;
            _loc_6.upEmblemId = param2;
            _loc_6.upColorEmblem = param3;
            _loc_6.backEmblemId = param4;
            _loc_6.backColorEmblem = param5;
            return _loc_6;
        }// end function

    }
}
