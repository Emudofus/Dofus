package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class LeaveExchangeMountAction implements Action 
    {


        public static function create():LeaveExchangeMountAction
        {
            return (new (LeaveExchangeMountAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount

