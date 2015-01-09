package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PaddockBuyRequestAction implements Action 
    {


        public static function create():PaddockBuyRequestAction
        {
            return (new (PaddockBuyRequestAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount

