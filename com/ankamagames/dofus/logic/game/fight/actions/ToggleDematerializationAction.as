package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ToggleDematerializationAction implements Action 
    {


        public static function create():ToggleDematerializationAction
        {
            var a:ToggleDematerializationAction = new (ToggleDematerializationAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions

