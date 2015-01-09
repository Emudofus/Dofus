package com.ankamagames.dofus.logic.game.common.actions.alliance
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AllianceListRequestAction implements Action 
    {


        public static function create():AllianceListRequestAction
        {
            var action:AllianceListRequestAction = new (AllianceListRequestAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.alliance

