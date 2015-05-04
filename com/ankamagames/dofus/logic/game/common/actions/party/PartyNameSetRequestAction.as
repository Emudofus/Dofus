package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyNameSetRequestAction extends Object implements Action
   {
      
      public function PartyNameSetRequestAction()
      {
         super();
      }
      
      public static function create(param1:int, param2:String) : PartyNameSetRequestAction
      {
         var _loc3_:PartyNameSetRequestAction = new PartyNameSetRequestAction();
         _loc3_.partyId = param1;
         _loc3_.partyName = param2;
         return _loc3_;
      }
      
      public var partyId:int;
      
      public var partyName:String;
   }
}
