package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.types.data.Hook;

    public class ServerSimpleSelectionStats implements IUiStats 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerSimpleSelectionStats));

        private var _action:StatsAction;

        public function ServerSimpleSelectionStats(pUi:UiRootContainer)
        {
            this._action = StatsAction.get(StatisticTypeEnum.STEP0100_CHOSE_SERVER);
            this._action.start();
        }

        public function process(pMessage:Message):void
        {
            var _local_2:MouseClickMessage;
            var _local_3:ServerSelectionAction;
            switch (true)
            {
                case (pMessage is MouseClickMessage):
                    _local_2 = (pMessage as MouseClickMessage);
                    if ((((_local_2.target.name == "btn_ok")) && (Berilia.getInstance().getUi("serverPopup"))))
                    {
                        this._action.addParam("Automatic_Choice", true);
                    };
                    return;
                case (pMessage is ServerSelectionAction):
                    _local_3 = (pMessage as ServerSelectionAction);
                    this._action.addParam("Chosen_Server_ID", _local_3.serverId);
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

