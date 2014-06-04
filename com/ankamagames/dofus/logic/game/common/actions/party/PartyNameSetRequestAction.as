package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyNameSetRequestAction extends Object implements Action
   {
      
      public function PartyNameSetRequestAction() {
         super();
      }
      
      public static function create(partyId:int, partyName:String) : PartyNameSetRequestAction {
         var a:PartyNameSetRequestAction = new PartyNameSetRequestAction();
         a.partyId = partyId;
         a.partyName = partyName;
         return a;
      }
      
      public var partyId:int;
      
      public var partyName:String;
   }
}
