package com.ankamagames.berilia.utils.web
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class HttpServer extends EventDispatcher
    {
        private var _server:Object;
        private var _sockets:Array;
        private var _usedPort:uint;
        private var _rootPath:String;
        private static var _self:HttpServer;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(HttpServer));

        public function HttpServer()
        {
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function get rootPath() : String
        {
            return this._rootPath;
        }// end function

        public function init(param1:File) : Boolean
        {
            var rootPath:* = param1;
            this._rootPath = rootPath.nativePath;
            if (this._usedPort)
            {
                return true;
            }
            this._sockets = new Array();
            this._server = new (getDefinitionByName("flash.net.ServerSocket") as Class)();
            this._server.addEventListener(Event.CONNECT, this.onConnect);
            var tryCount:uint;
            var currentPort:uint;
            do
            {
                
                try
                {
                    this._server.bind(currentPort, "127.0.0.1");
                    this._server.listen();
                    this._usedPort = currentPort;
                    _log.fatal("Listening on port " + currentPort + "...\n");
                    return true;
                }
                catch (e:Error)
                {
                    currentPort = (currentPort + 1);
                    tryCount = (tryCount - 1);
                }
            }while (tryCount)
            return false;
        }// end function

        public function getUrlTo(param1:String) : String
        {
            _log.fatal("getting url to : http://localhost:" + this._usedPort + "/" + param1);
            return "http://localhost:" + this._usedPort + "/" + param1;
        }// end function

        public function close() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._sockets)
            {
                
                _loc_1.tearDown();
            }
            if (this._server != null && this._server.bound)
            {
                this._server.removeEventListener(Event.CONNECT, this.onConnect);
                this._server.close();
                trace("Server closed");
                _log.warn("Server closed");
            }
            return;
        }// end function

        private function onConnect(event:Event) : void
        {
            var _loc_2:* = new HttpSocket(Object(event).socket, this._rootPath);
            _loc_2.addEventListener(Event.COMPLETE, this.onHttpSocketComplete);
            this._sockets.push(_loc_2);
            return;
        }// end function

        private function onHttpSocketComplete(event:Event) : void
        {
            var _loc_2:* = event.target as HttpSocket;
            this._sockets.splice(this._sockets.indexOf(_loc_2), 1);
            return;
        }// end function

        public static function getInstance() : HttpServer
        {
            if (!_self)
            {
                _self = new HttpServer;
            }
            return _self;
        }// end function

    }
}
