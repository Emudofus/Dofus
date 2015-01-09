package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenMainMenuAction implements Action 
    {


        public static function create():OpenMainMenuAction
        {
            return (new (OpenMainMenuAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

