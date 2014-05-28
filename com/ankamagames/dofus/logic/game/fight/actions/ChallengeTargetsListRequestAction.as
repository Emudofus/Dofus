package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChallengeTargetsListRequestAction extends Object implements Action
   {
      
      public function ChallengeTargetsListRequestAction() {
         super();
      }
      
      public static function create(challengeId:uint) : ChallengeTargetsListRequestAction {
         var a:ChallengeTargetsListRequestAction = new ChallengeTargetsListRequestAction();
         a.challengeId = challengeId;
         return a;
      }
      
      public var challengeId:uint;
   }
}
