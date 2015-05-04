package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
   
   public class HyperlinkTaxCollectorCollected extends Object
   {
      
      public function HyperlinkTaxCollectorCollected()
      {
         super();
      }
      
      public static function showCollectedTaxCollector(param1:uint) : void
      {
         KernelEventsManager.getInstance().processCallback(HookList.ShowCollectedTaxCollector,TaxCollectorsManager.getInstance().collectedTaxCollectors[param1]);
      }
      
      public static function rollOver(param1:int, param2:int, param3:uint) : void
      {
      }
   }
}
