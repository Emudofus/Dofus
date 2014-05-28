package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyShowMenuAction extends Object implements Action
   {
      
      public function PartyShowMenuAction() {
         super();
      }
      
      public static function create(pPlayerId:uint, pPartyId:int) : PartyShowMenuAction {
         var a:PartyShowMenuAction = new PartyShowMenuAction();
         a.playerId = pPlayerId;
         a.partyId = pPartyId;
         return a;
      }
      
      public var playerId:uint;
      
      public var partyId:int;
   }
}
