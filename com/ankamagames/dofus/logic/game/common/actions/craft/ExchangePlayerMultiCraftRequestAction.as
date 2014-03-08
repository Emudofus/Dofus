package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangePlayerMultiCraftRequestAction extends Object implements Action
   {
      
      public function ExchangePlayerMultiCraftRequestAction() {
         super();
      }
      
      public static function create(param1:int, param2:uint, param3:uint) : ExchangePlayerMultiCraftRequestAction {
         var _loc4_:ExchangePlayerMultiCraftRequestAction = new ExchangePlayerMultiCraftRequestAction();
         _loc4_.exchangeType = param1;
         _loc4_.target = param2;
         _loc4_.skillId = param3;
         return _loc4_;
      }
      
      public var exchangeType:int;
      
      public var target:uint;
      
      public var skillId:uint;
   }
}
