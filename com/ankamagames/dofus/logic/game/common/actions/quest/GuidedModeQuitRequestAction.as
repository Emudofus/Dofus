package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuidedModeQuitRequestAction implements Action 
    {


        public static function create():GuidedModeQuitRequestAction
        {
            return (new (GuidedModeQuitRequestAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest

