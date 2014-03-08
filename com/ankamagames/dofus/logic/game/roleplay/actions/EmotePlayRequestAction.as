package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class EmotePlayRequestAction extends Object implements Action
   {
      
      public function EmotePlayRequestAction() {
         super();
      }
      
      public static function create(emoteId:uint) : EmotePlayRequestAction {
         var a:EmotePlayRequestAction = new EmotePlayRequestAction();
         a.emoteId = emoteId;
         return a;
      }
      
      public var emoteId:uint;
   }
}
