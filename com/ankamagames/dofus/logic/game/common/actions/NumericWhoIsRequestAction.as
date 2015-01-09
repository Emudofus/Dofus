package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class NumericWhoIsRequestAction implements Action 
    {

        public var playerId:uint;


        public static function create(playerId:uint):NumericWhoIsRequestAction
        {
            var a:NumericWhoIsRequestAction = new (NumericWhoIsRequestAction)();
            a.playerId = playerId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

