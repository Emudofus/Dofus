package com.ankamagames.jerakine.utils.files
{
    import com.ankamagames.jerakine.cache.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import nochump.util.zip.*;

    public class ZipLoader extends EventDispatcher implements ICachable
    {
        private var _zipFile:ZipFile;
        private var _files:Array;
        private var _filesNames:Array;
        private var _oExtraData:Object;
        private var _inUse:Boolean;
        private var _name:String;
        private var _loader:URLLoader;
        public var url:String;
        public var loaded:Boolean;

        public function ZipLoader(param1:URLRequest = null, param2 = null)
        {
            if (param1)
            {
                this._name = "ZIP_" + param1.url;
            }
            this._oExtraData = param2;
            if (param1 != null)
            {
                this.load(param1);
            }
            return;
        }// end function

        public function get inUse() : Boolean
        {
            return this._inUse;
        }// end function

        public function set inUse(param1:Boolean) : void
        {
            this._inUse = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get extraData()
        {
            return this._oExtraData;
        }// end function

        public function load(param1:URLRequest) : void
        {
            this.loaded = false;
            this._files = new Array();
            this._filesNames = new Array();
            this._name = "ZIP_" + param1.url;
            this._zipFile = null;
            this._loader = new URLLoader();
            this._loader.dataFormat = URLLoaderDataFormat.BINARY;
            this._loader.addEventListener(Event.COMPLETE, this.onLoadComplete);
            this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.onHttpStatus);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this._loader.addEventListener(Event.OPEN, this.onOpen);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._loader.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this._loader.load(param1);
            this.url = param1.url;
            return;
        }// end function

        public function getFilesList() : Array
        {
            return this._filesNames;
        }// end function

        public function getFileDatas(param1:String) : ByteArray
        {
            return this._zipFile.getInput(this._files[param1]);
        }// end function

        public function fileExists(param1:String) : Boolean
        {
            var _loc_2:uint = 0;
            while (_loc_2 < this._filesNames.length)
            {
                
                if (this._filesNames[_loc_2] == param1)
                {
                    return true;
                }
                _loc_2 = _loc_2 + 1;
            }
            return false;
        }// end function

        public function destroy() : void
        {
            try
            {
                if (this._loader)
                {
                    this._loader.close();
                }
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function onLoadComplete(event:Event) : void
        {
            var _loc_4:ZipEntry = null;
            var _loc_2:* = ByteArray(URLLoader(event.target).data);
            this._zipFile = new ZipFile(_loc_2);
            var _loc_3:uint = 0;
            while (_loc_3 < this._zipFile.entries.length)
            {
                
                _loc_4 = this._zipFile.entries[_loc_3];
                this._files[_loc_4.name] = _loc_4;
                this._filesNames.push(_loc_4.name);
                _loc_3 = _loc_3 + 1;
            }
            dispatchEvent(event);
            return;
        }// end function

        private function onHttpStatus(event:HTTPStatusEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function onIOError(event:IOErrorEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function onOpen(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function onSecurityError(event:SecurityErrorEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function onProgress(event:ProgressEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

    }
}
