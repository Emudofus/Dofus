package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ObjectSetPositionAction extends Object implements Action
   {
      
      public function ObjectSetPositionAction() {
         super();
      }
      
      public static function create(objectUID:uint, position:uint, quantity:uint=1) : ObjectSetPositionAction {
         var a:ObjectSetPositionAction = new ObjectSetPositionAction();
         a.objectUID = objectUID;
         a.quantity = quantity;
         a.position = position;
         return a;
      }
      
      public var objectUID:uint;
      
      public var position:uint;
      
      public var quantity:uint;
   }
}
