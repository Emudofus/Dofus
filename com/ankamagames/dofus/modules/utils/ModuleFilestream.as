package com.ankamagames.dofus.modules.utils
{
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import com.ankamagames.jerakine.interfaces.IModuleUtil;
    import flash.errors.IOError;
    import flash.filesystem.FileStream;
    import flash.filesystem.File;
    import com.ankamagames.berilia.utils.ModuleFileManager;
    import flash.filesystem.FileMode;
    import com.ankamagames.berilia.types.data.UiModule;
    import flash.utils.ByteArray;
    import flash.errors.IllegalOperationError;
    import com.ankamagames.jerakine.utils.errors.FileTypeError;

    public class ModuleFilestream implements IDataInput, IDataOutput, IModuleUtil 
    {

        private static const ERROR_SPACE:IOError = new IOError("Not enough space free", 1);
        private static const ERROR_FILE_NUM:IOError = new IOError("Maximum number of files reaches", 2);
        private static const ERROR_FILE_NOT_EXISTS:IOError = new IOError("File does not exist", 3);
        private static const AUTHORIZED_URL_CHAR_REGEXPR:RegExp = new RegExp(/[^a-zA-Z0-9-_\/]/mg);
        public static const MAX_SIZE:uint = (10 * Math.pow(2, 20));
        public static const MODULE_FILE_HEADER:String = "Ankama DOFUS 2 module File";

        private var _fs:FileStream;
        private var _file:File;
        private var _fileSize:uint;
        private var _nextAddSize:int;
        private var _startOffset:uint;
        private var _moduleId:String;
        private var _fileMode:String;
        private var _url:String;

        public function ModuleFilestream(name:String, fileMode:String, module:UiModule)
        {
            ModuleFileManager.getInstance().initModuleFiles(module.id);
            name = cleanUrl(name);
            this._url = name;
            this._file = checkCreation(name, module);
            if ((((fileMode == FileMode.READ)) && (!(this._file.exists))))
            {
                throw (ERROR_FILE_NOT_EXISTS);
            };
            this._file.parent.createDirectory();
            this._fs = new FileStream();
            this._fs.open(this._file, fileMode);
            this._fileSize = this._file.size;
            this._moduleId = module.id;
            this._fileMode = fileMode;
            var newFile:Boolean = ((!(this._file.exists)) || ((this._file.size == 0)));
            if ((((fileMode == FileMode.WRITE)) || ((((fileMode == FileMode.UPDATE)) && (newFile)))))
            {
                this.writeHeader();
            }
            else
            {
                this.readHeader();
            };
        }

        public static function checkCreation(url:String, module:UiModule):File
        {
            var parts:Array;
            var haveToBeCreated:uint;
            var testedPath:String;
            var part:String;
            ModuleFileManager.getInstance().initModuleFiles(module.id);
            url = cleanUrl(url);
            var file:File = new File(((module.storagePath + url) + ".dmf"));
            if (!(file.exists))
            {
                parts = url.replace(/\./g, "").replace(/\\/g, "/").split("/");
                haveToBeCreated = 0;
                testedPath = module.storagePath;
                for each (part in parts)
                {
                    testedPath = (testedPath + ("/" + part));
                    if (!(new File(testedPath).exists))
                    {
                        haveToBeCreated++;
                    };
                };
                if (!(ModuleFileManager.getInstance().canCreateFiles(module.id, haveToBeCreated)))
                {
                    throw (ERROR_FILE_NUM);
                };
                ModuleFileManager.getInstance().updateModuleFileNum(module.id, haveToBeCreated);
            };
            return (file);
        }

        public static function cleanUrl(url:String):String
        {
            return (url.replace(AUTHORIZED_URL_CHAR_REGEXPR, ""));
        }


        [HideInFakeClass]
        [Untrusted]
        public function get objectEncoding():uint
        {
            return (this._fs.objectEncoding);
        }

        [HideInFakeClass]
        [Untrusted]
        public function set objectEncoding(version:uint):void
        {
            this._fs.objectEncoding = version;
        }

        [Untrusted]
        public function get endian():String
        {
            return (this._fs.endian);
        }

        [Untrusted]
        public function get path():String
        {
            return (this._url);
        }

        [Untrusted]
        public function set endian(type:String):void
        {
            this._fs.endian = type;
        }

        [Untrusted]
        public function get bytesAvailable():uint
        {
            return (this._fs.bytesAvailable);
        }

        [Untrusted]
        public function get position():uint
        {
            return ((this._fs.position - MODULE_FILE_HEADER.length));
        }

        public function set position(offset:uint):void
        {
            this._fs.position = (this.position + MODULE_FILE_HEADER.length);
        }

        [Untrusted]
        public function close():void
        {
            this._fs.close();
        }

        [NoReplaceInFakeClass]
        [Untrusted]
        public function readBytes(bytes:ByteArray, offset:uint=0, length:uint=0):void
        {
            this._fs.readBytes(bytes, offset, length);
        }

        [Untrusted]
        public function readBoolean():Boolean
        {
            return (this._fs.readBoolean());
        }

        [Untrusted]
        public function readByte():int
        {
            return (this._fs.readByte());
        }

        [Untrusted]
        public function readUnsignedByte():uint
        {
            return (this._fs.readUnsignedByte());
        }

        [Untrusted]
        public function readShort():int
        {
            return (this._fs.readShort());
        }

        [Untrusted]
        public function readUnsignedShort():uint
        {
            return (this._fs.readUnsignedShort());
        }

        [Untrusted]
        public function readInt():int
        {
            return (this._fs.readInt());
        }

        [Untrusted]
        public function readUnsignedInt():uint
        {
            return (this._fs.readUnsignedInt());
        }

        [Untrusted]
        public function readFloat():Number
        {
            return (this._fs.readFloat());
        }

        [Untrusted]
        public function readDouble():Number
        {
            return (this._fs.readDouble());
        }

        [HideInFakeClass]
        [Untrusted]
        public function readMultiByte(length:uint, charSet:String):String
        {
            throw (new IllegalOperationError());
        }

        [Untrusted]
        public function readUTF():String
        {
            return (this._fs.readUTF());
        }

        [Untrusted]
        public function readUTFBytes(length:uint):String
        {
            return (this._fs.readUTFBytes(length));
        }

        [HideInFakeClass]
        [Untrusted]
        public function readObject()
        {
            throw (new IllegalOperationError());
        }

        [NoReplaceInFakeClass]
        [Untrusted]
        public function writeBytes(bytes:ByteArray, offset:uint=0, length:uint=0):void
        {
            if (length == 0)
            {
                if (!(this.check((bytes.bytesAvailable - offset))))
                {
                    throw (ERROR_SPACE);
                };
                if (!(this.check((Math.min(bytes.bytesAvailable, length) - offset))))
                {
                    throw (ERROR_SPACE);
                };
            };
            this._fs.writeBytes(bytes, offset, length);
            this.update();
        }

        [Untrusted]
        public function writeBoolean(value:Boolean):void
        {
            if (!(this.check(1)))
            {
                throw (ERROR_SPACE);
            };
            this._fs.writeBoolean(value);
            this.update();
        }

        [Untrusted]
        public function writeByte(value:int):void
        {
            if (!(this.check(1)))
            {
                throw (ERROR_SPACE);
            };
            this._fs.writeByte(value);
            this.update();
        }

        [Untrusted]
        public function writeShort(value:int):void
        {
            if (!(this.check(2)))
            {
                throw (ERROR_SPACE);
            };
            this._fs.writeShort(value);
            this.update();
        }

        [Untrusted]
        public function writeInt(value:int):void
        {
            if (!(this.check(4)))
            {
                throw (ERROR_SPACE);
            };
            this._fs.writeInt(value);
            this.update();
        }

        [Untrusted]
        public function writeUnsignedInt(value:uint):void
        {
            if (!(this.check(4)))
            {
                throw (ERROR_SPACE);
            };
            this._fs.writeUnsignedInt(value);
            this.update();
        }

        [Untrusted]
        public function writeFloat(value:Number):void
        {
            if (!(this.check(4)))
            {
                throw (ERROR_SPACE);
            };
            this._fs.writeFloat(value);
            this.update();
        }

        [Untrusted]
        public function writeDouble(value:Number):void
        {
            if (!(this.check(8)))
            {
                throw (ERROR_SPACE);
            };
            this._fs.writeDouble(value);
            this.update();
        }

        [HideInFakeClass]
        [Untrusted]
        public function writeMultiByte(value:String, charSet:String):void
        {
            throw (new IllegalOperationError());
        }

        [Untrusted]
        public function writeUTF(value:String):void
        {
            if (!(this.check((value.length + 2))))
            {
                throw (ERROR_SPACE);
            };
            this._fs.writeUTF(value);
            this.update();
        }

        [Untrusted]
        public function writeUTFBytes(value:String):void
        {
            if (!(this.check(value.length)))
            {
                throw (ERROR_SPACE);
            };
            this._fs.writeUTFBytes(value);
            this.update();
        }

        [HideInFakeClass]
        [Untrusted]
        public function writeObject(object:*):void
        {
            throw (new IllegalOperationError());
        }

        private function check(dataLength:uint):Boolean
        {
            this._nextAddSize = (dataLength - (this._fileSize - this._fs.position));
            if (this._nextAddSize < 0)
            {
                this._nextAddSize = 0;
            };
            return (((this._fileSize + this._nextAddSize) <= MAX_SIZE));
        }

        private function update():void
        {
            this._fileSize = (this._fileSize + this._nextAddSize);
            ModuleFileManager.getInstance().updateModuleSize(this._moduleId, this._nextAddSize);
            this._nextAddSize = 0;
        }

        private function readHeader():void
        {
            this._fs.position = 0;
            var header:String = this._fs.readUTF();
            if (header != MODULE_FILE_HEADER)
            {
                throw (new FileTypeError("Wrong header"));
            };
            this._startOffset = this._fs.position;
            if (this._fileMode == FileMode.APPEND)
            {
                this._fs.position = (this._fs.position + this._fs.bytesAvailable);
            };
        }

        private function writeHeader():void
        {
            this._fs.position = 0;
            this._fs.writeUTF(MODULE_FILE_HEADER);
        }


    }
}//package com.ankamagames.dofus.modules.utils

