package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction extends Object implements Action
   {
      
      public function ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction() {
         super();
      }
      
      public static function create(param1:Boolean) : ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction {
         var _loc2_:ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction = new ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction();
         _loc2_.allow = param1;
         return _loc2_;
      }
      
      public var allow:Boolean;
   }
}
