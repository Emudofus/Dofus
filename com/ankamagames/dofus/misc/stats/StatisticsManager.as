package com.ankamagames.dofus.misc.stats
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.connection.frames.ServerSelectionFrame;
    import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
    import com.ankamagames.dofus.misc.stats.ui.NicknameRegistrationStats;
    import com.ankamagames.dofus.misc.stats.ui.ServerSimpleSelectionStats;
    import com.ankamagames.dofus.misc.stats.ui.ServerListSelectionStats;
    import com.ankamagames.dofus.misc.stats.ui.CharacterCreationStats;
    import com.ankamagames.dofus.misc.stats.ui.CinematicStats;
    import com.ankamagames.dofus.misc.stats.ui.TutorialStats;
    import com.ankamagames.dofus.misc.stats.ui.BannerStats;
    import com.ankamagames.dofus.logic.common.frames.LoadingModuleFrame;
    import com.ankamagames.dofus.misc.stats.frames.LoadingModuleFrameStats;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.types.event.UiRenderEvent;
    import com.ankamagames.berilia.types.event.UiUnloadEvent;
    import com.ankamagames.jerakine.logger.ModuleLogger;
    import com.ankamagames.jerakine.messages.events.FramePushedEvent;
    import com.ankamagames.jerakine.messages.events.FramePulledEvent;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.misc.stats.ui.IUiStats;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;

    public class StatisticsManager 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(StatisticsManager));
        private static var _self:StatisticsManager;

        private var _frame:StatisticsFrame;
        private var _init:Boolean;
        private var _framesStatsAssoc:Dictionary;
        private var _framesStats:Dictionary;
        private var _uisStatsAssoc:Dictionary;
        private var _uisStats:Dictionary;
        private var _dataStoreType:DataStoreType;
        private var _statsEnabled:Boolean = true;
        private var _characterSelected:Boolean = false;

        public function StatisticsManager()
        {
            this._uisStatsAssoc = new Dictionary(true);
            this._uisStats = new Dictionary(true);
            this._framesStatsAssoc = new Dictionary(true);
            this._framesStats = new Dictionary(true);
            this._frame = new StatisticsFrame(this._framesStats);
            this.initDataStoreType();
        }

        public static function getInstance():StatisticsManager
        {
            if (!(_self))
            {
                _self = new (StatisticsManager)();
            };
            return (_self);
        }


        public function get statsEnabled():Boolean
        {
            return (this._statsEnabled);
        }

        public function set statsEnabled(pValue:Boolean):void
        {
            this._statsEnabled = pValue;
            if (!(this.statsEnabled))
            {
                Kernel.getWorker().removeFrame(this._frame);
                StatsAction.deletePendingActions();
            }
            else
            {
                StatsAction.sendPendingActions();
            };
        }

        public function isConnected():Boolean
        {
            return (((!(Kernel.getWorker().contains(AuthentificationFrame))) && (!(Kernel.getWorker().contains(ServerSelectionFrame)))));
        }

        public function init():void
        {
            this.registerUiStats("pseudoChoice", NicknameRegistrationStats);
            this.registerUiStats("serverSimpleSelection", ServerSimpleSelectionStats);
            this.registerUiStats("serverListSelection", ServerListSelectionStats);
            this.registerUiStats("characterCreation", CharacterCreationStats);
            this.registerUiStats("cinematic", CinematicStats);
            this.registerUiStats("tutorial", TutorialStats);
            this.registerUiStats("banner", BannerStats);
            this.registerFrameStats(LoadingModuleFrame, LoadingModuleFrameStats);
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete, this.onUiLoaded);
            Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_STARTED, this.onUiUnloadStart);
            ModuleLogger.active = true;
            ModuleLogger.addCallback(this.log);
            Kernel.getWorker().addEventListener(FramePushedEvent.EVENT_FRAME_PUSHED, this.onFramePushed);
            Kernel.getWorker().addEventListener(FramePulledEvent.EVENT_FRAME_PULLED, this.onFramePulled);
        }

        public function get frame():StatisticsFrame
        {
            return (this._frame);
        }

        public function saveActionTimestamp(pActionId:uint, pTimestamp:Number):void
        {
            StoreDataManager.getInstance().setData(this._dataStoreType, this.getActionDataId(pActionId), pTimestamp);
        }

        public function getActionTimestamp(pActionId:uint):Number
        {
            var data:* = StoreDataManager.getInstance().getData(this._dataStoreType, this.getActionDataId(pActionId));
            return ((((((data is Number)) && (!(isNaN(data))))) ? (data as Number) : NaN));
        }

        public function deleteTimeStamp(pActionId:uint):void
        {
            this.saveActionTimestamp(pActionId, NaN);
        }

        private function getActionDataId(pActionId:uint):String
        {
            var id:String;
            var characterName:String = ((PlayedCharacterManager.getInstance().infos) ? PlayedCharacterManager.getInstance().infos.name : null);
            var accountName:String = PlayerManager.getInstance().nickname;
            if (characterName)
            {
                id = characterName;
            }
            else
            {
                if (accountName)
                {
                    id = accountName;
                };
            };
            var actionId:String = pActionId.toString();
            var dataId:String = ((id) ? ((id + "#") + actionId) : actionId);
            return (dataId);
        }

        private function log(... args):void
        {
            var uiStats:IUiStats;
            if (this._statsEnabled)
            {
                if ((args[0] is Message))
                {
                    for each (uiStats in this._uisStats)
                    {
                        uiStats.process((args[0] as Message));
                    };
                }
                else
                {
                    if ((args[0] is Hook))
                    {
                        for each (uiStats in this._uisStats)
                        {
                            uiStats.onHook((args[0] as Hook), args[1]);
                        };
                    };
                };
            };
        }

        private function registerUiStats(pUiName:String, pUiStatsClass:Class):void
        {
            this._uisStatsAssoc[pUiName] = pUiStatsClass;
        }

        private function registerFrameStats(pFrameClass:Class, pFrameStatsClass:Class):void
        {
            this._framesStatsAssoc[pFrameClass] = pFrameStatsClass;
        }

        private function initDataStoreType():void
        {
            var storeKey:String = "statistics";
            if (((!(this._dataStoreType)) || (!((this._dataStoreType.category == storeKey)))))
            {
                this._dataStoreType = new DataStoreType(storeKey, true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
            };
        }

        private function onUiLoaded(pEvent:UiRenderEvent):void
        {
            var uiStatsClass:Class = this._uisStatsAssoc[pEvent.uiTarget.name];
            if (uiStatsClass)
            {
                this._uisStats[pEvent.uiTarget.name] = new (uiStatsClass)(pEvent.uiTarget);
            };
        }

        private function onUiUnloadStart(pEvent:UiUnloadEvent):void
        {
            var uistats:IUiStats = this._uisStats[pEvent.name];
            if (uistats)
            {
                uistats.remove();
            };
            delete this._uisStats[pEvent.name];
        }

        private function onFramePushed(pEvent:FramePushedEvent):void
        {
            var frameClass:*;
            var className:String = getQualifiedClassName(pEvent.frame).split("::")[1];
            for (frameClass in this._framesStatsAssoc)
            {
                if ((pEvent.frame is frameClass))
                {
                    this._framesStats[className] = new (this._framesStatsAssoc[frameClass])();
                    break;
                };
            };
        }

        private function onFramePulled(pEvent:FramePulledEvent):void
        {
            var className:String = getQualifiedClassName(pEvent.frame).split("::")[1];
            var frameStats:IStatsClass = this._framesStats[className];
            if (frameStats)
            {
                frameStats.remove();
            };
            delete this._framesStats[className];
        }


    }
}//package com.ankamagames.dofus.misc.stats

