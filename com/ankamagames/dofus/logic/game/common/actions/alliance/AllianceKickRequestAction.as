package com.ankamagames.dofus.logic.game.common.actions.alliance
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AllianceKickRequestAction implements Action 
    {

        public var guildId:uint;


        public static function create(pGuildId:uint):AllianceKickRequestAction
        {
            var action:AllianceKickRequestAction = new (AllianceKickRequestAction)();
            action.guildId = pGuildId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.alliance

