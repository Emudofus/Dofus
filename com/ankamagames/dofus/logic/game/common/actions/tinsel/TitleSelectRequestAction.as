package com.ankamagames.dofus.logic.game.common.actions.tinsel
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class TitleSelectRequestAction implements Action 
    {

        public var titleId:int;


        public static function create(titleId:int):TitleSelectRequestAction
        {
            var action:TitleSelectRequestAction = new (TitleSelectRequestAction)();
            action.titleId = titleId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.tinsel

