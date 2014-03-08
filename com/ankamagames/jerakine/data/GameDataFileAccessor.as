package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.utils.Endian;
   import flash.filesystem.FileMode;
   import com.ankamagames.jerakine.utils.crypto.Signature;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class GameDataFileAccessor extends Object
   {
      
      public function GameDataFileAccessor() {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(GameDataFileAccessor));
      
      private static var _self:GameDataFileAccessor;
      
      public static function getInstance() : GameDataFileAccessor {
         if(!_self)
         {
            _self = new GameDataFileAccessor();
         }
         return _self;
      }
      
      private var _streams:Dictionary;
      
      private var _streamStartIndex:Dictionary;
      
      private var _indexes:Dictionary;
      
      private var _classes:Dictionary;
      
      private var _counter:Dictionary;
      
      private var _gameDataProcessor:Dictionary;
      
      public function init(fileUri:Uri) : void {
         var key:* = 0;
         var pointer:* = 0;
         var count:uint = 0;
         var classIdentifier:* = 0;
         var formatVersion:uint = 0;
         var len:uint = 0;
         var nativeFile:File = fileUri.toFile();
         if((!nativeFile) || (!nativeFile.exists))
         {
            throw new Error("Game data file \'" + nativeFile + "\' not readable.");
         }
         else
         {
            if(!this._streams)
            {
               this._streams = new Dictionary();
            }
            if(!this._indexes)
            {
               this._indexes = new Dictionary();
            }
            if(!this._classes)
            {
               this._classes = new Dictionary();
            }
            if(!this._counter)
            {
               this._counter = new Dictionary();
            }
            if(!this._streamStartIndex)
            {
               this._streamStartIndex = new Dictionary();
            }
            if(!this._gameDataProcessor)
            {
               this._gameDataProcessor = new Dictionary();
            }
            moduleName = fileUri.fileName.substr(0,fileUri.fileName.indexOf(".d2o"));
            stream = this._streams[moduleName];
            if(!stream)
            {
               stream = new FileStream();
               stream.endian = Endian.BIG_ENDIAN;
               stream.open(nativeFile,FileMode.READ);
               this._streams[moduleName] = stream;
               this._streamStartIndex[moduleName] = 7;
            }
            else
            {
               stream.position = 0;
            }
            indexes = new Dictionary();
            this._indexes[moduleName] = indexes;
            contentOffset = 0;
            headers = stream.readMultiByte(3,"ASCII");
            if(headers != "D2O")
            {
               stream.position = 0;
               try
               {
                  headers = stream.readUTF();
               }
               catch(e:Error)
               {
               }
               if(headers != Signature.ANKAMA_SIGNED_FILE_HEADER)
               {
                  throw new Error("Malformated game data file.");
               }
               else
               {
                  formatVersion = stream.readShort();
                  len = stream.readInt();
                  stream.position = stream.position + len;
                  contentOffset = stream.position;
                  this._streamStartIndex[moduleName] = contentOffset + 7;
                  headers = stream.readMultiByte(3,"ASCII");
                  if(headers != "D2O")
                  {
                     throw new Error("Malformated game data file.");
                  }
               }
            }
            indexesPointer = stream.readInt();
            stream.position = contentOffset + indexesPointer;
            indexesLength = stream.readInt();
            i = 0;
            while(i < indexesLength)
            {
               key = stream.readInt();
               pointer = stream.readInt();
               indexes[key] = contentOffset + pointer;
               count++;
               i = i + 8;
            }
            this._counter[moduleName] = count;
            classes = new Dictionary();
            this._classes[moduleName] = classes;
            classesCount = stream.readInt();
            j = 0;
            while(j < classesCount)
            {
               classIdentifier = stream.readInt();
               this.readClassDefinition(classIdentifier,stream,classes);
               j++;
            }
            if(stream.bytesAvailable)
            {
               this._gameDataProcessor[moduleName] = new GameDataProcess(stream);
            }
            return;
         }
      }
      
      public function getDataProcessor(moduleName:String) : GameDataProcess {
         return this._gameDataProcessor[moduleName];
      }
      
      public function getClassDefinition(moduleName:String, classId:int) : GameDataClassDefinition {
         return this._classes[moduleName][classId];
      }
      
      public function getCount(moduleName:String) : uint {
         return this._counter[moduleName];
      }
      
      public function getObject(moduleName:String, objectId:int) : * {
         if((!this._indexes) || (!this._indexes[moduleName]))
         {
            return null;
         }
         var pointer:int = this._indexes[moduleName][objectId];
         if(!pointer)
         {
            return null;
         }
         this._streams[moduleName].position = pointer;
         var classId:int = this._streams[moduleName].readInt();
         return this._classes[moduleName][classId].read(moduleName,this._streams[moduleName]);
      }
      
      public function getObjects(moduleName:String) : Array {
         if((!this._counter) || (!this._counter[moduleName]))
         {
            return null;
         }
         var len:uint = this._counter[moduleName];
         var classes:Dictionary = this._classes[moduleName];
         var stream:FileStream = this._streams[moduleName];
         stream.position = this._streamStartIndex[moduleName];
         var objs:Array = new Array(len);
         var i:uint = 0;
         while(i < len)
         {
            objs[i] = classes[stream.readInt()].read(moduleName,stream);
            i++;
         }
         return objs;
      }
      
      public function close() : void {
         var stream:FileStream = null;
         for each (stream in this._streams)
         {
            try
            {
               stream.close();
            }
            catch(e:Error)
            {
               continue;
            }
         }
         this._streams = null;
         this._indexes = null;
         this._classes = null;
      }
      
      private function readClassDefinition(classId:int, stream:FileStream, store:Dictionary) : void {
         var fieldName:String = null;
         var fieldType:* = 0;
         var className:String = stream.readUTF();
         var packageName:String = stream.readUTF();
         var classDef:GameDataClassDefinition = new GameDataClassDefinition(packageName,className);
         var fieldsCount:int = stream.readInt();
         var i:uint = 0;
         while(i < fieldsCount)
         {
            fieldName = stream.readUTF();
            classDef.addField(fieldName,stream);
            i++;
         }
         store[classId] = classDef;
      }
   }
}
