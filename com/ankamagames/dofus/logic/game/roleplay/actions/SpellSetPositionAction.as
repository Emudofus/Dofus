package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SpellSetPositionAction extends Object implements Action
   {
      
      public function SpellSetPositionAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : SpellSetPositionAction {
         var _loc3_:SpellSetPositionAction = new SpellSetPositionAction();
         _loc3_.spellID = param1;
         _loc3_.position = param2;
         return _loc3_;
      }
      
      public var spellID:uint;
      
      public var position:uint;
   }
}
