package com.ankamagames.jerakine.resources.protocols
{
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class AbstractFileProtocol extends AbstractProtocol implements IProtocol, IResourceObserver
    {
        private static var _loadingFile:Dictionary = new Dictionary(true);
        private static var _singleLoadingFile:Dictionary = new Dictionary(true);

        public function AbstractFileProtocol()
        {
            return;
        }// end function

        public function initAdapter(param1:Uri, param2:Class) : void
        {
            getAdapter(param1, param2);
            return;
        }// end function

        public function getUrl(param1:Uri) : String
        {
            if (param1.fileType != "swf" || !param1.subPath || param1.subPath.length == 0)
            {
                return param1.normalizedUri;
            }
            return param1.normalizedUriWithoutSubPath;
        }// end function

        override protected function release() : void
        {
            if (_adapter)
            {
                _adapter.free();
            }
            return;
        }// end function

        public function get adapter() : IAdapter
        {
            return _adapter;
        }// end function

        public function get loadingFile() : Dictionary
        {
            return _loadingFile;
        }// end function

        public function set loadingFile(param1:Dictionary) : void
        {
            _loadingFile = param1;
            return;
        }// end function

        public function get singleLoadingFile() : Dictionary
        {
            return _singleLoadingFile;
        }// end function

        public function set singleLoadingFile(param1:Dictionary) : void
        {
            _singleLoadingFile = param1;
            return;
        }// end function

        public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
        {
            throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
        }// end function

        public function onLoaded(param1:Uri, param2:uint, param3) : void
        {
            throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
        }// end function

        public function onFailed(param1:Uri, param2:String, param3:uint) : void
        {
            throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
        }// end function

        public function onProgress(param1:Uri, param2:uint, param3:uint) : void
        {
            throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
        }// end function

        protected function extractPath(param1:String) : String
        {
            throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
        }// end function

    }
}
