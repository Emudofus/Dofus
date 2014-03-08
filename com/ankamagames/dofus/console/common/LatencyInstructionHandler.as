package com.ankamagames.dofus.console.common
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.logic.common.frames.LatencyFrame;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   import com.ankamagames.jerakine.network.IServerConnection;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.data.I18n;
   
   public class LatencyInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function LatencyInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:LatencyFrame = null;
         var _loc5_:BasicPingMessage = null;
         var _loc6_:IServerConnection = null;
         switch(param2)
         {
            case "ping":
               _loc4_ = Kernel.getWorker().getFrame(LatencyFrame) as LatencyFrame;
               if(_loc4_.pingRequested != 0)
               {
                  break;
               }
               _loc5_ = new BasicPingMessage().initBasicPingMessage();
               ConnectionsHandler.getConnection().send(_loc5_);
               _loc4_.pingRequested = getTimer();
               param1.output("Ping...");
               break;
            case "aping":
               _loc6_ = ConnectionsHandler.getConnection().mainConnection;
               param1.output("Avg ping : " + _loc6_.latencyAvg + "ms for the last " + _loc6_.latencySamplesCount + " packets (max : " + _loc6_.latencySamplesMax + ")");
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "ping":
               return I18n.getUiText("ui.chat.console.help.ping");
            case "aping":
               return I18n.getUiText("ui.chat.console.help.aping");
            default:
               return I18n.getUiText("ui.chat.console.noHelp",[param1]);
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
