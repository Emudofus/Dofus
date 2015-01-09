package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class TimelineEntityClickAction implements Action 
    {

        public var fighterId:int;


        public static function create(id:int):TimelineEntityClickAction
        {
            var a:TimelineEntityClickAction = new (TimelineEntityClickAction)();
            a.fighterId = id;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions

