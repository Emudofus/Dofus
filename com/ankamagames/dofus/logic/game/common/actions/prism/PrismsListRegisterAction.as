package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PrismsListRegisterAction implements Action 
    {

        public var uiName:String;
        public var listen:uint;


        public static function create(uiName:String, listen:uint):PrismsListRegisterAction
        {
            var action:PrismsListRegisterAction = new (PrismsListRegisterAction)();
            action.uiName = uiName;
            action.listen = listen;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.prism

