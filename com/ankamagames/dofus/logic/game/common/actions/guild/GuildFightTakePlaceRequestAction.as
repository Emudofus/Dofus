package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildFightTakePlaceRequestAction extends Object implements Action
    {
        public var taxCollectorId:uint;
        public var replacedCharacterId:uint;

        public function GuildFightTakePlaceRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : GuildFightTakePlaceRequestAction
        {
            var _loc_3:* = new GuildFightTakePlaceRequestAction;
            _loc_3.taxCollectorId = param1;
            _loc_3.replacedCharacterId = param2;
            return _loc_3;
        }// end function

    }
}
