package com.ankamagames.jerakine.resources.protocols.impl
{
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class PakProtocol extends AbstractProtocol implements IProtocol
    {
        private static var _streams:Dictionary = new Dictionary();
        private static var _indexes:Dictionary = new Dictionary();

        public function PakProtocol()
        {
            return;
        }// end function

        public function getFilesIndex(param1:Uri) : Dictionary
        {
            var _loc_2:* = _streams[param1.path];
            if (!_loc_2)
            {
                _loc_2 = this.initStream(param1);
                if (!_loc_2)
                {
                    return null;
                }
            }
            return _indexes[param1.path];
        }// end function

        public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
        {
            var uri:* = param1;
            var observer:* = param2;
            var dispatchProgress:* = param3;
            var cache:* = param4;
            var forcedAdapter:* = param5;
            var uniqueFile:* = param6;
            var fileStream:* = _streams[uri.path];
            if (!fileStream)
            {
                fileStream = this.initStream(uri);
                if (!fileStream)
                {
                    if (observer)
                    {
                        observer.onFailed(uri, "Unable to find container.", ResourceErrorCode.PAK_NOT_FOUND);
                    }
                    return;
                }
            }
            var index:* = _indexes[uri.path][uri.subPath];
            if (!index)
            {
                if (observer)
                {
                    observer.onFailed(uri, "Unable to find the file in the container.", ResourceErrorCode.FILE_NOT_FOUND_IN_PAK);
                }
                return;
            }
            var data:* = new ByteArray();
            fileStream.position = index.o;
            fileStream.readBytes(data, 0, index.l);
            getAdapter(uri, forcedAdapter);
            try
            {
                _adapter.loadFromData(uri, data, observer, dispatchProgress);
            }
            catch (e:Object)
            {
                observer.onFailed(uri, "Can\'t load byte array from this adapter.", ResourceErrorCode.INCOMPATIBLE_ADAPTER);
                return;
            }
            return;
        }// end function

        override protected function release() : void
        {
            return;
        }// end function

        override public function cancel() : void
        {
            if (_adapter)
            {
                _adapter.free();
            }
            return;
        }// end function

        private function initStream(param1:Uri) : FileStream
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_2:* = param1.toFile();
            if (!_loc_2.exists)
            {
                return null;
            }
            var _loc_3:* = new FileStream();
            _loc_3.open(_loc_2, FileMode.READ);
            var _loc_4:* = new Dictionary();
            var _loc_5:* = _loc_3.readInt();
            _loc_3.position = _loc_5;
            while (_loc_3.bytesAvailable > 0)
            {
                
                _loc_6 = _loc_3.readUTF();
                _loc_7 = _loc_3.readInt();
                _loc_8 = _loc_3.readInt();
                _loc_4[_loc_6] = {o:_loc_7, l:_loc_8};
            }
            _indexes[param1.path] = _loc_4;
            _streams[param1.path] = _loc_3;
            return _loc_3;
        }// end function

    }
}
