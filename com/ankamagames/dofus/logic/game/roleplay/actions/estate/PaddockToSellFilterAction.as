package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockToSellFilterAction extends Object implements Action
   {
      
      public function PaddockToSellFilterAction() {
         super();
      }
      
      public static function create(param1:int, param2:uint, param3:uint, param4:uint) : PaddockToSellFilterAction {
         var _loc5_:PaddockToSellFilterAction = new PaddockToSellFilterAction();
         _loc5_.areaId = param1;
         _loc5_.atLeastNbMount = param2;
         _loc5_.atLeastNbMachine = param3;
         _loc5_.maxPrice = param4;
         return _loc5_;
      }
      
      public var areaId:int;
      
      public var atLeastNbMount:uint;
      
      public var atLeastNbMachine:uint;
      
      public var maxPrice:uint;
   }
}
