package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class DeleteObjectAction implements Action 
    {

        public var objectUID:uint;
        public var quantity:uint;


        public static function create(objectUID:uint, quantity:uint):DeleteObjectAction
        {
            var a:DeleteObjectAction = new (DeleteObjectAction)();
            a.objectUID = objectUID;
            a.quantity = quantity;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

