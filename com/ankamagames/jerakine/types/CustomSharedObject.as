package com.ankamagames.jerakine.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.filesystem.FileStream;
   import flash.filesystem.FileMode;
   import flash.net.ObjectEncoding;
   import com.ankamagames.jerakine.utils.errors.CustomSharedObjectFileFormatError;
   
   public class CustomSharedObject extends Object
   {
      
      public function CustomSharedObject() {
         this.data = new Object();
         super();
      }
      
      public static const DATAFILE_EXTENSION:String = "dat";
      
      private static var COMMON_FOLDER:String;
      
      private static var _cache:Array = [];
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomSharedObject));
      
      public static var throwException:Boolean;
      
      public static function getLocal(name:String) : CustomSharedObject {
         if(_cache[name])
         {
            return _cache[name];
         }
         if(!COMMON_FOLDER)
         {
            COMMON_FOLDER = getCustomSharedObjectDirectory();
         }
         var cso:CustomSharedObject = new CustomSharedObject();
         cso._name = name;
         cso.getDataFromFile();
         _cache[name] = cso;
         return cso;
      }
      
      public static function getCustomSharedObjectDirectory() : String {
         var tmp:Array = null;
         var dir:File = null;
         var tmp2:Array = null;
         if(!COMMON_FOLDER)
         {
            tmp = File.applicationDirectory.nativePath.split(File.separator);
            if(AirScanner.hasAir())
            {
               tmp2 = File.applicationStorageDirectory.nativePath.split(File.separator);
               tmp2.pop();
               tmp2.pop();
               COMMON_FOLDER = tmp2.join(File.separator) + File.separator + tmp[tmp.length - 2];
            }
            else
            {
               COMMON_FOLDER = File.applicationStorageDirectory.nativePath;
            }
            COMMON_FOLDER = COMMON_FOLDER + File.separator;
            dir = new File(COMMON_FOLDER);
            if(!dir.exists)
            {
               dir.createDirectory();
            }
         }
         return COMMON_FOLDER;
      }
      
      public static function closeAll() : void {
         var cso:CustomSharedObject = null;
         for each (cso in _cache)
         {
            if(cso)
            {
               cso.data = null;
            }
         }
         _cache = [];
      }
      
      private var _name:String;
      
      private var _fileStream:FileStream;
      
      private var _file:File;
      
      public var data:Object;
      
      public var objectEncoding:uint;
      
      public function flush() : void {
         this.writeData(this.data);
      }
      
      public function clear() : void {
         this.writeData(new Object());
      }
      
      public function close() : void {
      }
      
      private function writeData(data:*) : Boolean {
         try
         {
            this._fileStream.open(this._file,FileMode.WRITE);
            this._fileStream.writeObject(data);
            this._fileStream.close();
         }
         catch(e:Error)
         {
            if(_fileStream)
            {
               _fileStream.close();
            }
            _log.error("Impossible d\'écrire le fichier " + _file.url);
            return false;
         }
         return true;
      }
      
      private function getDataFromFile() : void {
         if(!this._file)
         {
            this._file = new File(COMMON_FOLDER + this._name + "." + DATAFILE_EXTENSION);
            this._fileStream = new FileStream();
         }
         if(this._file.exists)
         {
            try
            {
               this._fileStream.objectEncoding = ObjectEncoding.AMF3;
               this._fileStream.open(this._file,FileMode.READ);
               this.data = this._fileStream.readObject();
               if(!this.data)
               {
                  this.data = new Object();
               }
               this._fileStream.close();
            }
            catch(e:Error)
            {
               if(_fileStream)
               {
                  _fileStream.close();
               }
               _log.error("Impossible d\'ouvrir le fichier " + _file.url);
               if(throwException)
               {
                  throw new CustomSharedObjectFileFormatError("Malformated file : " + _file.url);
               }
            }
         }
         else
         {
            this.data = new Object();
         }
      }
   }
}
