package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectDissociateAction extends Object implements Action
   {
      
      public function LivingObjectDissociateAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : LivingObjectDissociateAction {
         var _loc3_:LivingObjectDissociateAction = new LivingObjectDissociateAction();
         _loc3_.livingUID = param1;
         _loc3_.livingPosition = param2;
         return _loc3_;
      }
      
      public var livingUID:uint;
      
      public var livingPosition:uint;
   }
}
