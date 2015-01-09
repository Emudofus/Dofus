package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ChallengeTargetsListRequestAction implements Action 
    {

        public var challengeId:uint;


        public static function create(challengeId:uint):ChallengeTargetsListRequestAction
        {
            var a:ChallengeTargetsListRequestAction = new (ChallengeTargetsListRequestAction)();
            a.challengeId = challengeId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.actions

