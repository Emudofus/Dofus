package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenTeamSearchAction implements Action 
    {


        public static function create():OpenTeamSearchAction
        {
            var a:OpenTeamSearchAction = new (OpenTeamSearchAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

