package com.ankamagames.dofus.misc.stats.frames
{
   import com.ankamagames.dofus.misc.stats.IStatsClass;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
   
   public class LoadingModuleFrameStats extends Object implements IStatsClass
   {
      
      public function LoadingModuleFrameStats()
      {
         super();
         this._action = StatsAction.get(StatisticTypeEnum.STEP0300_LOADING_SCREEN);
         this._action.start();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(LoadingModuleFrameStats));
      
      private var _action:StatsAction;
      
      public function process(param1:Message) : void
      {
      }
      
      public function remove() : void
      {
         this._action.send();
      }
   }
}
