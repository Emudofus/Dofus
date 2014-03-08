package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DeleteObjectAction extends Object implements Action
   {
      
      public function DeleteObjectAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : DeleteObjectAction {
         var _loc3_:DeleteObjectAction = new DeleteObjectAction();
         _loc3_.objectUID = param1;
         _loc3_.quantity = param2;
         return _loc3_;
      }
      
      public var objectUID:uint;
      
      public var quantity:uint;
   }
}
