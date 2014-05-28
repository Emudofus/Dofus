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
      
      protected static const _log:Logger;
      
      public var pingRequested:uint;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var bpmsg:BasicPongMessage = null;
         var pongReceived:uint = 0;
         var delay:uint = 0;
         var connection:IServerConnection = null;
         var blsmsg:BasicLatencyStatsMessage = null;
         switch(true)
         {
            case msg is BasicPongMessage:
               bpmsg = msg as BasicPongMessage;
               if(bpmsg.quiet)
               {
                  return true;
               }
               pongReceived = getTimer();
               delay = pongReceived - this.pingRequested;
               this.pingRequested = 0;
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"Pong " + delay + "ms !",ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is BasicLatencyStatsRequestMessage:
               connection = ConnectionsHandler.getConnection().mainConnection;
               blsmsg = new BasicLatencyStatsMessage();
               blsmsg.initBasicLatencyStatsMessage(Math.min(32767,connection.latencyAvg),connection.latencySamplesCount,connection.latencySamplesMax);
               connection.send(blsmsg);
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
