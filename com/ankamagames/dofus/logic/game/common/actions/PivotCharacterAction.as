package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PivotCharacterAction extends Object implements Action
   {
      
      public function PivotCharacterAction() {
         super();
      }
      
      public static function create() : PivotCharacterAction {
         var action:PivotCharacterAction = new PivotCharacterAction();
         return action;
      }
   }
}
