package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ValidateSpellForgetAction extends Object implements Action
   {
      
      public function ValidateSpellForgetAction() {
         super();
      }
      
      public static function create(param1:uint) : ValidateSpellForgetAction {
         var _loc2_:ValidateSpellForgetAction = new ValidateSpellForgetAction();
         _loc2_.spellId = param1;
         return _loc2_;
      }
      
      public var spellId:uint;
   }
}
