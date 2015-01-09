package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShowAllNamesAction implements Action 
    {


        public static function create():ShowAllNamesAction
        {
            var a:ShowAllNamesAction = new (ShowAllNamesAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions

