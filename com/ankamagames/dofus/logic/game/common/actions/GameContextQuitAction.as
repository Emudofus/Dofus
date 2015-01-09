package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GameContextQuitAction implements Action 
    {


        public static function create():GameContextQuitAction
        {
            return (new (GameContextQuitAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

