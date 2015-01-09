package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ToggleLockPartyAction implements Action 
    {


        public static function create():ToggleLockPartyAction
        {
            var a:ToggleLockPartyAction = new (ToggleLockPartyAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions

