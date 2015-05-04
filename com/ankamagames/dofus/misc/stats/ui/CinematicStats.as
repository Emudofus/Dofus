package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.components.VideoPlayer;
   import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
   
   public class CinematicStats extends Object implements IUiStats
   {
      
      public function CinematicStats(param1:UiRootContainer)
      {
         super();
         var _loc2_:String = (param1.getElement("vplayer") as VideoPlayer).flv;
         if(_loc2_.indexOf("10.flv") != -1)
         {
            this._action = StatsAction.get(StatisticTypeEnum.STEP0400_DOFUS_TRAILER);
            this._action.addParam("Skip_Trailer",false);
            this._action.start();
         }
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(CinematicStats));
      
      private var _action:StatsAction;
      
      public function process(param1:Message) : void
      {
         var _loc2_:MouseClickMessage = null;
         if(this._action)
         {
            switch(true)
            {
               case param1 is MouseClickMessage:
                  _loc2_ = param1 as MouseClickMessage;
                  if(_loc2_.target.name == "btn_skip")
                  {
                     this._action.addParam("Skip_Trailer",true);
                  }
                  break;
            }
         }
      }
      
      public function onHook(param1:Hook, param2:Array) : void
      {
      }
      
      public function remove() : void
      {
         if(this._action)
         {
            this._action.send();
         }
      }
   }
}
