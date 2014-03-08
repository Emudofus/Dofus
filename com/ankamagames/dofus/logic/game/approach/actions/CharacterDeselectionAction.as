package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterDeselectionAction extends Object implements Action
   {
      
      public function CharacterDeselectionAction() {
         super();
      }
      
      public static function create() : CharacterDeselectionAction {
         var a:CharacterDeselectionAction = new CharacterDeselectionAction();
         return a;
      }
   }
}
