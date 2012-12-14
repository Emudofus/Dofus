package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class GameDataFileAccessor extends Object
    {
        private var _streams:Dictionary;
        private var _streamStartIndex:Dictionary;
        private var _indexes:Dictionary;
        private var _classes:Dictionary;
        private var _counter:Dictionary;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(GameDataFileAccessor));
        private static var _self:GameDataFileAccessor;

        public function GameDataFileAccessor()
        {
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function init(param1:Uri) : void
        {
            var nativeFile:File;
            var moduleName:String;
            var stream:FileStream;
            var indexes:Dictionary;
            var contentOffset:uint;
            var headers:String;
            var indexesPointer:int;
            var indexesLength:int;
            var key:int;
            var pointer:int;
            var count:uint;
            var i:uint;
            var classes:Dictionary;
            var classesCount:int;
            var classIdentifier:int;
            var j:uint;
            var formatVersion:uint;
            var len:uint;
            var fileUri:* = param1;
            try
            {
                nativeFile = fileUri.toFile();
                if (!nativeFile || !nativeFile.exists)
                {
                    throw new Error("Game data file \'" + nativeFile + "\' not readable.");
                }
                if (!this._streams)
                {
                    this._streams = new Dictionary();
                }
                if (!this._indexes)
                {
                    this._indexes = new Dictionary();
                }
                if (!this._classes)
                {
                    this._classes = new Dictionary();
                }
                if (!this._counter)
                {
                    this._counter = new Dictionary();
                }
                if (!this._streamStartIndex)
                {
                    this._streamStartIndex = new Dictionary();
                }
                moduleName = fileUri.fileName.substr(0, fileUri.fileName.indexOf(".d2o"));
                stream = this._streams[moduleName];
                if (!stream)
                {
                    stream = new FileStream();
                    stream.endian = Endian.BIG_ENDIAN;
                    stream.open(nativeFile, FileMode.READ);
                    this._streams[moduleName] = stream;
                    this._streamStartIndex[moduleName] = 7;
                }
                else
                {
                    stream.position = 0;
                }
                indexes = new Dictionary();
                this._indexes[moduleName] = indexes;
                contentOffset;
                headers = stream.readMultiByte(3, "ASCII");
                if (headers != "D2O")
                {
                    stream.position = 0;
                    try
                    {
                        headers = stream.readUTF();
                    }
                    catch (e:Error)
                    {
                    }
                    if (headers != Signature.ANKAMA_SIGNED_FILE_HEADER)
                    {
                        throw new Error("Malformated game data file.");
                    }
                    formatVersion = stream.readShort();
                    len = stream.readInt();
                    stream.position = stream.position + len;
                    contentOffset = stream.position;
                    this._streamStartIndex[moduleName] = contentOffset + 7;
                    headers = stream.readMultiByte(3, "ASCII");
                    if (headers != "D2O")
                    {
                        throw new Error("Malformated game data file.");
                    }
                }
                indexesPointer = stream.readInt();
                stream.position = contentOffset + indexesPointer;
                indexesLength = stream.readInt();
                i;
                while (i < indexesLength)
                {
                    
                    key = stream.readInt();
                    pointer = stream.readInt();
                    indexes[key] = contentOffset + pointer;
                    count = (count + 1);
                    i = i + 8;
                }
                this._counter[moduleName] = count;
                classes = new Dictionary();
                this._classes[moduleName] = classes;
                classesCount = stream.readInt();
                j;
                while (j < classesCount)
                {
                    
                    classIdentifier = stream.readInt();
                    this.readClassDefinition(classIdentifier, stream, classes);
                    j = (j + 1);
                }
            }
            catch (e:Error)
            {
                _log.fatal("Erreur lors du parsing du fichier de données : " + fileUri);
                throw e;
            }
            return;
        }// end function

        public function getClassDefinition(param1:String, param2:int) : GameDataClassDefinition
        {
            return this._classes[param1][param2];
        }// end function

        public function getCount(param1:String) : uint
        {
            return this._counter[param1];
        }// end function

        public function getObject(param1:String, param2:int)
        {
            if (!this._indexes || !this._indexes[param1])
            {
                return null;
            }
            var _loc_3:* = this._indexes[param1][param2];
            if (!_loc_3)
            {
                return null;
            }
            this._streams[param1].position = _loc_3;
            var _loc_4:* = this._streams[param1].readInt();
            return this._classes[param1][_loc_4].read(param1, this._streams[param1]);
        }// end function

        public function getObjects(param1:String) : Array
        {
            if (!this._counter || !this._counter[param1])
            {
                return null;
            }
            var _loc_2:* = this._counter[param1];
            var _loc_3:* = this._classes[param1];
            var _loc_4:* = this._streams[param1];
            this._streams[param1].position = this._streamStartIndex[param1];
            var _loc_5:* = new Array(_loc_2);
            var _loc_6:* = 0;
            while (_loc_6 < _loc_2)
            {
                
                _loc_5[_loc_6] = _loc_3[_loc_4.readInt()].read(param1, _loc_4);
                _loc_6 = _loc_6 + 1;
            }
            return _loc_5;
        }// end function

        public function close() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = this._streams;
            do
            {
                
                _loc_1 = _loc_3[_loc_2];
                try
                {
                    _loc_1.close();
                }
                catch (e:Error)
                {
                }
            }while (_loc_3 in _loc_2)
            this._streams = null;
            this._indexes = null;
            this._classes = null;
            return;
        }// end function

        private function readClassDefinition(param1:int, param2:FileStream, param3:Dictionary) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_4:* = param2.readUTF();
            var _loc_5:* = param2.readUTF();
            var _loc_6:* = new GameDataClassDefinition(_loc_5, _loc_4);
            var _loc_7:* = param2.readInt();
            var _loc_10:* = 0;
            while (_loc_10 < _loc_7)
            {
                
                _loc_8 = param2.readUTF();
                _loc_6.addField(_loc_8, param2);
                _loc_10 = _loc_10 + 1;
            }
            param3[param1] = _loc_6;
            return;
        }// end function

        public static function getInstance() : GameDataFileAccessor
        {
            if (!_self)
            {
                _self = new GameDataFileAccessor;
            }
            return _self;
        }// end function

    }
}
