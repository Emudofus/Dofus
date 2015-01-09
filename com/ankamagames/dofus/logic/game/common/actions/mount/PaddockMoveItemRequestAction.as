package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PaddockMoveItemRequestAction implements Action 
    {

        public var object:Object;


        public static function create(object:Object):PaddockMoveItemRequestAction
        {
            var o:PaddockMoveItemRequestAction = new (PaddockMoveItemRequestAction)();
            o.object = object;
            return (o);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount

