package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildChangeMemberParametersAction extends Object implements Action
    {
        public var memberId:uint;
        public var rank:uint;
        public var experienceGivenPercent:uint;
        public var rights:Array;

        public function GuildChangeMemberParametersAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint, param4:Array) : GuildChangeMemberParametersAction
        {
            var _loc_5:* = new GuildChangeMemberParametersAction;
            new GuildChangeMemberParametersAction.memberId = param1;
            _loc_5.rank = param2;
            _loc_5.experienceGivenPercent = param3;
            _loc_5.rights = param4;
            return _loc_5;
        }// end function

    }
}
