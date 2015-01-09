package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ValidateSpellForgetAction implements Action 
    {

        public var spellId:uint;


        public static function create(spellId:uint):ValidateSpellForgetAction
        {
            var a:ValidateSpellForgetAction = new (ValidateSpellForgetAction)();
            a.spellId = spellId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

