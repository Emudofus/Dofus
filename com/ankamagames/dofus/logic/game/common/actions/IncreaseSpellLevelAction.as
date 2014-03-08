package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class IncreaseSpellLevelAction extends Object implements Action
   {
      
      public function IncreaseSpellLevelAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : IncreaseSpellLevelAction {
         var _loc3_:IncreaseSpellLevelAction = new IncreaseSpellLevelAction();
         _loc3_.spellId = param1;
         _loc3_.spellLevel = param2;
         return _loc3_;
      }
      
      public var spellId:uint;
      
      public var spellLevel:uint;
   }
}
