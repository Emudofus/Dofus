package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ArenaFightAnswerAction implements Action 
    {

        public var fightId:uint;
        public var accept:Boolean;


        public static function create(fightId:uint, accept:Boolean):ArenaFightAnswerAction
        {
            var a:ArenaFightAnswerAction = new (ArenaFightAnswerAction)();
            a.fightId = fightId;
            a.accept = accept;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

