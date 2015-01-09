package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class SpellSetPositionAction implements Action 
    {

        public var spellID:uint;
        public var position:uint;


        public static function create(spellID:uint, position:uint):SpellSetPositionAction
        {
            var a:SpellSetPositionAction = new (SpellSetPositionAction)();
            a.spellID = spellID;
            a.position = position;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

