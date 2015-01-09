package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PivotCharacterAction implements Action 
    {


        public static function create():PivotCharacterAction
        {
            var action:PivotCharacterAction = new (PivotCharacterAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

