package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ObjectUseAction implements Action 
    {

        public var objectUID:uint;
        public var useOnCell:Boolean;
        public var quantity:int;


        public static function create(objectUID:uint, quantity:int=1, useOnCell:Boolean=false):ObjectUseAction
        {
            var a:ObjectUseAction = new (ObjectUseAction)();
            a.objectUID = objectUID;
            a.quantity = quantity;
            a.useOnCell = useOnCell;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

