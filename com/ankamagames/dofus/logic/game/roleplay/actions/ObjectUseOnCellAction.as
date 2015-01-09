package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ObjectUseOnCellAction implements Action 
    {

        public var targetedCell:uint;
        public var objectUID:uint;


        public static function create(objectUID:uint, targetedCell:uint):ObjectUseOnCellAction
        {
            var o:ObjectUseOnCellAction = new (ObjectUseOnCellAction)();
            o.targetedCell = targetedCell;
            o.objectUID = objectUID;
            return (o);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

