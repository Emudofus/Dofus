package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GameFightPlacementPositionRequestAction implements Action 
    {

        public var cellId:int;


        public static function create(id:int):GameFightPlacementPositionRequestAction
        {
            var a:GameFightPlacementPositionRequestAction = new (GameFightPlacementPositionRequestAction)();
            a.cellId = id;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions

