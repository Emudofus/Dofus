package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyInvitationAction extends Object implements Action
   {
      
      public function PartyInvitationAction() {
         super();
      }
      
      public static function create(name:String, dungeon:uint=0, inArena:Boolean=false) : PartyInvitationAction {
         var a:PartyInvitationAction = new PartyInvitationAction();
         a.name = name;
         a.dungeon = dungeon;
         a.inArena = inArena;
         return a;
      }
      
      public var name:String;
      
      public var dungeon:uint;
      
      public var inArena:Boolean;
   }
}
