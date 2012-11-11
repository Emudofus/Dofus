package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildModificationEmblemValidAction extends Object implements Action
    {
        public var upEmblemId:uint;
        public var upColorEmblem:uint;
        public var backEmblemId:uint;
        public var backColorEmblem:uint;

        public function GuildModificationEmblemValidAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint, param4:uint) : GuildModificationEmblemValidAction
        {
            var _loc_5:* = new GuildModificationEmblemValidAction;
            new GuildModificationEmblemValidAction.upEmblemId = param1;
            _loc_5.upColorEmblem = param2;
            _loc_5.backEmblemId = param3;
            _loc_5.backColorEmblem = param4;
            return _loc_5;
        }// end function

    }
}
