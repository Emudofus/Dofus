package com.ankamagames.jerakine.data
{
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.enum.GameDataTypeEnum;
   import flash.utils.ByteArray;
   import flash.filesystem.FileStream;
   
   public class GameDataProcess extends Object
   {
      
      public function GameDataProcess(param1:FileStream) {
         super();
         this._stream = param1;
         this._sortIndex = new Dictionary();
         this.parseStream();
      }
      
      private var _searchFieldIndex:Dictionary;
      
      private var _searchFieldCount:Dictionary;
      
      private var _searchFieldType:Dictionary;
      
      private var _queryableField:Vector.<String>;
      
      private var _stream:IDataInput;
      
      private var _currentStream:IDataInput;
      
      private var _sortIndex:Dictionary;
      
      public function getQueryableField() : Vector.<String> {
         return this._queryableField;
      }
      
      public function getFieldType(param1:String) : int {
         return this._searchFieldType[param1];
      }
      
      public function query(param1:String, param2:Function) : Vector.<uint> {
         var _loc8_:* = NaN;
         var _loc9_:uint = 0;
         var _loc3_:Vector.<uint> = new Vector.<uint>();
         if(!this._searchFieldIndex[param1])
         {
            return null;
         }
         var _loc4_:int = this._searchFieldType[param1];
         var _loc5_:Function = this.getReadFunction(_loc4_);
         var _loc6_:uint = this._searchFieldCount[param1];
         Object(this._stream).position = this._searchFieldIndex[param1];
         if(_loc5_ == null)
         {
            return null;
         }
         var _loc7_:uint = 0;
         while(_loc7_++ < _loc6_)
         {
            if(param2(_loc5_()))
            {
               _loc8_ = this._stream.readInt() * 0.25;
               _loc9_ = 0;
               while(_loc9_ < _loc8_)
               {
                  _loc3_.push(this._stream.readInt());
                  _loc9_++;
               }
            }
            else
            {
               Object(this._stream).position = this._stream.readInt() + Object(this._stream).position;
            }
         }
         return _loc3_;
      }
      
      public function queryEquals(param1:String, param2:*) : Vector.<uint> {
         var _loc9_:* = undefined;
         var _loc12_:* = NaN;
         var _loc13_:uint = 0;
         var _loc3_:Vector.<uint> = new Vector.<uint>();
         if(!this._searchFieldIndex[param1])
         {
            return null;
         }
         var _loc4_:* = !(param2 is uint || param2 is int || param2 is Number || param2 is String || param2 is Boolean || param2 == null);
         if((_loc4_) && param2.length == 0)
         {
            return _loc3_;
         }
         if(!_loc4_)
         {
            param2 = [param2];
         }
         var _loc5_:uint = this._searchFieldCount[param1];
         Object(this._stream).position = this._searchFieldIndex[param1];
         var _loc6_:int = this._searchFieldType[param1];
         var _loc7_:Function = this.getReadFunction(_loc6_);
         if(_loc7_ == null)
         {
            return null;
         }
         var _loc8_:uint = 0;
         param2.sort(Array.NUMERIC);
         var _loc10_:* = param2[0];
         var _loc11_:uint = 0;
         while(_loc11_++ < _loc5_)
         {
            _loc9_ = _loc7_();
            while(_loc9_ > _loc10_)
            {
               if(++_loc8_ == param2.length)
               {
                  return _loc3_;
               }
               _loc10_ = param2[_loc8_];
            }
            if(_loc9_ == _loc10_)
            {
               _loc12_ = this._stream.readInt() * 0.25;
               _loc13_ = 0;
               while(_loc13_ < _loc12_)
               {
                  _loc3_.push(this._stream.readInt());
                  _loc13_++;
               }
               if(++_loc8_ == param2.length)
               {
                  return _loc3_;
               }
               _loc10_ = param2[_loc8_];
            }
            else
            {
               Object(this._stream).position = this._stream.readInt() + Object(this._stream).position;
            }
         }
         return _loc3_;
      }
      
      public function sort(param1:*, param2:Vector.<uint>, param3:*=true) : Vector.<uint> {
         param2.sort(this.getSortFunction(param1,param3));
         return param2;
      }
      
      private function getSortFunction(param1:*, param2:*) : Function {
         var sortWay:Vector.<Number> = null;
         var indexes:Vector.<Dictionary> = null;
         var maxFieldIndex:uint = 0;
         var fieldName:String = null;
         var fieldNames:* = param1;
         var ascending:* = param2;
         if(fieldNames is String)
         {
            fieldNames = [fieldNames];
         }
         if(ascending is Boolean)
         {
            ascending = [ascending];
         }
         sortWay = new Vector.<Number>();
         indexes = new Vector.<Dictionary>();
         var i:uint = 0;
         while(i < fieldNames.length)
         {
            fieldName = fieldNames[i];
            if(this._searchFieldType[fieldName] == GameDataTypeEnum.I18N)
            {
               this.buildI18nSortIndex(fieldName);
            }
            else
            {
               this.buildSortIndex(fieldName);
            }
            if(ascending.length < fieldNames.length)
            {
               ascending.push(true);
            }
            sortWay.push(ascending[i]?1:-1);
            indexes.push(this._sortIndex[fieldName]);
            i++;
         }
         maxFieldIndex = fieldNames.length;
         return function(param1:uint, param2:uint):Number
         {
            var _loc3_:* = 0;
            while(_loc3_ < maxFieldIndex)
            {
               if(indexes[_loc3_][param1] < indexes[_loc3_][param2])
               {
                  return -sortWay[_loc3_];
               }
               if(indexes[_loc3_][param1] > indexes[_loc3_][param2])
               {
                  return sortWay[_loc3_];
               }
               _loc3_++;
            }
            return 0;
         };
      }
      
      private function buildSortIndex(param1:String) : void {
         var _loc10_:* = undefined;
         var _loc11_:* = NaN;
         var _loc12_:uint = 0;
         if((this._sortIndex[param1]) || !this._searchFieldIndex[param1])
         {
            return;
         }
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         var _loc3_:uint = this._searchFieldCount[param1];
         Object(this._stream).position = this._searchFieldIndex[param1];
         var _loc4_:Dictionary = new Dictionary();
         this._sortIndex[param1] = _loc4_;
         var _loc5_:int = this._searchFieldType[param1];
         var _loc6_:Function = this.getReadFunction(_loc5_);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         while(_loc9_++ < _loc3_)
         {
            _loc10_ = _loc6_();
            _loc11_ = this._stream.readInt() * 0.25;
            _loc12_ = 0;
            while(_loc12_ < _loc11_)
            {
               _loc4_[this._stream.readInt()] = _loc10_;
               _loc12_++;
            }
         }
      }
      
      private function buildI18nSortIndex(param1:String) : void {
         var _loc6_:uint = 0;
         var _loc7_:* = NaN;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         if((this._sortIndex[param1]) || !this._searchFieldIndex[param1])
         {
            return;
         }
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         var _loc3_:uint = this._searchFieldCount[param1];
         Object(this._stream).position = this._searchFieldIndex[param1];
         var _loc4_:Dictionary = new Dictionary();
         this._sortIndex[param1] = _loc4_;
         var _loc5_:uint = 0;
         while(_loc5_++ < _loc3_)
         {
            _loc6_ = this._stream.readInt();
            _loc7_ = this._stream.readInt() * 0.25;
            if(_loc7_)
            {
               _loc8_ = I18nFileAccessor.getInstance().getOrderIndex(_loc6_);
               _loc9_ = 0;
               while(_loc9_ < _loc7_)
               {
                  _loc4_[this._stream.readInt()] = _loc8_;
                  _loc9_++;
               }
            }
         }
      }
      
      private function readI18n() : String {
         return I18nFileAccessor.getInstance().getUnDiacriticalText(this._currentStream.readInt());
      }
      
      private function getReadFunction(param1:int) : Function {
         var _loc2_:Function = null;
         var _loc3_:ByteArray = null;
         switch(param1)
         {
            case GameDataTypeEnum.INT:
               _loc2_ = this._stream.readInt;
               break;
            case GameDataTypeEnum.BOOLEAN:
               _loc2_ = this._stream.readBoolean;
               break;
            case GameDataTypeEnum.STRING:
               _loc2_ = this._stream.readUTF;
               break;
            case GameDataTypeEnum.NUMBER:
               _loc2_ = this._stream.readDouble;
               break;
            case GameDataTypeEnum.I18N:
               I18nFileAccessor.getInstance().useDirectBuffer(true);
               _loc2_ = this.readI18n;
               if(!(this._stream is ByteArray))
               {
                  _loc3_ = new ByteArray();
                  Object(this._stream).position = 0;
                  this._stream.readBytes(_loc3_);
                  _loc3_.position = 0;
                  this._stream = _loc3_;
                  this._currentStream = this._stream;
               }
               break;
            case GameDataTypeEnum.UINT:
               _loc2_ = this._stream.readUnsignedInt;
               break;
         }
         return _loc2_;
      }
      
      private function parseStream() : void {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         this._queryableField = new Vector.<String>();
         this._searchFieldIndex = new Dictionary();
         this._searchFieldType = new Dictionary();
         this._searchFieldCount = new Dictionary();
         var _loc1_:int = this._stream.readInt();
         var _loc2_:uint = Object(this._stream).position + _loc1_ + 4;
         while(_loc1_)
         {
            _loc3_ = this._stream.bytesAvailable;
            _loc4_ = this._stream.readUTF();
            this._queryableField.push(_loc4_);
            this._searchFieldIndex[_loc4_] = this._stream.readInt() + _loc2_;
            this._searchFieldType[_loc4_] = this._stream.readInt();
            this._searchFieldCount[_loc4_] = this._stream.readInt();
            _loc1_ = _loc1_ - (_loc3_ - this._stream.bytesAvailable);
         }
      }
   }
}
