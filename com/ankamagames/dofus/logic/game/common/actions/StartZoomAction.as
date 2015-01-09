package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class StartZoomAction implements Action 
    {

        public var playerId:uint;
        public var value:Number;


        public static function create(playerId:uint, value:Number):StartZoomAction
        {
            var action:StartZoomAction = new (StartZoomAction)();
            action.playerId = playerId;
            action.value = value;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

