package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class IncreaseSpellLevelAction extends Object implements Action
   {
      
      public function IncreaseSpellLevelAction() {
         super();
      }
      
      public static function create(pSpellId:uint, pSpellLevel:uint) : IncreaseSpellLevelAction {
         var a:IncreaseSpellLevelAction = new IncreaseSpellLevelAction();
         a.spellId = pSpellId;
         a.spellLevel = pSpellLevel;
         return a;
      }
      
      public var spellId:uint;
      
      public var spellLevel:uint;
   }
}
