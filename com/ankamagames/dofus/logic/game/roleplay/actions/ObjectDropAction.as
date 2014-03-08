package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ObjectDropAction extends Object implements Action
   {
      
      public function ObjectDropAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint) : ObjectDropAction {
         var _loc4_:ObjectDropAction = new ObjectDropAction();
         _loc4_.objectUID = param1;
         _loc4_.objectGID = param2;
         _loc4_.quantity = param3;
         return _loc4_;
      }
      
      public var objectUID:uint;
      
      public var objectGID:uint;
      
      public var quantity:uint;
   }
}
