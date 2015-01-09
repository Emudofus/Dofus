package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class DungeonPartyFinderRegisterAction implements Action 
    {

        public var dungeons:Array;


        public static function create(dungeons:Array):DungeonPartyFinderRegisterAction
        {
            var a:DungeonPartyFinderRegisterAction = new (DungeonPartyFinderRegisterAction)();
            a.dungeons = dungeons;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

