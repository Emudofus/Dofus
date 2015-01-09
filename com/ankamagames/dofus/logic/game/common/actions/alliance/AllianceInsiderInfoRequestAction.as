package com.ankamagames.dofus.logic.game.common.actions.alliance
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AllianceInsiderInfoRequestAction implements Action 
    {


        public static function create():AllianceInsiderInfoRequestAction
        {
            var action:AllianceInsiderInfoRequestAction = new (AllianceInsiderInfoRequestAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.alliance

