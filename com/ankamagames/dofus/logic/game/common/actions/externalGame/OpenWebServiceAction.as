package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenWebServiceAction implements Action 
    {

        public var uiName:String;
        public var uiParams:Object;


        public static function create(uiName:String="", uiParams:Object=null):OpenWebServiceAction
        {
            var action:OpenWebServiceAction = new (OpenWebServiceAction)();
            action.uiName = uiName;
            action.uiParams = uiParams;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.externalGame

