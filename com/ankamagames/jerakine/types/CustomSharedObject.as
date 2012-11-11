package com.ankamagames.jerakine.types
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.utils.*;

    public class CustomSharedObject extends Object
    {
        private var _name:String;
        private var _fileStream:FileStream;
        private var _file:File;
        public var data:Object;
        public var objectEncoding:uint;
        public static const DATAFILE_EXTENSION:String = "dat";
        private static var COMMON_FOLDER:String;
        private static var _cache:Array = [];
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomSharedObject));
        public static var throwException:Boolean;

        public function CustomSharedObject()
        {
            this.data = new Object();
            return;
        }// end function

        public function flush() : void
        {
            this.writeData(this.data);
            return;
        }// end function

        public function clear() : void
        {
            this.writeData(new Object());
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        private function writeData(param1) : Boolean
        {
            var data:* = param1;
            try
            {
                this._fileStream.open(this._file, FileMode.WRITE);
                this._fileStream.writeObject(data);
                this._fileStream.close();
            }
            catch (e:Error)
            {
                if (_fileStream)
                {
                    _fileStream.close();
                }
                _log.error("Impossible d\'écrire le fichier " + _file.url);
                return false;
            }
            return true;
        }// end function

        private function getDataFromFile() : void
        {
            if (!this._file)
            {
                this._file = new File(COMMON_FOLDER + this._name + "." + DATAFILE_EXTENSION);
                this._fileStream = new FileStream();
            }
            if (this._file.exists)
            {
                try
                {
                    this._fileStream.objectEncoding = ObjectEncoding.AMF3;
                    this._fileStream.open(this._file, FileMode.READ);
                    this.data = this._fileStream.readObject();
                    if (!this.data)
                    {
                        this.data = new Object();
                    }
                    this._fileStream.close();
                }
                catch (e:Error)
                {
                    if (_fileStream)
                    {
                        _fileStream.close();
                    }
                    _log.error("Impossible d\'ouvrir le fichier " + _file.url);
                    if (throwException)
                    {
                        throw new CustomSharedObjectFileFormatError("Malformated file : " + _file.url);
                    }
                }
            }
            else
            {
                this.data = new Object();
            }
            return;
        }// end function

        public static function getLocal(param1:String) : CustomSharedObject
        {
            if (_cache[param1])
            {
                return _cache[param1];
            }
            if (!COMMON_FOLDER)
            {
                COMMON_FOLDER = getCustomSharedObjectDirectory();
            }
            var _loc_2:* = new CustomSharedObject;
            _loc_2._name = param1;
            _loc_2.getDataFromFile();
            _cache[param1] = _loc_2;
            return _loc_2;
        }// end function

        public static function getCustomSharedObjectDirectory() : String
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!COMMON_FOLDER)
            {
                _loc_1 = File.applicationDirectory.nativePath.split(File.separator);
                if (AirScanner.hasAir())
                {
                    _loc_3 = File.applicationStorageDirectory.nativePath.split(File.separator);
                    _loc_3.pop();
                    _loc_3.pop();
                    COMMON_FOLDER = _loc_3.join(File.separator) + File.separator + _loc_1[_loc_1.length - 2];
                }
                else
                {
                    COMMON_FOLDER = File.applicationStorageDirectory.nativePath;
                }
                COMMON_FOLDER = COMMON_FOLDER + File.separator;
                _loc_2 = new File(COMMON_FOLDER);
                if (!_loc_2.exists)
                {
                    _loc_2.createDirectory();
                }
            }
            return COMMON_FOLDER;
        }// end function

        public static function closeAll() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _cache)
            {
                
                if (_loc_1)
                {
                    _loc_1.data = null;
                }
            }
            _cache = [];
            return;
        }// end function

    }
}
