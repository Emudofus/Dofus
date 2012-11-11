package com.ankamagames.jerakine.resources.protocols.impl
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class PakProtocol2 extends AbstractProtocol implements IProtocol
    {
        private static var _indexes:Dictionary = new Dictionary();
        private static var _properties:Dictionary = new Dictionary();
        static const _log:Logger = Log.getLogger(getQualifiedClassName(PakProtocol2));

        public function PakProtocol2()
        {
            return;
        }// end function

        public function getFilesIndex(param1:Uri) : Dictionary
        {
            var _loc_2:* = _indexes[param1.path];
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
            var fileStream:FileStream;
            var uri:* = param1;
            var observer:* = param2;
            var dispatchProgress:* = param3;
            var cache:* = param4;
            var forcedAdapter:* = param5;
            var uniqueFile:* = param6;
            if (!_indexes[uri.path])
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
            fileStream = index.stream;
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
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_2:* = param1;
            var _loc_3:* = _loc_2.toFile();
            var _loc_4:* = new Dictionary();
            var _loc_5:* = new Dictionary();
            _indexes[param1.path] = _loc_4;
            _properties[param1.path] = _loc_5;
            while (_loc_3 && _loc_3.exists)
            {
                
                _loc_6 = new FileStream();
                _loc_6.open(_loc_3, FileMode.READ);
                _loc_7 = _loc_6.readUnsignedByte();
                _loc_8 = _loc_6.readUnsignedByte();
                if (_loc_7 != 2 || _loc_8 != 1)
                {
                    return null;
                }
                _loc_6.position = _loc_3.size - 24;
                _loc_9 = _loc_6.readUnsignedInt();
                _loc_10 = _loc_6.readUnsignedInt();
                _loc_11 = _loc_6.readUnsignedInt();
                _loc_12 = _loc_6.readUnsignedInt();
                _loc_13 = _loc_6.readUnsignedInt();
                _loc_14 = _loc_6.readUnsignedInt();
                _loc_6.position = _loc_13;
                _loc_3 = null;
                _loc_17 = 0;
                while (_loc_17 < _loc_14)
                {
                    
                    _loc_15 = _loc_6.readUTF();
                    _loc_16 = _loc_6.readUTF();
                    _loc_5[_loc_15] = _loc_16;
                    if (_loc_15 == "link")
                    {
                        _loc_21 = _loc_2.path.lastIndexOf("/");
                        if (_loc_21 != -1)
                        {
                            _loc_2 = new Uri(_loc_2.path.substr(0, _loc_21) + "/" + _loc_16);
                        }
                        else
                        {
                            _loc_2 = new Uri(_loc_16);
                        }
                        _loc_3 = _loc_2.toFile();
                    }
                    _loc_17 = _loc_17 + 1;
                }
                _loc_6.position = _loc_11;
                _loc_17 = 0;
                while (_loc_17 < _loc_12)
                {
                    
                    _loc_18 = _loc_6.readUTF();
                    _loc_19 = _loc_6.readInt();
                    _loc_20 = _loc_6.readInt();
                    _loc_4[_loc_18] = {o:_loc_19 + _loc_9, l:_loc_20, stream:_loc_6};
                    _loc_17 = _loc_17 + 1;
                }
            }
            return _loc_6;
        }// end function

    }
}
