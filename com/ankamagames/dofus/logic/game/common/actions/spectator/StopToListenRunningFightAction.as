package com.ankamagames.dofus.logic.game.common.actions.spectator
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class StopToListenRunningFightAction implements Action 
    {


        public static function create():StopToListenRunningFightAction
        {
            return (new (StopToListenRunningFightAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.spectator

