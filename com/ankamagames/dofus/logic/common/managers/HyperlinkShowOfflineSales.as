package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class HyperlinkShowOfflineSales extends Object
   {
      
      public function HyperlinkShowOfflineSales()
      {
         super();
      }
      
      public static function showOfflineSales() : void
      {
         var _loc1_:ChatFrame = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
         KernelEventsManager.getInstance().processCallback(HookList.OpenOfflineSales,_loc1_.offlineSales);
      }
   }
}
