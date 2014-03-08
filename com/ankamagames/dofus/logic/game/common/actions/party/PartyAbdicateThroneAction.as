package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyAbdicateThroneAction extends Object implements Action
   {
      
      public function PartyAbdicateThroneAction() {
         super();
      }
      
      public static function create(partyId:int, pPlayerId:uint) : PartyAbdicateThroneAction {
         var a:PartyAbdicateThroneAction = new PartyAbdicateThroneAction();
         a.partyId = partyId;
         a.playerId = pPlayerId;
         return a;
      }
      
      public var playerId:uint;
      
      public var partyId:int;
   }
}
