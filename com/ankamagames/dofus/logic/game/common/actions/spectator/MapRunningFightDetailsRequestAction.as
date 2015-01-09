package com.ankamagames.dofus.logic.game.common.actions.spectator
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class MapRunningFightDetailsRequestAction implements Action 
    {

        public var fightId:uint;


        public static function create(fightId:uint):MapRunningFightDetailsRequestAction
        {
            var a:MapRunningFightDetailsRequestAction = new (MapRunningFightDetailsRequestAction)();
            a.fightId = fightId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.spectator

