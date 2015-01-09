package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GameFightTurnFinishAction implements Action 
    {


        public static function create():GameFightTurnFinishAction
        {
            return (new (GameFightTurnFinishAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions

