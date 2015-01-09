package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ChangeServerAction implements Action 
    {


        public static function create():ChangeServerAction
        {
            return (new (ChangeServerAction)());
        }


    }
}//package com.ankamagames.dofus.logic.common.actions

