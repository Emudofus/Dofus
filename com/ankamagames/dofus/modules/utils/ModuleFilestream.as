package com.ankamagames.dofus.modules.utils
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import flash.errors.IOError;
   import flash.filesystem.File;
   import com.ankamagames.berilia.types.data.UiModule;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.jerakine.utils.errors.FileTypeError;
   import flash.filesystem.FileMode;
   
   public class ModuleFilestream extends Object implements IDataInput, IDataOutput, IModuleUtil
   {
      
      public function ModuleFilestream(name:String, fileMode:String, module:UiModule) {
         super();
         ModuleFileManager.getInstance().initModuleFiles(module.id);
         var name:String = cleanUrl(name);
         this._url = name;
         this._file = checkCreation(name,module);
         if((fileMode == FileMode.READ) && (!this._file.exists))
         {
            throw ERROR_FILE_NOT_EXISTS;
         }
         else
         {
            this._file.parent.createDirectory();
            this._fs = new FileStream();
            this._fs.open(this._file,fileMode);
            this._fileSize = this._file.size;
            this._moduleId = module.id;
            this._fileMode = fileMode;
            newFile = (!this._file.exists) || (this._file.size == 0);
            if((fileMode == FileMode.WRITE) || (fileMode == FileMode.UPDATE) && (newFile))
            {
               this.writeHeader();
            }
            else
            {
               this.readHeader();
            }
            return;
         }
      }
      
      private static const ERROR_SPACE:IOError;
      
      private static const ERROR_FILE_NUM:IOError;
      
      private static const ERROR_FILE_NOT_EXISTS:IOError;
      
      private static const AUTHORIZED_URL_CHAR_REGEXPR:RegExp;
      
      public static const MAX_SIZE:uint;
      
      public static const MODULE_FILE_HEADER:String = "Ankama DOFUS 2 module File";
      
      public static function checkCreation(url:String, module:UiModule) : File {
         var parts:Array = null;
         var haveToBeCreated:uint = 0;
         var testedPath:String = null;
         var part:String = null;
         ModuleFileManager.getInstance().initModuleFiles(module.id);
         var url:String = cleanUrl(url);
         var file:File = new File(module.storagePath + url + ".dmf");
         if(!file.exists)
         {
            parts = url.replace(new RegExp("\\.","g"),"").replace(new RegExp("\\\\","g"),"/").split("/");
            haveToBeCreated = 0;
            testedPath = module.storagePath;
            for each(part in parts)
            {
               testedPath = testedPath + ("/" + part);
               if(!new File(testedPath).exists)
               {
                  haveToBeCreated++;
               }
            }
            if(!ModuleFileManager.getInstance().canCreateFiles(module.id,haveToBeCreated))
            {
               throw ERROR_FILE_NUM;
            }
            else
            {
               ModuleFileManager.getInstance().updateModuleFileNum(module.id,haveToBeCreated);
            }
         }
         return file;
      }
      
      public static function cleanUrl(url:String) : String {
         return url.replace(AUTHORIZED_URL_CHAR_REGEXPR,"");
      }
      
      private var _fs:FileStream;
      
      private var _file:File;
      
      private var _fileSize:uint;
      
      private var _nextAddSize:int;
      
      private var _startOffset:uint;
      
      private var _moduleId:String;
      
      private var _fileMode:String;
      
      private var _url:String;
      
      public function get objectEncoding() : uint {
         return this._fs.objectEncoding;
      }
      
      public function set objectEncoding(version:uint) : void {
         this._fs.objectEncoding = version;
      }
      
      public function get endian() : String {
         return this._fs.endian;
      }
      
      public function get path() : String {
         return this._url;
      }
      
      public function set endian(type:String) : void {
         this._fs.endian = type;
      }
      
      public function get bytesAvailable() : uint {
         return this._fs.bytesAvailable;
      }
      
      public function get position() : uint {
         return this._fs.position - MODULE_FILE_HEADER.length;
      }
      
      public function set position(offset:uint) : void {
         this._fs.position = this.position + MODULE_FILE_HEADER.length;
      }
      
      public function close() : void {
         this._fs.close();
      }
      
      public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void {
         this._fs.readBytes(bytes,offset,length);
      }
      
      public function readBoolean() : Boolean {
         return this._fs.readBoolean();
      }
      
      public function readByte() : int {
         return this._fs.readByte();
      }
      
      public function readUnsignedByte() : uint {
         return this._fs.readUnsignedByte();
      }
      
      public function readShort() : int {
         return this._fs.readShort();
      }
      
      public function readUnsignedShort() : uint {
         return this._fs.readUnsignedShort();
      }
      
      public function readInt() : int {
         return this._fs.readInt();
      }
      
      public function readUnsignedInt() : uint {
         return this._fs.readUnsignedInt();
      }
      
      public function readFloat() : Number {
         return this._fs.readFloat();
      }
      
      public function readDouble() : Number {
         return this._fs.readDouble();
      }
      
      public function readMultiByte(length:uint, charSet:String) : String {
         throw new IllegalOperationError();
      }
      
      public function readUTF() : String {
         return this._fs.readUTF();
      }
      
      public function readUTFBytes(length:uint) : String {
         return this._fs.readUTFBytes(length);
      }
      
      public function readObject() : * {
         throw new IllegalOperationError();
      }
      
      public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void {
         if(length == 0)
         {
            if(!this.check(bytes.bytesAvailable - offset))
            {
               throw ERROR_SPACE;
            }
            else if(!this.check(Math.min(bytes.bytesAvailable,length) - offset))
            {
               throw ERROR_SPACE;
            }
            
         }
         this._fs.writeBytes(bytes,offset,length);
         this.update();
      }
      
      public function writeBoolean(value:Boolean) : void {
         if(!this.check(1))
         {
            throw ERROR_SPACE;
         }
         else
         {
            this._fs.writeBoolean(value);
            this.update();
            return;
         }
      }
      
      public function writeByte(value:int) : void {
         if(!this.check(1))
         {
            throw ERROR_SPACE;
         }
         else
         {
            this._fs.writeByte(value);
            this.update();
            return;
         }
      }
      
      public function writeShort(value:int) : void {
         if(!this.check(2))
         {
            throw ERROR_SPACE;
         }
         else
         {
            this._fs.writeShort(value);
            this.update();
            return;
         }
      }
      
      public function writeInt(value:int) : void {
         if(!this.check(4))
         {
            throw ERROR_SPACE;
         }
         else
         {
            this._fs.writeInt(value);
            this.update();
            return;
         }
      }
      
      public function writeUnsignedInt(value:uint) : void {
         if(!this.check(4))
         {
            throw ERROR_SPACE;
         }
         else
         {
            this._fs.writeUnsignedInt(value);
            this.update();
            return;
         }
      }
      
      public function writeFloat(value:Number) : void {
         if(!this.check(4))
         {
            throw ERROR_SPACE;
         }
         else
         {
            this._fs.writeFloat(value);
            this.update();
            return;
         }
      }
      
      public function writeDouble(value:Number) : void {
         if(!this.check(8))
         {
            throw ERROR_SPACE;
         }
         else
         {
            this._fs.writeDouble(value);
            this.update();
            return;
         }
      }
      
      public function writeMultiByte(value:String, charSet:String) : void {
         throw new IllegalOperationError();
      }
      
      public function writeUTF(value:String) : void {
         if(!this.check(value.length + 2))
         {
            throw ERROR_SPACE;
         }
         else
         {
            this._fs.writeUTF(value);
            this.update();
            return;
         }
      }
      
      public function writeUTFBytes(value:String) : void {
         if(!this.check(value.length))
         {
            throw ERROR_SPACE;
         }
         else
         {
            this._fs.writeUTFBytes(value);
            this.update();
            return;
         }
      }
      
      public function writeObject(object:*) : void {
         throw new IllegalOperationError();
      }
      
      private function check(dataLength:uint) : Boolean {
         this._nextAddSize = dataLength - (this._fileSize - this._fs.position);
         if(this._nextAddSize < 0)
         {
            this._nextAddSize = 0;
         }
         return this._fileSize + this._nextAddSize <= MAX_SIZE;
      }
      
      private function update() : void {
         this._fileSize = this._fileSize + this._nextAddSize;
         ModuleFileManager.getInstance().updateModuleSize(this._moduleId,this._nextAddSize);
         this._nextAddSize = 0;
      }
      
      private function readHeader() : void {
         this._fs.position = 0;
         var header:String = this._fs.readUTF();
         if(header != MODULE_FILE_HEADER)
         {
            throw new FileTypeError("Wrong header");
         }
         else
         {
            this._startOffset = this._fs.position;
            if(this._fileMode == FileMode.APPEND)
            {
               this._fs.position = this._fs.position + this._fs.bytesAvailable;
            }
            return;
         }
      }
      
      private function writeHeader() : void {
         this._fs.position = 0;
         this._fs.writeUTF(MODULE_FILE_HEADER);
      }
   }
}
