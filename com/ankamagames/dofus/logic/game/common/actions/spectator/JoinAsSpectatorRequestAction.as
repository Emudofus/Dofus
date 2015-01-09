package com.ankamagames.dofus.logic.game.common.actions.spectator
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class JoinAsSpectatorRequestAction implements Action 
    {

        public var fightId:uint;


        public static function create(fightId:uint):JoinAsSpectatorRequestAction
        {
            var a:JoinAsSpectatorRequestAction = new (JoinAsSpectatorRequestAction)();
            a.fightId = fightId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.spectator

