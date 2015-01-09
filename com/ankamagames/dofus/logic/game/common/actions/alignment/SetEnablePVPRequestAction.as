package com.ankamagames.dofus.logic.game.common.actions.alignment
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class SetEnablePVPRequestAction implements Action 
    {

        public var enable:Boolean;


        public static function create(enable:Boolean):SetEnablePVPRequestAction
        {
            var action:SetEnablePVPRequestAction = new (SetEnablePVPRequestAction)();
            action.enable = enable;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.alignment

