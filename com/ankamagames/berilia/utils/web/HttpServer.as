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
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(HttpServer));
      
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
      
      public function init(param1:File) : Boolean {
         var rootPath:File = param1;
         this._rootPath = rootPath.nativePath;
         if(this._usedPort)
         {
            return true;
         }
         this._sockets = new Array();
         this._server = new getDefinitionByName("flash.net.ServerSocket") as Class();
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
      
      public function getUrlTo(param1:String) : String {
         var param1:String = StringUtils.convertLatinToUtf(param1);
         return "http://localhost:" + this._usedPort + "/" + param1;
      }
      
      public function close() : void {
         var _loc1_:HttpSocket = null;
         for each (_loc1_ in this._sockets)
         {
            _loc1_.tearDown();
         }
         if(!(this._server == null) && (this._server.bound))
         {
            this._server.removeEventListener(Event.CONNECT,this.onConnect);
            this._server.close();
            trace("Server closed");
            _log.warn("Server closed");
         }
      }
      
      private function onConnect(param1:Event) : void {
         var _loc2_:HttpSocket = new HttpSocket(Object(param1).socket,this._rootPath);
         _loc2_.addEventListener(Event.COMPLETE,this.onHttpSocketComplete);
         this._sockets.push(_loc2_);
      }
      
      private function onHttpSocketComplete(param1:Event) : void {
         var _loc2_:HttpSocket = param1.target as HttpSocket;
         this._sockets.splice(this._sockets.indexOf(_loc2_),1);
      }
   }
}
