package com.ankamagames.dofus.misc.stats
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
   import com.ankamagames.dofus.logic.connection.frames.ServerSelectionFrame;
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
   
   public class StatisticsManager extends Object
   {
      
      public function StatisticsManager()
      {
         super();
         this._uisStatsAssoc = new Dictionary(true);
         this._uisStats = new Dictionary(true);
         this._framesStatsAssoc = new Dictionary(true);
         this._framesStats = new Dictionary(true);
         this._frame = new StatisticsFrame(this._framesStats);
         this.initDataStoreType();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(StatisticsManager));
      
      private static var _self:StatisticsManager;
      
      public static function getInstance() : StatisticsManager
      {
         if(!_self)
         {
            _self = new StatisticsManager();
         }
         return _self;
      }
      
      private var _frame:StatisticsFrame;
      
      private var _init:Boolean;
      
      private var _framesStatsAssoc:Dictionary;
      
      private var _framesStats:Dictionary;
      
      private var _uisStatsAssoc:Dictionary;
      
      private var _uisStats:Dictionary;
      
      private var _dataStoreType:DataStoreType;
      
      private var _statsEnabled:Boolean = true;
      
      private var _characterSelected:Boolean = false;
      
      public function get statsEnabled() : Boolean
      {
         return this._statsEnabled;
      }
      
      public function set statsEnabled(param1:Boolean) : void
      {
         this._statsEnabled = param1;
         if(!this.statsEnabled)
         {
            Kernel.getWorker().removeFrame(this._frame);
            StatsAction.deletePendingActions();
         }
         else
         {
            StatsAction.sendPendingActions();
         }
      }
      
      public function isConnected() : Boolean
      {
         return !Kernel.getWorker().contains(AuthentificationFrame) && !Kernel.getWorker().contains(ServerSelectionFrame);
      }
      
      public function init() : void
      {
         this.registerUiStats("pseudoChoice",NicknameRegistrationStats);
         this.registerUiStats("serverSimpleSelection",ServerSimpleSelectionStats);
         this.registerUiStats("serverListSelection",ServerListSelectionStats);
         this.registerUiStats("characterCreation",CharacterCreationStats);
         this.registerUiStats("cinematic",CinematicStats);
         this.registerUiStats("tutorial",TutorialStats);
         this.registerUiStats("banner",BannerStats);
         this.registerFrameStats(LoadingModuleFrame,LoadingModuleFrameStats);
         Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete,this.onUiLoaded);
         Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_STARTED,this.onUiUnloadStart);
         ModuleLogger.active = true;
         ModuleLogger.addCallback(this.log);
         Kernel.getWorker().addEventListener(FramePushedEvent.EVENT_FRAME_PUSHED,this.onFramePushed);
         Kernel.getWorker().addEventListener(FramePulledEvent.EVENT_FRAME_PULLED,this.onFramePulled);
      }
      
      public function get frame() : StatisticsFrame
      {
         return this._frame;
      }
      
      public function saveActionTimestamp(param1:uint, param2:Number) : void
      {
         StoreDataManager.getInstance().setData(this._dataStoreType,this.getActionDataId(param1),param2);
      }
      
      public function getActionTimestamp(param1:uint) : Number
      {
         var _loc2_:* = StoreDataManager.getInstance().getData(this._dataStoreType,this.getActionDataId(param1));
         return _loc2_ is Number && !isNaN(_loc2_)?_loc2_ as Number:NaN;
      }
      
      public function deleteTimeStamp(param1:uint) : void
      {
         this.saveActionTimestamp(param1,NaN);
      }
      
      private function getActionDataId(param1:uint) : String
      {
         var _loc4_:String = null;
         var _loc2_:String = PlayedCharacterManager.getInstance().infos?PlayedCharacterManager.getInstance().infos.name:null;
         var _loc3_:String = PlayerManager.getInstance().nickname;
         if(_loc2_)
         {
            _loc4_ = _loc2_;
         }
         else if(_loc3_)
         {
            _loc4_ = _loc3_;
         }
         
         var _loc5_:String = param1.toString();
         var _loc6_:String = _loc4_?_loc4_ + "#" + _loc5_:_loc5_;
         return _loc6_;
      }
      
      private function log(... rest) : void
      {
         var _loc2_:IUiStats = null;
         if(this._statsEnabled)
         {
            if(rest[0] is Message)
            {
               for each(_loc2_ in this._uisStats)
               {
                  _loc2_.process(rest[0] as Message);
               }
            }
            else if(rest[0] is Hook)
            {
               for each(_loc2_ in this._uisStats)
               {
                  _loc2_.onHook(rest[0] as Hook,rest[1]);
               }
            }
            
         }
      }
      
      private function registerUiStats(param1:String, param2:Class) : void
      {
         this._uisStatsAssoc[param1] = param2;
      }
      
      private function registerFrameStats(param1:Class, param2:Class) : void
      {
         this._framesStatsAssoc[param1] = param2;
      }
      
      private function initDataStoreType() : void
      {
         var _loc1_:* = "statistics";
         if(!this._dataStoreType || !(this._dataStoreType.category == _loc1_))
         {
            this._dataStoreType = new DataStoreType(_loc1_,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
         }
      }
      
      private function onUiLoaded(param1:UiRenderEvent) : void
      {
         var _loc2_:Class = this._uisStatsAssoc[param1.uiTarget.name];
         if(_loc2_)
         {
            this._uisStats[param1.uiTarget.name] = new _loc2_(param1.uiTarget);
         }
      }
      
      private function onUiUnloadStart(param1:UiUnloadEvent) : void
      {
         var _loc2_:IUiStats = this._uisStats[param1.name];
         if(_loc2_)
         {
            _loc2_.remove();
         }
         delete this._uisStats[param1.name];
         true;
      }
      
      private function onFramePushed(param1:FramePushedEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:String = getQualifiedClassName(param1.frame).split("::")[1];
         for(_loc2_ in this._framesStatsAssoc)
         {
            if(param1.frame is _loc2_)
            {
               this._framesStats[_loc3_] = new this._framesStatsAssoc[_loc2_]();
               break;
            }
         }
      }
      
      private function onFramePulled(param1:FramePulledEvent) : void
      {
         var _loc2_:String = getQualifiedClassName(param1.frame).split("::")[1];
         var _loc3_:IStatsClass = this._framesStats[_loc2_];
         if(_loc3_)
         {
            _loc3_.remove();
         }
         delete this._framesStats[_loc2_];
         true;
      }
   }
}
