package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PaddockRemoveItemRequestAction implements Action 
    {

        public var cellId:uint;


        public static function create(cellId:uint):PaddockRemoveItemRequestAction
        {
            var o:PaddockRemoveItemRequestAction = new (PaddockRemoveItemRequestAction)();
            o.cellId = cellId;
            return (o);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount

