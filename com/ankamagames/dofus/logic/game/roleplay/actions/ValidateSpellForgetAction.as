package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ValidateSpellForgetAction extends Object implements Action
   {
      
      public function ValidateSpellForgetAction() {
         super();
      }
      
      public static function create(spellId:uint) : ValidateSpellForgetAction {
         var a:ValidateSpellForgetAction = new ValidateSpellForgetAction();
         a.spellId = spellId;
         return a;
      }
      
      public var spellId:uint;
   }
}
