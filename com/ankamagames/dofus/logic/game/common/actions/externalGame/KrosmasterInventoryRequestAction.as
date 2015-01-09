package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class KrosmasterInventoryRequestAction implements Action 
    {


        public static function create():KrosmasterInventoryRequestAction
        {
            var action:KrosmasterInventoryRequestAction = new (KrosmasterInventoryRequestAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.externalGame

