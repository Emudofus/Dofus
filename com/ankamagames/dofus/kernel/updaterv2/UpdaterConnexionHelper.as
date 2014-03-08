package com.ankamagames.dofus.kernel.updaterv2
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.net.Socket;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterOutputMessage;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;
   import flash.events.Event;
   import com.ankamagames.dofus.misc.utils.StatisticReportingManager;
   import com.ankamagames.dofus.BuildInfos;
   import flash.events.IOErrorEvent;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import flash.events.ProgressEvent;
   import flash.errors.IOError;
   import com.ankamagames.jerakine.json.JSONDecoder;
   import com.ankamagames.dofus.kernel.updaterv2.messages.UpdaterMessageFactory;
   
   public class UpdaterConnexionHelper extends Object
   {
      
      public function UpdaterConnexionHelper(param1:Boolean=true) {
         super();
         this._buffer = new Vector.<IUpdaterOutputMessage>();
         this._socket = new Socket();
         this._port = CommandLineArguments.getInstance().hasArgument("update-server-port")?parseInt(CommandLineArguments.getInstance().getArgument("update-server-port")):4242;
         this._handlers = new Vector.<IUpdaterMessageHandler>();
         this.setEventListeners();
         if(param1)
         {
            this.connect();
         }
      }
      
      private static const logger:Logger = Log.getLogger(getQualifiedClassName(UpdaterConnexionHelper));
      
      private static const LOCALHOST:String = "127.0.0.1";
      
      private var _socket:Socket;
      
      private var _port:int;
      
      private var _handlers:Vector.<IUpdaterMessageHandler>;
      
      private var _buffer:Vector.<IUpdaterOutputMessage>;
      
      public function addObserver(param1:IUpdaterMessageHandler) : void {
         this._handlers.push(param1);
      }
      
      public function removeObserver(param1:IUpdaterMessageHandler) : void {
         this._handlers.slice(this._handlers.indexOf(param1),1);
      }
      
      public function removeObservers() : void {
         this._handlers.splice(0,this._handlers.length);
      }
      
      public function connect() : void {
         if(AirScanner.isStreamingVersion())
         {
            return;
         }
         if(!this._socket.connected)
         {
            this._socket.connect(LOCALHOST,this._port);
         }
      }
      
      public function close() : void {
         if((this._socket) && (this._socket.connected))
         {
            this._socket.close();
         }
      }
      
      public function sendMessage(param1:IUpdaterOutputMessage) : Boolean {
         var msg:IUpdaterOutputMessage = param1;
         try
         {
            if(!this._socket.connected)
            {
               this._buffer.push(msg);
               return false;
            }
            this._socket.writeUTFBytes(msg.serialize());
            this._socket.flush();
         }
         catch(e:Error)
         {
            logger.error("Sending updater message failed (reason : [" + e.errorID + "] " + e.message + ")");
            return false;
         }
         return true;
      }
      
      private function dispatchConnected() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this._handlers.length)
         {
            this._handlers[_loc1_].handleConnectionOpened();
            _loc1_++;
         }
      }
      
      private function dispatchRagquit() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this._handlers.length)
         {
            this._handlers[_loc1_].handleConnectionClosed();
            _loc1_++;
         }
      }
      
      private function dispatchMessage(param1:IUpdaterInputMessage) : void {
         var _loc2_:* = 0;
         while(_loc2_ < this._handlers.length)
         {
            this._handlers[_loc2_].handleMessage(param1);
            _loc2_++;
         }
      }
      
      private function onConnectionOpened(param1:Event) : void {
         logger.info("Connected to the updater on port : " + this._port);
         this._socket.removeEventListener(Event.CONNECT,this.onConnectionOpened);
         StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION,"success");
         this.dispatchConnected();
         var _loc2_:* = 0;
         while(_loc2_ < this._buffer.length)
         {
            this.sendMessage(this._buffer.shift());
            _loc2_++;
         }
      }
      
      private function onConnectionClosed(param1:Event) : void {
         logger.info("Updater connection has been closed");
         this.removeEventListeners();
         this.dispatchRagquit();
      }
      
      private function onIOError(param1:IOErrorEvent) : void {
         logger.error("Error : [" + param1.errorID + "] " + param1.text);
         if(CommandLineArguments.getInstance().hasArgument("update-server-port"))
         {
            StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION,"failed [" + param1.text + "]");
         }
         else
         {
            StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION,"noupdater [" + param1.text + "]");
         }
      }
      
      private function onSocketData(param1:ProgressEvent) : void {
         var content:String = null;
         var messages:Vector.<String> = null;
         var i:int = 0;
         var contentJSON:Object = null;
         var message:IUpdaterInputMessage = null;
         var event:ProgressEvent = param1;
         try
         {
            content = this._socket.readUTFBytes(this._socket.bytesAvailable);
            messages = this.splitPacket(content);
            i = 0;
            while(i < messages.length)
            {
               try
               {
                  contentJSON = new JSONDecoder(messages[i],false).getValue();
                  message = UpdaterMessageFactory.getUpdaterMessage(contentJSON);
                  if(this._handlers.length == 0)
                  {
                     logger.error("No handler to process Updater input message : " + content);
                  }
                  else
                  {
                     this.dispatchMessage(message);
                  }
               }
               catch(e:Error)
               {
                  logger.error("Malformed updater packet : " + messages[i] + " [" + e.errorID + " " + e.message + "]");
               }
               i++;
            }
         }
         catch(ioe:IOError)
         {
            logger.error("Error during reading packet : [" + ioe.errorID + " " + ioe.message + "]");
         }
      }
      
      private function splitPacket(param1:String) : Vector.<String> {
         var _loc6_:String = null;
         var _loc2_:* = 0;
         var _loc3_:* = "";
         var _loc4_:Vector.<String> = new Vector.<String>();
         var _loc5_:* = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = param1.charAt(_loc5_);
            if(_loc6_ == "{")
            {
               _loc2_++;
            }
            else
            {
               if(_loc6_ == "}")
               {
                  _loc2_--;
               }
            }
            _loc3_ = _loc3_ + _loc6_;
            if(_loc2_ == 0)
            {
               if(_loc3_ != "\n")
               {
                  _loc4_.push(_loc3_);
               }
               _loc3_ = "";
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      protected function setEventListeners() : void {
         if(this._socket)
         {
            this._socket.addEventListener(Event.CONNECT,this.onConnectionOpened);
            this._socket.addEventListener(Event.CLOSE,this.onConnectionClosed);
            this._socket.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
         }
      }
      
      protected function removeEventListeners() : void {
         if(this._socket)
         {
            this._socket.removeEventListener(Event.CONNECT,this.onConnectionOpened);
            this._socket.removeEventListener(Event.CLOSE,this.onConnectionClosed);
            this._socket.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this._socket.removeEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
         }
      }
   }
}
