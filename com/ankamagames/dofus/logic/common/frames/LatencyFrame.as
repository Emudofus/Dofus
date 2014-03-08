package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPongMessage;
   import com.ankamagames.jerakine.network.IServerConnection;
   import com.ankamagames.dofus.network.messages.game.basic.BasicLatencyStatsMessage;
   import flash.utils.getTimer;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.game.basic.BasicLatencyStatsRequestMessage;
   
   public class LatencyFrame extends Object implements Frame
   {
      
      public function LatencyFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LatencyFrame));
      
      public var pingRequested:uint;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:BasicPongMessage = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:IServerConnection = null;
         var _loc6_:BasicLatencyStatsMessage = null;
         switch(true)
         {
            case param1 is BasicPongMessage:
               _loc2_ = param1 as BasicPongMessage;
               if(_loc2_.quiet)
               {
                  return true;
               }
               _loc3_ = getTimer();
               _loc4_ = _loc3_ - this.pingRequested;
               this.pingRequested = 0;
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"Pong " + _loc4_ + "ms !",ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is BasicLatencyStatsRequestMessage:
               _loc5_ = ConnectionsHandler.getConnection().mainConnection;
               _loc6_ = new BasicLatencyStatsMessage();
               _loc6_.initBasicLatencyStatsMessage(Math.min(32767,_loc5_.latencyAvg),_loc5_.latencySamplesCount,_loc5_.latencySamplesMax);
               _loc5_.send(_loc6_);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
