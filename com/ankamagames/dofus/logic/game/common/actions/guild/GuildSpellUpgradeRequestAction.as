package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildSpellUpgradeRequestAction implements Action 
    {

        public var spellId:uint;


        public static function create(pSpellId:uint):GuildSpellUpgradeRequestAction
        {
            var action:GuildSpellUpgradeRequestAction = new (GuildSpellUpgradeRequestAction)();
            action.spellId = pSpellId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

