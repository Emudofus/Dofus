package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.types.data.Hook;

    public class NicknameRegistrationStats implements IUiStats 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(NicknameRegistrationStats));

        private var _action:StatsAction;

        public function NicknameRegistrationStats(pUi:UiRootContainer)
        {
            this._action = StatsAction.get(StatisticTypeEnum.STEP0000_CHOSE_NICKNAME);
            this._action.start();
        }

        public function process(pMessage:Message):void
        {
            var _local_2:MouseClickMessage;
            switch (true)
            {
                case (pMessage is MouseClickMessage):
                    _local_2 = (pMessage as MouseClickMessage);
                    if (_local_2.target.name == "btn_validate")
                    {
                        this._action.send();
                    };
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

