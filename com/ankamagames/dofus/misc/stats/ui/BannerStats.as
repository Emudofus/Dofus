package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.berilia.utils.BeriliaHookList;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.berilia.components.messages.SelectItemMessage;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.network.enums.StatisticTypeEnum;

    public class BannerStats implements IUiStats 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(BannerStats));

        private var _currentBtnMenuId:uint;

        public function BannerStats(pUi:UiRootContainer)
        {
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
            if ((((((pHook.name == BeriliaHookList.MouseClick.name)) && (pArgs[0].name))) && (((!((pArgs[0].name.indexOf("btn") == -1))) || ((((((pArgs[0].name == "strata_0")) && (pArgs[0].parent))) && (!((pArgs[0].parent.name.indexOf("btn") == -1)))))))))
            {
                this.sendClick();
            };
        }

        public function process(pMessage:Message):void
        {
            var _local_2:SelectItemMessage;
            var _local_3:Grid;
            switch (true)
            {
                case (pMessage is SelectItemMessage):
                    _local_2 = (pMessage as SelectItemMessage);
                    _local_3 = (_local_2.target as Grid);
                    if (((_local_3) && ((((_local_3.name == "gd_btnUis")) || ((_local_3.name == "gd_additionalBtns"))))))
                    {
                        if (((_local_3.selectedItem) && (!((this._currentBtnMenuId == _local_3.selectedItem.id)))))
                        {
                            this.sendOpenMenu();
                            this._currentBtnMenuId = _local_3.selectedItem.id;
                        }
                        else
                        {
                            this._currentBtnMenuId = 0;
                        };
                    };
                    return;
            };
        }

        private function sendClick():void
        {
            var action:StatsAction = StatsAction.get(StatisticTypeEnum.CLICK_ON_BUTTON);
            action.start();
            action.send();
        }

        private function sendOpenMenu():void
        {
            var action:StatsAction = StatsAction.get(StatisticTypeEnum.DISPLAY_MENU);
            action.start();
            action.send();
        }

        public function remove():void
        {
        }


    }
}//package com.ankamagames.dofus.misc.stats.ui

