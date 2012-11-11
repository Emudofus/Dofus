package com.ankamagames.berilia.utils.web
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class HttpSocket extends EventDispatcher
    {
        private var requestSocket:Socket;
        private var requestBuffer:ByteArray;
        private var _rootPath:String;
        private static const SEPERATOR:RegExp = new RegExp(/\r?\
n\r?\
n""\r?\n\r?\n/);
        private static const NL:RegExp = new RegExp(/\r?\
n""\r?\n/);

        public function HttpSocket(param1:Socket, param2:String)
        {
            this.requestSocket = param1;
            this.requestBuffer = new ByteArray();
            this.requestSocket.addEventListener(ProgressEvent.SOCKET_DATA, this.onRequestSocketData);
            this.requestSocket.addEventListener(Event.CLOSE, this.onRequestSocketClose);
            this._rootPath = param2;
            return;
        }// end function

        public function get rootPath() : String
        {
            return this._rootPath;
        }// end function

        private function onRequestSocketData(event:ProgressEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this.requestSocket.readBytes(this.requestBuffer, this.requestBuffer.length, this.requestSocket.bytesAvailable);
            var _loc_2:* = this.requestBuffer.toString();
            var _loc_3:* = _loc_2.search(SEPERATOR);
            if (_loc_3 != -1)
            {
                _loc_4 = _loc_2.substring(0, _loc_3);
                _loc_5 = _loc_4.substring(0, _loc_4.search(NL));
                _loc_6 = _loc_5.split(" ");
                _loc_7 = _loc_6[0];
                _loc_8 = _loc_6[1];
                _loc_8 = _loc_8.replace(/^http(s)?:\/\/""^http(s)?:\/\//, "");
                _loc_9 = _loc_8.replace(/^http(s)?:\/\/""^http(s)?:\/\//, "").substring(_loc_8.indexOf("/"), _loc_8.length);
                _loc_10 = new HttpResponder(this.requestSocket, _loc_7, _loc_9, this._rootPath);
            }
            return;
        }// end function

        private function onRequestSocketClose(event:Event) : void
        {
            this.done();
            return;
        }// end function

        private function done() : void
        {
            this.tearDown();
            var _loc_1:* = new Event(Event.COMPLETE);
            this.dispatchEvent(_loc_1);
            return;
        }// end function

        private function testSocket(param1:Socket) : Boolean
        {
            if (!param1.connected)
            {
                this.done();
                return false;
            }
            return true;
        }// end function

        public function tearDown() : void
        {
            if (this.requestSocket != null && this.requestSocket.connected)
            {
                this.requestSocket.flush();
                this.requestSocket.close();
            }
            return;
        }// end function

    }
}
