package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class TimelineEntityOutAction implements Action 
    {

        public var targetId:int;


        public static function create(target:int):TimelineEntityOutAction
        {
            var a:TimelineEntityOutAction = new (TimelineEntityOutAction)();
            a.targetId = target;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions

