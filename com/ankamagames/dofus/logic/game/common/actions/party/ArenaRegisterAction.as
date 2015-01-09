package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ArenaRegisterAction implements Action 
    {

        public var fightTypeId:uint;


        public static function create(fightTypeId:uint):ArenaRegisterAction
        {
            var a:ArenaRegisterAction = new (ArenaRegisterAction)();
            a.fightTypeId = fightTypeId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

