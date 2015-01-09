package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
    import com.ankamagames.dofus.logic.connection.actions.AcquaintanceSearchAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.types.data.Hook;

    public class ServerListSelectionStats implements IUiStats 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerListSelectionStats));

        private var _action:StatsAction;

        public function ServerListSelectionStats(pUi:UiRootContainer)
        {
            this._action = StatsAction.get(StatisticTypeEnum.STEP0100_CHOSE_SERVER);
            this._action.start();
        }

        public function process(pMessage:Message):void
        {
            var _local_2:ServerSelectionAction;
            switch (true)
            {
                case (pMessage is AcquaintanceSearchAction):
                    this._action.addParam("Seek_A_Friend", true);
                    return;
                case (pMessage is ServerSelectionAction):
                    _local_2 = (pMessage as ServerSelectionAction);
                    this._action.addParam("Chosen_Server_ID", _local_2.serverId);
                    this._action.addParam("Automatic_Choice", false);
                    if (!(this._action.hasParam("Seek_A_Friend")))
                    {
                        this._action.addParam("Seek_A_Friend", false);
                    };
                    this._action.send();
                    return;
            };
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
        }

        public function remove():void
        {
        }


    }
}//package com.ankamagames.dofus.misc.stats.ui

