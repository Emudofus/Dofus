package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildListRequestAction implements Action 
    {


        public static function create():GuildListRequestAction
        {
            var action:GuildListRequestAction = new (GuildListRequestAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

