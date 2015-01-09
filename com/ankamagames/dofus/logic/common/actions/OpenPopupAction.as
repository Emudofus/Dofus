package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenPopupAction implements Action 
    {

        public var messageToShow:String;


        public static function create(pMsg:String=""):OpenPopupAction
        {
            var s:OpenPopupAction = new (OpenPopupAction)();
            s.messageToShow = pMsg;
            return (s);
        }


    }
}//package com.ankamagames.dofus.logic.common.actions

