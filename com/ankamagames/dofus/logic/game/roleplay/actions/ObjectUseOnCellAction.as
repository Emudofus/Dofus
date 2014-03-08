package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ObjectUseOnCellAction extends Object implements Action
   {
      
      public function ObjectUseOnCellAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : ObjectUseOnCellAction {
         var _loc3_:ObjectUseOnCellAction = new ObjectUseOnCellAction();
         _loc3_.targetedCell = param2;
         _loc3_.objectUID = param1;
         return _loc3_;
      }
      
      public var targetedCell:uint;
      
      public var objectUID:uint;
   }
}
