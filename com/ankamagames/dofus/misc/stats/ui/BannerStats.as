package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   
   public class BannerStats extends Object implements IUiStats
   {
      
      public function BannerStats(pUi:UiRootContainer) {
         super();
      }
      
      private static const _log:Logger;
      
      private var _currentBtnMenuId:uint;
      
      public function onHook(pHook:Hook, pArgs:Array) : void {
         if((pHook.name == BeriliaHookList.MouseClick.name) && (pArgs[0].name) && ((!(pArgs[0].name.indexOf("btn") == -1)) || (pArgs[0].name == "strata_0" && pArgs[0].parent && !(pArgs[0].parent.name.indexOf("btn") == -1))))
         {
            this.sendClick();
         }
      }
      
      public function process(pMessage:Message) : void {
         var simsg:SelectItemMessage = null;
         var grid:Grid = null;
         switch(true)
         {
            case pMessage is SelectItemMessage:
               simsg = pMessage as SelectItemMessage;
               grid = simsg.target as Grid;
               if((grid) && ((grid.name == "gd_btnUis") || (grid.name == "gd_additionalBtns")))
               {
                  if((grid.selectedItem) && (!(this._currentBtnMenuId == grid.selectedItem.id)))
                  {
                     this.sendOpenMenu();
                     this._currentBtnMenuId = grid.selectedItem.id;
                  }
                  else
                  {
                     this._currentBtnMenuId = 0;
                  }
               }
               break;
         }
      }
      
      private function sendClick() : void {
         var action:StatsAction = StatsAction.get(StatisticTypeEnum.CLICK_ON_BUTTON);
         action.start();
         action.send();
      }
      
      private function sendOpenMenu() : void {
         var action:StatsAction = StatsAction.get(StatisticTypeEnum.DISPLAY_MENU);
         action.start();
         action.send();
      }
      
      public function remove() : void {
      }
   }
}
