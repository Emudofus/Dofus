package com.ankamagames.dofus.kernel.updaterv2
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.net.Socket;
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
   import __AS3__.vec.*;
   
   public class UpdaterConnexionHelper extends Object
   {
      
      public function UpdaterConnexionHelper(autoConnect:Boolean=true) {
         super();
         this._buffer = new Vector.<IUpdaterOutputMessage>();
         this._socket = new Socket();
         this._port = CommandLineArguments.getInstance().hasArgument("update-server-port")?parseInt(CommandLineArguments.getInstance().getArgument("update-server-port")):4242;
         this._handlers = new Vector.<IUpdaterMessageHandler>();
         this.setEventListeners();
         if(autoConnect)
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
      
      public function addObserver(handler:IUpdaterMessageHandler) : void {
         this._handlers.push(handler);
      }
      
      public function removeObserver(handler:IUpdaterMessageHandler) : void {
         this._handlers.slice(this._handlers.indexOf(handler),1);
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
      
      public function sendMessage(msg:IUpdaterOutputMessage) : Boolean {
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
         var i:int = 0;
         while(i < this._handlers.length)
         {
            this._handlers[i].handleConnectionOpened();
            i++;
         }
      }
      
      private function dispatchRagquit() : void {
         var i:int = 0;
         while(i < this._handlers.length)
         {
            this._handlers[i].handleConnectionClosed();
            i++;
         }
      }
      
      private function dispatchMessage(msg:IUpdaterInputMessage) : void {
         var i:int = 0;
         while(i < this._handlers.length)
         {
            this._handlers[i].handleMessage(msg);
            i++;
         }
      }
      
      private function onConnectionOpened(event:Event) : void {
         logger.info("Connected to the updater on port : " + this._port);
         this._socket.removeEventListener(Event.CONNECT,this.onConnectionOpened);
         StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION,"success");
         this.dispatchConnected();
         var i:int = 0;
         while(i < this._buffer.length)
         {
            this.sendMessage(this._buffer.shift());
            i++;
         }
      }
      
      private function onConnectionClosed(event:Event) : void {
         logger.info("Updater connection has been closed");
         this.removeEventListeners();
         this.dispatchRagquit();
      }
      
      private function onIOError(event:IOErrorEvent) : void {
         logger.error("Error : [" + event.errorID + "] " + event.text);
         if(CommandLineArguments.getInstance().hasArgument("update-server-port"))
         {
            StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION,"failed [" + event.text + "]");
         }
         else
         {
            StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION,"noupdater [" + event.text + "]");
         }
      }
      
      private function onSocketData(event:ProgressEvent) : void {
         var content:String = null;
         var messages:Vector.<String> = null;
         var i:int = 0;
         var contentJSON:Object = null;
         var message:IUpdaterInputMessage = null;
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
      
      private function splitPacket(raw:String) : Vector.<String> {
         var c:String = null;
         var depth:int = 0;
         var message:String = "";
         var messages:Vector.<String> = new Vector.<String>();
         var i:int = 0;
         while(i < raw.length)
         {
            c = raw.charAt(i);
            if(c == "{")
            {
               depth++;
            }
            else
            {
               if(c == "}")
               {
                  depth--;
               }
            }
            message = message + c;
            if(depth == 0)
            {
               if(message != "\n")
               {
                  messages.push(message);
               }
               message = "";
            }
            i++;
         }
         return messages;
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
