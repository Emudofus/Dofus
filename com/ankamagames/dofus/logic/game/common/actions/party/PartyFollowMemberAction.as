package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyFollowMemberAction extends Object implements Action
   {
      
      public function PartyFollowMemberAction() {
         super();
      }
      
      public static function create(partyId:int, pPlayerId:uint) : PartyFollowMemberAction {
         var a:PartyFollowMemberAction = new PartyFollowMemberAction();
         a.partyId = partyId;
         a.playerId = pPlayerId;
         return a;
      }
      
      public var playerId:uint;
      
      public var partyId:int;
   }
}
