package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class QuitGameAction implements Action 
    {


        public static function create():QuitGameAction
        {
            return (new (QuitGameAction)());
        }


    }
}//package com.ankamagames.dofus.logic.common.actions

