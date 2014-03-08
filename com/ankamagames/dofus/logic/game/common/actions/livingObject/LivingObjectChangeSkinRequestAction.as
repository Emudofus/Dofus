package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectChangeSkinRequestAction extends Object implements Action
   {
      
      public function LivingObjectChangeSkinRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint) : LivingObjectChangeSkinRequestAction {
         var _loc4_:LivingObjectChangeSkinRequestAction = new LivingObjectChangeSkinRequestAction();
         _loc4_.livingUID = param1;
         _loc4_.livingPosition = param2;
         _loc4_.skinId = param3;
         return _loc4_;
      }
      
      public var livingUID:uint;
      
      public var livingPosition:uint;
      
      public var skinId:uint;
   }
}
