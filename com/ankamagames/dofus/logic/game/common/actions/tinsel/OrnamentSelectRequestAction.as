package com.ankamagames.dofus.logic.game.common.actions.tinsel
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OrnamentSelectRequestAction implements Action 
    {

        public var ornamentId:int;


        public static function create(ornamentId:int):OrnamentSelectRequestAction
        {
            var action:OrnamentSelectRequestAction = new (OrnamentSelectRequestAction)();
            action.ornamentId = ornamentId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.tinsel

