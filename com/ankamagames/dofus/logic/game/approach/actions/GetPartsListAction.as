package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GetPartsListAction implements Action 
    {


        public static function create():GetPartsListAction
        {
            var a:GetPartsListAction = new (GetPartsListAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions

