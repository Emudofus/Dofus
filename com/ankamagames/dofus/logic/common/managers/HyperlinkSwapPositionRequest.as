package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   
   public class HyperlinkSwapPositionRequest extends Object
   {
      
      public function HyperlinkSwapPositionRequest()
      {
         super();
      }
      
      public static function showMenu(param1:uint, param2:Boolean) : void
      {
         var _loc3_:FightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
         if((_loc3_) && (_loc3_.isSwapPositionRequestValid(param1)))
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.ShowSwapPositionRequestMenu,param1,param2);
         }
      }
   }
}
