package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildCharacsUpgradeRequestAction implements Action 
    {

        public var charaTypeTarget:uint;


        public static function create(pCharaTypeTarget:uint):GuildCharacsUpgradeRequestAction
        {
            var action:GuildCharacsUpgradeRequestAction = new (GuildCharacsUpgradeRequestAction)();
            action.charaTypeTarget = pCharaTypeTarget;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

