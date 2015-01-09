package com.ankamagames.dofus.logic.game.common.actions.spectator
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GameFightSpectatePlayerRequestAction implements Action 
    {

        public var playerId:uint;


        public static function create(playerId:uint):GameFightSpectatePlayerRequestAction
        {
            var a:GameFightSpectatePlayerRequestAction = new (GameFightSpectatePlayerRequestAction)();
            a.playerId = playerId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.spectator

