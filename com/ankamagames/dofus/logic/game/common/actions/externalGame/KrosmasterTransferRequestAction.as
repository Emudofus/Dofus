package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class KrosmasterTransferRequestAction implements Action 
    {

        public var figureId:String;


        public static function create(figureId:String):KrosmasterTransferRequestAction
        {
            var action:KrosmasterTransferRequestAction = new (KrosmasterTransferRequestAction)();
            action.figureId = figureId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.externalGame

