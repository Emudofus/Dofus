package com.ankamagames.berilia.managers
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.resources.adapters.impl.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.files.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.utils.*;

    public class HttpServer extends Object
    {
        private var l:Loader;
        private var serverSocket:Object;
        private var _usedPort:uint;
        private var _contentFolder:File;
        private static var _self:HttpServer;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(HttpServer));

        public function HttpServer()
        {
            this.l = new Loader();
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function init(param1:File) : Boolean
        {
            var contentFolder:* = param1;
            this._contentFolder = contentFolder;
            if (this._usedPort)
            {
                return true;
            }
            var tryCount:uint;
            var currentPort:uint;
            do
            {
                
                try
                {
                    this.serverSocket = new (getDefinitionByName("flash.net.ServerSocket") as Class)();
                    this.serverSocket.addEventListener(Event.CONNECT, this.socketConnectHandler);
                    this.serverSocket.bind(currentPort, "127.0.0.1");
                    this.serverSocket.listen();
                    this._usedPort = currentPort;
                    trace("Listening on port " + currentPort + "...\n");
                    return true;
                }
                catch (error:Error)
                {
                    currentPort = (currentPort + 1);
                    tryCount = (tryCount - 1);
                }
            }while (tryCount)
            return false;
        }// end function

        public function close() : void
        {
            try
            {
                if (this.serverSocket)
                {
                    this.serverSocket.close();
                }
            }
            catch (e:Error)
            {
                _log.fatal(e.getStackTrace());
            }
            return;
        }// end function

        public function getUrlTo(param1:String) : String
        {
            return "http://localhost:" + this._usedPort + "/" + param1;
        }// end function

        private function socketConnectHandler(event:Event) : void
        {
            var _loc_2:* = Object(event).socket;
            _loc_2.addEventListener(ProgressEvent.SOCKET_DATA, this.socketDataHandler);
            return;
        }// end function

        private function socketDataHandler(event:ProgressEvent) : void
        {
            var socket:Socket;
            var bytes:ByteArray;
            var request:String;
            var filePath:String;
            var len:uint;
            var file:File;
            var ext:String;
            var stream:FileStream;
            var content:ByteArray;
            var ok:Boolean;
            var sig:Signature;
            var input:ByteArray;
            var directoryContent:Array;
            var dBuffer:String;
            var dFile:File;
            var event:* = event;
            try
            {
                socket = event.target as Socket;
                bytes = new ByteArray();
                socket.readBytes(bytes);
                request = "" + bytes;
                filePath = unescape(request.substring(5, (request.indexOf("HTTP/") - 1)));
                do
                {
                    
                    len = filePath.length;
                    filePath = filePath.replace("..", ".");
                }while (filePath.length != len)
                filePath = filePath.replace(":", "");
                file = new File(this._contentFolder.nativePath + File.separator + filePath);
                ext = FileUtils.getExtension(file.nativePath);
                if (file.exists && !file.isDirectory && (ext == "swf" || ext == "swfs" || ext == "mp3"))
                {
                    stream = new FileStream();
                    stream.open(file, FileMode.READ);
                    content = new ByteArray();
                    stream.readBytes(content);
                    stream.close();
                    ok;
                    if (ext == "swfs")
                    {
                        sig = new Signature(SignedFileAdapter.defaultSignatureKey);
                        input = new ByteArray();
                        content.readBytes(input);
                        content.clear();
                        if (!sig.verify(input, content))
                        {
                            _log.error("Erreur : " + file.url + " a une signature invalide");
                            socket.writeUTFBytes("HTTP/1.1 500 Internal Server Error\n");
                            socket.writeUTFBytes("Content-Type: text/html\n\n");
                            socket.writeUTFBytes("<html><body><h2>Invalid signature</h2></body></html>");
                            ok;
                        }
                    }
                    if (ok)
                    {
                        _log.info("Envois du fichier " + file.url + " en HTTP");
                        socket.writeUTFBytes("HTTP/1.1 200 OK\n");
                        socket.writeUTFBytes("Content-Type: application/x-shockwave-flash\n");
                        socket.writeUTFBytes("Content-Length: " + content.length + "\n\n");
                        socket.writeBytes(content);
                    }
                    socket.flush();
                }
                else if (file.isDirectory)
                {
                    socket.writeUTFBytes("HTTP/1.1 200 OK\n");
                    socket.writeUTFBytes("Content-Type: text/html\n\n");
                    directoryContent = file.getDirectoryListing();
                    dBuffer;
                    var _loc_3:int = 0;
                    var _loc_4:* = directoryContent;
                    while (_loc_4 in _loc_3)
                    {
                        
                        dFile = _loc_4[_loc_3];
                        dBuffer = dBuffer + (dFile.name + ":" + (dFile.isDirectory ? ("folder") : ("file")) + "\n");
                    }
                    socket.writeUTFBytes(dBuffer);
                    setTimeout(socket.flush, 100);
                }
                else
                {
                    _log.error("Erreur : " + file.url + " not found");
                    socket.writeUTFBytes("HTTP/1.1 404 Not Found\n\n");
                    socket.flush();
                }
            }
            catch (error:Error)
            {
                trace("Error");
            }
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
