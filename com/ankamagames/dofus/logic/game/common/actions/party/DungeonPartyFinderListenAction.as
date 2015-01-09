package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class DungeonPartyFinderListenAction implements Action 
    {

        public var dungeonId:uint;


        public static function create(dungeonId:uint):DungeonPartyFinderListenAction
        {
            var a:DungeonPartyFinderListenAction = new (DungeonPartyFinderListenAction)();
            a.dungeonId = dungeonId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

