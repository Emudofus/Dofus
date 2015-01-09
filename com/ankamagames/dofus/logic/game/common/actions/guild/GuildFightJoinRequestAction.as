package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildFightJoinRequestAction implements Action 
    {

        public var taxCollectorId:uint;


        public static function create(pTaxCollectorId:uint):GuildFightJoinRequestAction
        {
            var action:GuildFightJoinRequestAction = new (GuildFightJoinRequestAction)();
            action.taxCollectorId = pTaxCollectorId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

