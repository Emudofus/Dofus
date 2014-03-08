package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyInvitationAction extends Object implements Action
   {
      
      public function PartyInvitationAction() {
         super();
      }
      
      public static function create(param1:String, param2:uint=0, param3:Boolean=false) : PartyInvitationAction {
         var _loc4_:PartyInvitationAction = new PartyInvitationAction();
         _loc4_.name = param1;
         _loc4_.dungeon = param2;
         _loc4_.inArena = param3;
         return _loc4_;
      }
      
      public var name:String;
      
      public var dungeon:uint;
      
      public var inArena:Boolean;
   }
}
