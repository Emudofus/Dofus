package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ObjectSetPositionAction extends Object implements Action
   {
      
      public function ObjectSetPositionAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint=1) : ObjectSetPositionAction {
         var _loc4_:ObjectSetPositionAction = new ObjectSetPositionAction();
         _loc4_.objectUID = param1;
         _loc4_.quantity = param3;
         _loc4_.position = param2;
         return _loc4_;
      }
      
      public var objectUID:uint;
      
      public var position:uint;
      
      public var quantity:uint;
   }
}
