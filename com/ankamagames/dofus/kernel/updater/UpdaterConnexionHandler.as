package com.ankamagames.dofus.kernel.updater
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.network.ServerConnection;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.events.Event;
   import com.ankamagames.dofus.misc.utils.StatisticReportingManager;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.logic.game.approach.managers.PartManager;
   import flash.events.IOErrorEvent;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.MessageReceiver;
   import com.ankamagames.dofus.logic.game.approach.frames.UpdaterDialogFrame;
   
   public class UpdaterConnexionHandler extends Object
   {
      
      public function UpdaterConnexionHandler() {
         super();
         if(!_self)
         {
            _currentConnection = new ServerConnection();
            _currentConnection.addEventListener(IOErrorEvent.IO_ERROR,this.onIoError);
            _currentConnection.addEventListener(Event.CONNECT,this.onConnect);
            if(AirScanner.isStreamingVersion())
            {
               return;
            }
            _currentConnection.handler = Kernel.getWorker();
            _currentConnection.rawParser = new MessageReceiver();
            Kernel.getWorker().addFrame(new UpdaterDialogFrame());
            if(CommandLineArguments.getInstance().hasArgument("update-server-port"))
            {
               _log.debug("Using port " + CommandLineArguments.getInstance().getArgument("update-server-port") + " send by server");
               _currentConnection.connect("localhost",int(CommandLineArguments.getInstance().getArgument("update-server-port")));
            }
            else
            {
               if(!AirScanner.isStreamingVersion())
               {
                  _currentConnection.connect("localhost",4242);
               }
            }
            return;
         }
         throw new Error("La classe UpdaterConnexionHandler est un singleton");
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UpdaterConnexionHandler));
      
      private static var _self:UpdaterConnexionHandler;
      
      private static var _currentConnection:ServerConnection;
      
      public static function getInstance() : UpdaterConnexionHandler {
         if(!_self)
         {
            _self = new UpdaterConnexionHandler();
         }
         return _self;
      }
      
      public static function getConnection() : ServerConnection {
         return _currentConnection;
      }
      
      public function onConnect(param1:Event) : void {
         StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION,"success");
         PartManager.getInstance().initialize();
      }
      
      public function onIoError(param1:IOErrorEvent) : void {
         if(CommandLineArguments.getInstance().hasArgument("update-server-port"))
         {
            StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION,"failed");
         }
         else
         {
            StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION,"noupdater");
         }
         _log.error("Can\'t etablish connection with updater");
      }
   }
}
