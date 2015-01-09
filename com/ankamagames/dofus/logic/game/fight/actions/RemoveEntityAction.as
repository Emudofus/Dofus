package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class RemoveEntityAction implements Action 
    {

        public var actorId:int;


        public static function create(actorId:int):RemoveEntityAction
        {
            var o:RemoveEntityAction = new (RemoveEntityAction)();
            o.actorId = actorId;
            return (o);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions

