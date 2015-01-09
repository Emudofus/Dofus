package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GameFightReadyAction implements Action 
    {

        public var isReady:Boolean;


        public static function create(isReady:Boolean):GameFightReadyAction
        {
            var a:GameFightReadyAction = new (GameFightReadyAction)();
            a.isReady = isReady;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions

