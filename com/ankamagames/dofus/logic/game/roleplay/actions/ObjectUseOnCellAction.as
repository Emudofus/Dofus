package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ObjectUseOnCellAction extends Object implements Action
   {
      
      public function ObjectUseOnCellAction() {
         super();
      }
      
      public static function create(objectUID:uint, targetedCell:uint) : ObjectUseOnCellAction {
         var o:ObjectUseOnCellAction = new ObjectUseOnCellAction();
         o.targetedCell = targetedCell;
         o.objectUID = objectUID;
         return o;
      }
      
      public var targetedCell:uint;
      
      public var objectUID:uint;
   }
}
