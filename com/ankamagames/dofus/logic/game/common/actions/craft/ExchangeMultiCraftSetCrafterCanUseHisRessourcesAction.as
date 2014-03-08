package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction extends Object implements Action
   {
      
      public function ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction() {
         super();
      }
      
      public static function create(pAllow:Boolean) : ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction {
         var action:ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction = new ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction();
         action.allow = pAllow;
         return action;
      }
      
      public var allow:Boolean;
   }
}
