package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenStatsAction implements Action 
    {


        public static function create():OpenStatsAction
        {
            var a:OpenStatsAction = new (OpenStatsAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

