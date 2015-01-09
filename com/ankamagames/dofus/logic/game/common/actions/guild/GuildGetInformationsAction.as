package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildGetInformationsAction implements Action 
    {

        public var infoType:uint;


        public static function create(pInfoType:uint):GuildGetInformationsAction
        {
            var action:GuildGetInformationsAction = new (GuildGetInformationsAction)();
            action.infoType = pInfoType;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

