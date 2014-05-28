package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangePlayerMultiCraftRequestAction extends Object implements Action
   {
      
      public function ExchangePlayerMultiCraftRequestAction() {
         super();
      }
      
      public static function create(pExchangeType:int, pTarget:uint, pSkillId:uint) : ExchangePlayerMultiCraftRequestAction {
         var action:ExchangePlayerMultiCraftRequestAction = new ExchangePlayerMultiCraftRequestAction();
         action.exchangeType = pExchangeType;
         action.target = pTarget;
         action.skillId = pSkillId;
         return action;
      }
      
      public var exchangeType:int;
      
      public var target:uint;
      
      public var skillId:uint;
   }
}
