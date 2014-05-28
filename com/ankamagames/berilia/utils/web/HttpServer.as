package com.ankamagames.berilia.utils.web
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.filesystem.File;
   import flash.utils.getDefinitionByName;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class HttpServer extends EventDispatcher
   {
      
      public function HttpServer() {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      private static var _self:HttpServer;
      
      private static const _log:Logger;
      
      public static function getInstance() : HttpServer {
         if(!_self)
         {
            _self = new HttpServer();
         }
         return _self;
      }
      
      private var _server:Object;
      
      private var _sockets:Array;
      
      private var _usedPort:uint;
      
      private var _rootPath:String;
      
      public function get rootPath() : String {
         return this._rootPath;
      }
      
      public function init(rootPath:File) : Boolean {
         this._rootPath = rootPath.nativePath;
         if(this._usedPort)
         {
            return true;
         }
         this._sockets = new Array();
         this._server = new (getDefinitionByName("flash.net.ServerSocket") as Class)();
         this._server.addEventListener(Event.CONNECT,this.onConnect);
         var tryCount:uint = 100;
         var currentPort:uint = 1100;
         while(tryCount)
         {
            try
            {
               this._server.bind(currentPort,"127.0.0.1");
               this._server.listen();
               this._usedPort = currentPort;
               _log.warn("Listening on port " + currentPort + "...\n");
               return true;
            }
            catch(e:Error)
            {
               currentPort++;
               tryCount--;
               continue;
            }
         }
         return false;
      }
      
      public function getUrlTo(target:String) : String {
         var target:String = StringUtils.convertLatinToUtf(target);
         return "http://localhost:" + this._usedPort + "/" + target;
      }
      
      public function close() : void {
         var httpSocket:HttpSocket = null;
         for each(httpSocket in this._sockets)
         {
            httpSocket.tearDown();
         }
         if((!(this._server == null)) && (this._server.bound))
         {
            this._server.removeEventListener(Event.CONNECT,this.onConnect);
            this._server.close();
            trace("Server closed");
            _log.warn("Server closed");
         }
      }
      
      private function onConnect(event:Event) : void {
         var htppSocket:HttpSocket = new HttpSocket(Object(event).socket,this._rootPath);
         htppSocket.addEventListener(Event.COMPLETE,this.onHttpSocketComplete);
         this._sockets.push(htppSocket);
      }
      
      private function onHttpSocketComplete(e:Event) : void {
         var httpSocketToRemove:HttpSocket = e.target as HttpSocket;
         this._sockets.splice(this._sockets.indexOf(httpSocketToRemove),1);
      }
   }
}
