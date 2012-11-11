package com.ankamagames.jerakine.resources.protocols.impl
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class FileFlashProtocol extends AbstractFileProtocol
    {
        private var _openDict:Dictionary;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FileFlashProtocol));

        public function FileFlashProtocol()
        {
            this._openDict = new Dictionary();
            return;
        }// end function

        override public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
        {
            var file:File;
            var fs:FileStream;
            var uri:* = param1;
            var observer:* = param2;
            var dispatchProgress:* = param3;
            var cache:* = param4;
            var forcedAdapter:* = param5;
            var singleFile:* = param6;
            if (singleFile)
            {
                singleLoadingFile[uri] = observer;
                file = new File(uri.path);
                fs = new FileStream();
                fs.addEventListener(Event.COMPLETE, this.onOpenAsyncComplete);
                this._openDict[fs] = {uri:uri, observer:observer, adapter:forcedAdapter, dispatchProgress:dispatchProgress};
                try
                {
                    fs.openAsync(file, FileMode.READ);
                }
                catch (e:IOError)
                {
                    onFailed(uri, e.toString(), e.errorID);
                }
            }
            else if (loadingFile[getUrl(uri)])
            {
                loadingFile[getUrl(uri)].push(observer);
            }
            else
            {
                loadingFile[getUrl(uri)] = [observer];
                file = new File(uri.path);
                fs = new FileStream();
                fs.addEventListener(Event.COMPLETE, this.onOpenAsyncComplete);
                this._openDict[fs] = {uri:uri, observer:observer, adapter:forcedAdapter, dispatchProgress:dispatchProgress};
                try
                {
                    fs.openAsync(file, FileMode.READ);
                }
                catch (e:IOError)
                {
                    trace(e.message);
                    onFailed(uri, e.toString(), e.errorID);
                }
            }
            return;
        }// end function

        private function onOpenAsyncComplete(event:Event) : void
        {
            var _loc_2:* = event.target as FileStream;
            var _loc_3:* = new ByteArray();
            _loc_2.position = 0;
            _loc_2.readBytes(_loc_3);
            _loc_2.close();
            _loc_2.removeEventListener(Event.COMPLETE, this.onOpenAsyncComplete);
            var _loc_4:* = this._openDict[_loc_2];
            getAdapter(_loc_4.uri, _loc_4.adapter);
            _adapter.loadFromData(_loc_4.uri, _loc_3, new ResourceObserverWrapper(this.onLoaded, this.onFailed, this.onProgress), _loc_4.dispatchProgress);
            delete this._openDict[_loc_2];
            return;
        }// end function

        override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
        {
            var uri:* = param1;
            var observer:* = param2;
            var dispatchProgress:* = param3;
            var forcedAdapter:* = param4;
            var file:* = new File(uri.path);
            var fs:* = new FileStream();
            try
            {
                fs.open(file, FileMode.READ);
            }
            catch (e:IOError)
            {
                onFailed(uri, e.toString(), e.errorID);
                return;
            }
            var ba:* = new ByteArray();
            fs.readBytes(ba);
            fs.close();
            getAdapter(uri, forcedAdapter);
            _adapter.loadFromData(uri, ba, observer, dispatchProgress);
            return;
        }// end function

        override protected function extractPath(param1:String) : String
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1.indexOf("..") != -1)
            {
                if (param1.indexOf("./") == 0)
                {
                    _loc_2 = File.applicationDirectory.nativePath + File.separator + param1;
                }
                else if (param1.indexOf("/./") != -1)
                {
                    _loc_2 = File.applicationDirectory.nativePath + File.separator + param1.substr(param1.indexOf("/./") + 3);
                }
                else
                {
                    _loc_2 = param1;
                }
                _loc_3 = new File(_loc_2);
                param1 = _loc_3.url.replace("file:///", "");
            }
            if (param1.indexOf("\\\\") != -1)
            {
                param1 = "file://" + param1.substr(param1.indexOf("\\\\"));
            }
            return param1;
        }// end function

        override public function onLoaded(param1:Uri, param2:uint, param3) : void
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            trace("File loaded: " + param1);
            if (param1.fileType == "swf" && param1.tag != null && param1.tag is Uri)
            {
                _loc_4 = param1.tag;
            }
            else if (param1.fileType == "swl" && param1.tag != null && param1.tag.oldUri != null && param1.tag.oldUri is Uri)
            {
                _loc_4 = param1.tag.oldUri;
            }
            else if (param1.tag != null && param1.tag is Uri)
            {
                _loc_4 = param1.tag;
            }
            else
            {
                _loc_4 = param1;
            }
            var _loc_5:* = singleLoadingFile[param1];
            if (singleLoadingFile[param1])
            {
                _loc_5.onLoaded(_loc_4, param2, param3);
                delete singleLoadingFile[param1];
            }
            else if (loadingFile[getUrl(param1)] && loadingFile[getUrl(param1)].length)
            {
                _loc_6 = loadingFile[getUrl(param1)];
                delete loadingFile[getUrl(param1)];
                for each (_loc_5 in _loc_6)
                {
                    
                    IResourceObserver(_loc_5).onLoaded(_loc_4, param2, param3);
                }
            }
            return;
        }// end function

        override public function onFailed(param1:Uri, param2:String, param3:uint) : void
        {
            var _loc_5:* = null;
            trace("Fail to load: " + param1);
            var _loc_4:* = singleLoadingFile[param1];
            if (singleLoadingFile[param1])
            {
                _loc_4.onFailed(param1, param2, param3);
                delete singleLoadingFile[param1];
            }
            else if (loadingFile[getUrl(param1)] && loadingFile[getUrl(param1)].length)
            {
                _loc_5 = loadingFile[getUrl(param1)];
                delete loadingFile[getUrl(param1)];
                for each (_loc_4 in _loc_5)
                {
                    
                    IResourceObserver(_loc_4).onFailed(param1, param2, param3);
                }
            }
            return;
        }// end function

        override public function onProgress(param1:Uri, param2:uint, param3:uint) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = singleLoadingFile[param1];
            if (singleLoadingFile[param1])
            {
                _loc_4.onProgress(param1, param2, param3);
                delete singleLoadingFile[param1];
            }
            else if (loadingFile[getUrl(param1)] && loadingFile[getUrl(param1)] && loadingFile[getUrl(param1)].length)
            {
                _loc_5 = loadingFile[getUrl(param1)];
                delete loadingFile[getUrl(param1)];
                for each (_loc_4 in _loc_5)
                {
                    
                    IResourceObserver(_loc_4).onProgress(param1, param2, param3);
                }
            }
            return;
        }// end function

    }
}
