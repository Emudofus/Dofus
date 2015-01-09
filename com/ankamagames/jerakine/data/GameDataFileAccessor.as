package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import flash.filesystem.File;
    import flash.filesystem.FileStream;
    import flash.utils.Endian;
    import flash.filesystem.FileMode;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.utils.crypto.Signature;
    import flash.utils.IDataInput;

    public class GameDataFileAccessor 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(GameDataFileAccessor));
        private static var _self:GameDataFileAccessor;

        private var _streams:Dictionary;
        private var _streamStartIndex:Dictionary;
        private var _indexes:Dictionary;
        private var _classes:Dictionary;
        private var _counter:Dictionary;
        private var _gameDataProcessor:Dictionary;

        public function GameDataFileAccessor()
        {
            if (_self)
            {
                throw (new SingletonError());
            };
        }

        public static function getInstance():GameDataFileAccessor
        {
            if (!(_self))
            {
                _self = new (GameDataFileAccessor)();
            };
            return (_self);
        }


        public function init(fileUri:Uri):void
        {
            var nativeFile:File = fileUri.toFile();
            if (((!(nativeFile)) || (!(nativeFile.exists))))
            {
                throw (new Error((("Game data file '" + nativeFile) + "' not readable.")));
            };
            var moduleName:String = fileUri.fileName.substr(0, fileUri.fileName.indexOf(".d2o"));
            if (!(this._streams))
            {
                this._streams = new Dictionary();
            };
            if (!(this._streamStartIndex))
            {
                this._streamStartIndex = new Dictionary();
            };
            var stream:FileStream = this._streams[moduleName];
            if (!(stream))
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
            };
            this.initFromIDataInput(stream, moduleName);
        }

        public function initFromIDataInput(stream:IDataInput, moduleName:String):void
        {
            var key:int;
            var pointer:int;
            var count:uint;
            var classIdentifier:int;
            var formatVersion:uint;
            var len:uint;
            if (!(this._streams))
            {
                this._streams = new Dictionary();
            };
            if (!(this._indexes))
            {
                this._indexes = new Dictionary();
            };
            if (!(this._classes))
            {
                this._classes = new Dictionary();
            };
            if (!(this._counter))
            {
                this._counter = new Dictionary();
            };
            if (!(this._streamStartIndex))
            {
                this._streamStartIndex = new Dictionary();
            };
            if (!(this._gameDataProcessor))
            {
                this._gameDataProcessor = new Dictionary();
            };
            this._streams[moduleName] = stream;
            if (!(this._streamStartIndex[moduleName]))
            {
                this._streamStartIndex[moduleName] = 7;
            };
            var indexes:Dictionary = new Dictionary();
            this._indexes[moduleName] = indexes;
            var contentOffset:uint;
            var headers:String = stream.readMultiByte(3, "ASCII");
            if (headers != "D2O")
            {
                stream["position"] = 0;
                try
                {
                    headers = stream.readUTF();
                }
                catch(e:Error)
                {
                };
                if (headers != Signature.ANKAMA_SIGNED_FILE_HEADER)
                {
                    throw (new Error("Malformated game data file."));
                };
                formatVersion = stream.readShort();
                len = stream.readInt();
                stream["position"] = (stream["position"] + len);
                contentOffset = stream["position"];
                this._streamStartIndex[moduleName] = (contentOffset + 7);
                headers = stream.readMultiByte(3, "ASCII");
                if (headers != "D2O")
                {
                    throw (new Error("Malformated game data file."));
                };
            };
            var indexesPointer:int = stream.readInt();
            stream["position"] = (contentOffset + indexesPointer);
            var indexesLength:int = stream.readInt();
            var i:uint;
            while (i < indexesLength)
            {
                key = stream.readInt();
                pointer = stream.readInt();
                indexes[key] = (contentOffset + pointer);
                count++;
                i = (i + 8);
            };
            this._counter[moduleName] = count;
            var classes:Dictionary = new Dictionary();
            this._classes[moduleName] = classes;
            var classesCount:int = stream.readInt();
            var j:uint;
            while (j < classesCount)
            {
                classIdentifier = stream.readInt();
                this.readClassDefinition(classIdentifier, stream, classes);
                j++;
            };
            if (stream.bytesAvailable)
            {
                this._gameDataProcessor[moduleName] = new GameDataProcess(stream);
            };
        }

        public function getDataProcessor(moduleName:String):GameDataProcess
        {
            return (this._gameDataProcessor[moduleName]);
        }

        public function getClassDefinition(moduleName:String, classId:int):GameDataClassDefinition
        {
            return (this._classes[moduleName][classId]);
        }

        public function getCount(moduleName:String):uint
        {
            return (this._counter[moduleName]);
        }

        public function getObject(moduleName:String, objectId:int)
        {
            if (((!(this._indexes)) || (!(this._indexes[moduleName]))))
            {
                return (null);
            };
            var pointer:int = this._indexes[moduleName][objectId];
            if (!(pointer))
            {
                return (null);
            };
            this._streams[moduleName].position = pointer;
            var classId:int = this._streams[moduleName].readInt();
            return (this._classes[moduleName][classId].read(moduleName, this._streams[moduleName]));
        }

        public function getObjects(moduleName:String):Array
        {
            if (((!(this._counter)) || (!(this._counter[moduleName]))))
            {
                return (null);
            };
            var len:uint = this._counter[moduleName];
            var classes:Dictionary = this._classes[moduleName];
            var stream:IDataInput = this._streams[moduleName];
            stream["position"] = this._streamStartIndex[moduleName];
            var objs:Array = new Array(len);
            var i:uint;
            while (i < len)
            {
                objs[i] = classes[stream.readInt()].read(moduleName, stream);
                i++;
            };
            return (objs);
        }

        public function close():void
        {
            var stream:IDataInput;
            for each (stream in this._streams)
            {
                try
                {
                    if ((stream is FileStream))
                    {
                        FileStream(stream).close();
                    };
                }
                catch(e:Error)
                {
                };
            };
            this._streams = null;
            this._indexes = null;
            this._classes = null;
        }

        private function readClassDefinition(classId:int, stream:IDataInput, store:Dictionary):void
        {
            var fieldName:String;
            var fieldType:int;
            var className:String = stream.readUTF();
            var packageName:String = stream.readUTF();
            var classDef:GameDataClassDefinition = new GameDataClassDefinition(packageName, className);
            var fieldsCount:int = stream.readInt();
            var i:uint;
            while (i < fieldsCount)
            {
                fieldName = stream.readUTF();
                classDef.addField(fieldName, stream);
                i++;
            };
            store[classId] = classDef;
        }


    }
}//package com.ankamagames.jerakine.data

