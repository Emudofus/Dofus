package com.ankamagames.jerakine.resources.protocols.impl
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class FileProtocol extends AbstractProtocol implements IProtocol, IResourceObserver
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FileProtocol));
        private static var _loadingFile:Dictionary = new Dictionary(true);
        private static var _singleLoadingFile:Dictionary = new Dictionary(true);

        public function FileProtocol()
        {
            return;
        }// end function

        public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
        {
            if (param6 && (param1.fileType != "swf" || !param1.subPath || param1.subPath.length == 0))
            {
                _singleLoadingFile[param1] = param2;
                this.loadDirectly(param1, this, param3, param5);
            }
            else if (_loadingFile[this.getUrl(param1)])
            {
                _loadingFile[this.getUrl(param1)].push(param2);
            }
            else
            {
                _loadingFile[this.getUrl(param1)] = [param2];
                this.loadDirectly(param1, this, param3, param5);
            }
            return;
        }// end function

        private function getUrl(param1:Uri) : String
        {
            if (param1.fileType != "swf" || !param1.subPath || param1.subPath.length == 0)
            {
                return param1.normalizedUri;
            }
            return param1.normalizedUriWithoutSubPath;
        }// end function

        override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
        {
            getAdapter(param1, param4);
            _adapter.com.ankamagames.jerakine.resources.adapters:IAdapter::loadDirectly(param1, this.extractPath(param1.path), param2, param3);
            return;
        }// end function

        protected function extractPath(param1:String) : String
        {
            var _loc_2:String = null;
            var _loc_3:File = null;
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

        override protected function release() : void
        {
            if (_adapter)
            {
                _adapter.free();
            }
            return;
        }// end function

        public function onLoaded(param1:Uri, param2:uint, param3) : void
        {
            var _loc_5:Array = null;
            var _loc_4:* = _singleLoadingFile[param1];
            if (_singleLoadingFile[param1])
            {
                _loc_4.onLoaded(param1, param2, param3);
                delete _singleLoadingFile[param1];
            }
            else if (_loadingFile[this.getUrl(param1)] && _loadingFile[this.getUrl(param1)].length)
            {
                _loc_5 = _loadingFile[this.getUrl(param1)];
                delete _loadingFile[this.getUrl(param1)];
                for each (_loc_4 in _loc_5)
                {
                    
                    IResourceObserver(_loc_4).onLoaded(param1, param2, param3);
                }
            }
            return;
        }// end function

        public function onFailed(param1:Uri, param2:String, param3:uint) : void
        {
            var _loc_5:Array = null;
            var _loc_4:* = _singleLoadingFile[param1];
            if (_singleLoadingFile[param1])
            {
                _loc_4.onFailed(param1, param2, param3);
                delete _singleLoadingFile[param1];
            }
            else if (_loadingFile[this.getUrl(param1)] && _loadingFile[this.getUrl(param1)].length)
            {
                _loc_5 = _loadingFile[this.getUrl(param1)];
                delete _loadingFile[this.getUrl(param1)];
                for each (_loc_4 in _loc_5)
                {
                    
                    IResourceObserver(_loc_4).onFailed(param1, param2, param3);
                }
            }
            return;
        }// end function

        public function onProgress(param1:Uri, param2:uint, param3:uint) : void
        {
            var _loc_5:Array = null;
            var _loc_4:* = _singleLoadingFile[param1];
            if (_singleLoadingFile[param1])
            {
                _loc_4.onProgress(param1, param2, param3);
                delete _singleLoadingFile[param1];
            }
            else if (_loadingFile[this.getUrl(param1)] && _loadingFile[this.getUrl(param1)] && _loadingFile[this.getUrl(param1)].length)
            {
                _loc_5 = _loadingFile[this.getUrl(param1)];
                delete _loadingFile[this.getUrl(param1)];
                for each (_loc_4 in _loc_5)
                {
                    
                    IResourceObserver(_loc_4).onProgress(param1, param2, param3);
                }
            }
            return;
        }// end function

    }
}
