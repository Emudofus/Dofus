package com.ankamagames.dofus.misc.stats.frames
{
    import com.ankamagames.dofus.misc.stats.IStatsClass;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
    import com.ankamagames.jerakine.messages.Message;

    public class LoadingModuleFrameStats implements IStatsClass 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(LoadingModuleFrameStats));

        private var _action:StatsAction;

        public function LoadingModuleFrameStats()
        {
            this._action = StatsAction.get(StatisticTypeEnum.STEP0300_LOADING_SCREEN);
            this._action.start();
        }

        public function process(pMessage:Message):void
        {
        }

        public function remove():void
        {
            this._action.send();
        }


    }
}//package com.ankamagames.dofus.misc.stats.frames

