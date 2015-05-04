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
      
      public function BannerStats(param1:UiRootContainer)
      {
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(BannerStats));
      
      private var _currentBtnMenuId:uint;
      
      public function onHook(param1:Hook, param2:Array) : void
      {
         if((param1.name == BeriliaHookList.MouseClick.name) && (param2[0].name) && ((!(param2[0].name.indexOf("btn") == -1)) || (param2[0].name == "strata_0" && param2[0].parent && !(param2[0].parent.name.indexOf("btn") == -1))))
         {
            this.sendClick();
         }
      }
      
      public function process(param1:Message) : void
      {
         var _loc2_:SelectItemMessage = null;
         var _loc3_:Grid = null;
         switch(true)
         {
            case param1 is SelectItemMessage:
               _loc2_ = param1 as SelectItemMessage;
               _loc3_ = _loc2_.target as Grid;
               if((_loc3_) && (_loc3_.name == "gd_btnUis" || _loc3_.name == "gd_additionalBtns"))
               {
                  if((_loc3_.selectedItem) && !(this._currentBtnMenuId == _loc3_.selectedItem.id))
                  {
                     this.sendOpenMenu();
                     this._currentBtnMenuId = _loc3_.selectedItem.id;
                  }
                  else
                  {
                     this._currentBtnMenuId = 0;
                  }
               }
               break;
         }
      }
      
      private function sendClick() : void
      {
         var _loc1_:StatsAction = StatsAction.get(StatisticTypeEnum.CLICK_ON_BUTTON);
         _loc1_.start();
         _loc1_.send();
      }
      
      private function sendOpenMenu() : void
      {
         var _loc1_:StatsAction = StatsAction.get(StatisticTypeEnum.DISPLAY_MENU);
         _loc1_.start();
         _loc1_.send();
      }
      
      public function remove() : void
      {
      }
   }
}
