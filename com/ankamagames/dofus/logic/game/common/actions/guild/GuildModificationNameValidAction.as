package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildModificationNameValidAction implements Action 
    {

        public var guildName:String;


        public static function create(pGuildName:String):GuildModificationNameValidAction
        {
            var action:GuildModificationNameValidAction = new (GuildModificationNameValidAction)();
            action.guildName = pGuildName;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

