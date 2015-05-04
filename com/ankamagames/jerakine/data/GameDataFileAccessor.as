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
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.utils.crypto.Signature;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class GameDataFileAccessor extends Object
   {
      
      public function GameDataFileAccessor()
      {
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
      
      public static function getInstance() : GameDataFileAccessor
      {
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
      
      public function init(param1:Uri) : void
      {
         var _loc2_:File = param1.toFile();
         if(!_loc2_ || !_loc2_.exists)
         {
            throw new Error("Game data file \'" + _loc2_ + "\' not readable.");
         }
         else
         {
            var _loc3_:String = param1.fileName.substr(0,param1.fileName.indexOf(".d2o"));
            if(!this._streams)
            {
               this._streams = new Dictionary();
            }
            if(!this._streamStartIndex)
            {
               this._streamStartIndex = new Dictionary();
            }
            var _loc4_:FileStream = this._streams[_loc3_];
            if(!_loc4_)
            {
               _loc4_ = new FileStream();
               _loc4_.endian = Endian.BIG_ENDIAN;
               _loc4_.open(_loc2_,FileMode.READ);
               this._streams[_loc3_] = _loc4_;
               this._streamStartIndex[_loc3_] = 7;
            }
            else
            {
               _loc4_.position = 0;
            }
            this.initFromIDataInput(_loc4_,_loc3_);
            return;
         }
      }
      
      public function initFromIDataInput(param1:IDataInput, param2:String) : void
      {
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:uint = 0;
         var _loc14_:* = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
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
         this._streams[param2] = param1;
         if(!this._streamStartIndex[param2])
         {
            this._streamStartIndex[param2] = 7;
         }
         var _loc3_:Dictionary = new Dictionary();
         this._indexes[param2] = _loc3_;
         var _loc4_:uint = 0;
         var _loc5_:String = param1.readMultiByte(3,"ASCII");
         if(_loc5_ != "D2O")
         {
            param1["position"] = 0;
            try
            {
               _loc5_ = param1.readUTF();
            }
            catch(e:Error)
            {
            }
            if(_loc5_ != Signature.ANKAMA_SIGNED_FILE_HEADER)
            {
               throw new Error("Malformated game data file.");
            }
            else
            {
               _loc16_ = param1.readShort();
               _loc17_ = param1.readInt();
               param1["position"] = param1["position"] + _loc17_;
               _loc4_ = param1["position"];
               this._streamStartIndex[param2] = _loc4_ + 7;
               _loc5_ = param1.readMultiByte(3,"ASCII");
               if(_loc5_ != "D2O")
               {
                  throw new Error("Malformated game data file.");
               }
            }
         }
         var _loc6_:int = param1.readInt();
         param1["position"] = _loc4_ + _loc6_;
         var _loc7_:int = param1.readInt();
         var _loc11_:uint = 0;
         while(_loc11_ < _loc7_)
         {
            _loc8_ = param1.readInt();
            _loc9_ = param1.readInt();
            _loc3_[_loc8_] = _loc4_ + _loc9_;
            _loc10_++;
            _loc11_ = _loc11_ + 8;
         }
         this._counter[param2] = _loc10_;
         var _loc12_:Dictionary = new Dictionary();
         this._classes[param2] = _loc12_;
         var _loc13_:int = param1.readInt();
         var _loc15_:uint = 0;
         while(_loc15_ < _loc13_)
         {
            _loc14_ = param1.readInt();
            this.readClassDefinition(_loc14_,param1,_loc12_);
            _loc15_++;
         }
         if(param1.bytesAvailable)
         {
            this._gameDataProcessor[param2] = new GameDataProcess(param1);
         }
      }
      
      public function getDataProcessor(param1:String) : GameDataProcess
      {
         return this._gameDataProcessor[param1];
      }
      
      public function getClassDefinition(param1:String, param2:int) : GameDataClassDefinition
      {
         return this._classes[param1][param2];
      }
      
      public function getCount(param1:String) : uint
      {
         return this._counter[param1];
      }
      
      public function getObject(param1:String, param2:int) : *
      {
         if(!this._indexes || !this._indexes[param1])
         {
            return null;
         }
         var _loc3_:int = this._indexes[param1][param2];
         if(!_loc3_)
         {
            return null;
         }
         this._streams[param1].position = _loc3_;
         var _loc4_:int = this._streams[param1].readInt();
         return this._classes[param1][_loc4_].read(param1,this._streams[param1]);
      }
      
      public function getObjects(param1:String) : Array
      {
         if(!this._counter || !this._counter[param1])
         {
            return null;
         }
         var _loc2_:uint = this._counter[param1];
         var _loc3_:Dictionary = this._classes[param1];
         var _loc4_:IDataInput = this._streams[param1];
         _loc4_["position"] = this._streamStartIndex[param1];
         var _loc5_:Array = new Array(_loc2_);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_[_loc6_] = _loc3_[_loc4_.readInt()].read(param1,_loc4_);
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function close() : void
      {
         var _loc1_:IDataInput = null;
         for each(_loc1_ in this._streams)
         {
            try
            {
               if(_loc1_ is FileStream)
               {
                  FileStream(_loc1_).close();
               }
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
      
      private function readClassDefinition(param1:int, param2:IDataInput, param3:Dictionary) : void
      {
         var _loc8_:String = null;
         var _loc9_:* = 0;
         var _loc4_:String = param2.readUTF();
         var _loc5_:String = param2.readUTF();
         var _loc6_:GameDataClassDefinition = new GameDataClassDefinition(_loc5_,_loc4_);
         var _loc7_:int = param2.readInt();
         var _loc10_:uint = 0;
         while(_loc10_ < _loc7_)
         {
            _loc8_ = param2.readUTF();
            _loc6_.addField(_loc8_,param2);
            _loc10_++;
         }
         param3[param1] = _loc6_;
      }
   }
}
