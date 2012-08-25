package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.json.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class RpcServiceManager extends EventDispatcher
    {
        private var _loader:URLLoader;
        private var _request:URLRequest;
        private var _service:String;
        private var _params:Object;
        private var _result:Object;
        private var _type:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RpcServiceManager));
        public static const SERVER_ERROR:String = "InternalServerError";

        public function RpcServiceManager(param1:String = "", param2:String = "")
        {
            if (param1 != "")
            {
                this.service = param1;
            }
            if (param2 != "")
            {
                this.type = param2;
            }
            return;
        }// end function

        private function onComplete(event:Event) : void
        {
            this._loader.removeEventListener(Event.COMPLETE, this.onComplete);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            var _loc_2:Boolean = true;
            if (this._type == "json")
            {
                _loc_2 = this.formateJsonResult(event.currentTarget.data);
            }
            else
            {
                _loc_2 = false;
            }
            if (_loc_2)
            {
                dispatchEvent(event);
            }
            else
            {
                dispatchEvent(new Event(SERVER_ERROR));
            }
            return;
        }// end function

        private function formateJsonResult(param1:String) : Boolean
        {
            var de:Object;
            var data:* = param1;
            try
            {
                de = JSON.decode(data);
            }
            catch (e:Error)
            {
                _log.error("Can\'t decode string, JSON required !!");
                return false;
            }
            if (de == null)
            {
                _log.error("No information received from the server ...");
                return false;
            }
            if (de.error != null)
            {
                switch(typeof(de.error))
                {
                    case "string":
                    case "number":
                    {
                        _log.error("ERROR RPC SERVICE: " + de.error + (de.type != null ? (", " + de.type) : ("")) + (de.message != null ? (", " + de.message) : ("")));
                        break;
                    }
                    case "object":
                    {
                        _log.error((de.error.type != null ? (de.error.type) : (de.error.code)) + " -> " + de.error.message);
                        break;
                    }
                    default:
                    {
                        _log.error("ERROR RPS SERVICE: " + de.error);
                        break;
                    }
                }
                return false;
            }
            this._result = de.result;
            return !(this._result.success != null && this._result.success == false);
        }// end function

        private function createRpcObject(param1:String) : Object
        {
            var _loc_2:* = new Object();
            switch(this._type)
            {
                case "json":
                {
                    _loc_2.method = param1;
                    _loc_2.params = this._params;
                    _loc_2.id = 1;
                    break;
                }
                case "xml":
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function destroy() : void
        {
            if (this._loader.hasEventListener(Event.COMPLETE))
            {
                this._loader.removeEventListener(Event.COMPLETE, this.onComplete);
            }
            if (this._loader.hasEventListener(IOErrorEvent.IO_ERROR))
            {
                this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            }
            this._loader = null;
            this._request = null;
            return;
        }// end function

        public function getAllResultData() : Object
        {
            return this._result;
        }// end function

        public function getResultData(param1:String)
        {
            if (this._result == null)
            {
                return null;
            }
            return this._result[param1];
        }// end function

        public function callMethod(param1:String, param2) : void
        {
            var _loc_3:Object = null;
            this._params = param2;
            if (this._request == null || this._loader == null)
            {
                throw new Error("there is no data to handle ...");
            }
            _loc_3 = this.createRpcObject(param1);
            switch(this._type)
            {
                case "json":
                {
                    this._request.data = JSON.encode(_loc_3);
                    break;
                }
                case "xml":
                {
                    throw new Error("Not implemented yet");
                }
                default:
                {
                    break;
                }
            }
            this._request.method = URLRequestMethod.POST;
            this._loader.load(this._request);
            return;
        }// end function

        public function set type(param1:String) : void
        {
            param1 = param1.toLowerCase();
            switch(param1)
            {
                case "json":
                case "jsonrpc":
                {
                    this._type = "json";
                    break;
                }
                case "xmlrpc":
                case "xml":
                {
                }
                default:
                {
                    this._type = "xml";
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function set service(param1:String) : void
        {
            this._service = param1;
            this._request = new URLRequest(param1);
            this._loader = new URLLoader();
            this._loader.addEventListener(Event.COMPLETE, this.onComplete);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            return;
        }// end function

        private function onError(event:Event) : void
        {
            this._loader.removeEventListener(Event.COMPLETE, this.onComplete);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            dispatchEvent(event);
            return;
        }// end function

    }
}
