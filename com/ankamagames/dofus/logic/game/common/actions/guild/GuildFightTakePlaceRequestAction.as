package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildFightTakePlaceRequestAction implements Action 
    {

        public var taxCollectorId:uint;
        public var replacedCharacterId:uint;


        public static function create(pTaxCollectorId:uint, replacedCharacterId:uint):GuildFightTakePlaceRequestAction
        {
            var action:GuildFightTakePlaceRequestAction = new (GuildFightTakePlaceRequestAction)();
            action.taxCollectorId = pTaxCollectorId;
            action.replacedCharacterId = replacedCharacterId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

