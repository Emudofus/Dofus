package com.ankamagames.dofus.logic.game.common.actions.alliance
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AllianceChangeGuildRightsAction implements Action 
    {

        public var guildId:uint;
        public var rights:uint;


        public static function create(guildId:uint, rights:uint):AllianceChangeGuildRightsAction
        {
            var action:AllianceChangeGuildRightsAction = new (AllianceChangeGuildRightsAction)();
            action.guildId = guildId;
            action.rights = rights;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.alliance

