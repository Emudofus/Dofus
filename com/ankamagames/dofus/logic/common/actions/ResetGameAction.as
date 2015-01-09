package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ResetGameAction implements Action 
    {

        public var messageToShow:String;


        public static function create(pMsg:String=""):ResetGameAction
        {
            var a:ResetGameAction = new (ResetGameAction)();
            a.messageToShow = pMsg;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.common.actions

