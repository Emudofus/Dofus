package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SpellSetPositionAction extends Object implements Action
   {
      
      public function SpellSetPositionAction() {
         super();
      }
      
      public static function create(spellID:uint, position:uint) : SpellSetPositionAction {
         var a:SpellSetPositionAction = new SpellSetPositionAction();
         a.spellID = spellID;
         a.position = position;
         return a;
      }
      
      public var spellID:uint;
      
      public var position:uint;
   }
}
