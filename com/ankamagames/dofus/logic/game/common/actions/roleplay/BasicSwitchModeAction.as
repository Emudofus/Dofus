package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class BasicSwitchModeAction implements Action 
    {

        public var type:int;


        public static function create(pType:int):BasicSwitchModeAction
        {
            var action:BasicSwitchModeAction = new (BasicSwitchModeAction)();
            action.type = pType;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.roleplay

