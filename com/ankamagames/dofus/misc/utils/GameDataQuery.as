package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.GameDataFileAccessor;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18nFileAccessor;
   import com.ankamagames.jerakine.enum.GameDataTypeEnum;
   import avmplus.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.dofus.misc.lists.GameDataList;
   import flash.utils.getDefinitionByName;
   import com.ankamagames.jerakine.logger.Log;
   
   public class GameDataQuery extends Object
   {
      
      public function GameDataQuery() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GameDataQuery));
      
      public static function getQueryableFields(param1:Class) : Vector.<String> {
         var param1:Class = checkPackage(param1);
         return GameDataFileAccessor.getInstance().getDataProcessor(param1["MODULE"]).getQueryableField();
      }
      
      public static function union(... rest) : Vector.<uint> {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         var _loc3_:Dictionary = new Dictionary();
         var _loc4_:uint = 0;
         while(_loc4_ < rest.length)
         {
            if(rest[_loc4_] != null)
            {
               _loc5_ = 0;
               while(_loc5_ < rest[_loc4_].length)
               {
                  _loc6_ = rest[_loc4_][_loc5_];
                  if(!_loc3_[_loc6_])
                  {
                     _loc2_.push(_loc6_);
                     _loc3_[_loc6_] = true;
                  }
                  _loc5_++;
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function intersection(... rest) : Vector.<uint> {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:Dictionary = null;
         var _loc8_:uint = 0;
         var _loc4_:Vector.<uint> = new Vector.<uint>();
         var _loc5_:Vector.<uint> = rest[_loc8_];
         var _loc6_:Dictionary = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < rest[0].length)
         {
            _loc6_[rest[0][_loc3_]] = rest[0][_loc3_];
            _loc3_++;
         }
         _loc8_ = 1;
         while(_loc8_ < rest.length)
         {
            _loc7_ = new Dictionary();
            _loc3_ = 0;
            while(_loc3_ < rest[_loc8_].length)
            {
               _loc2_ = rest[_loc8_][_loc3_];
               if(_loc6_[_loc2_])
               {
                  _loc7_[_loc2_] = _loc2_;
               }
               _loc3_++;
            }
            _loc6_ = _loc7_;
            _loc8_++;
         }
         for each (_loc2_ in _loc6_)
         {
            _loc4_.push(_loc2_);
         }
         return _loc4_;
      }
      
      public static function queryEquals(param1:Class, param2:String, param3:*) : Vector.<uint> {
         var param1:Class = checkPackage(param1);
         var param2:String = checkField(param1,param2);
         if(!param2)
         {
            return new Vector.<uint>();
         }
         var _loc4_:Vector.<uint> = GameDataFileAccessor.getInstance().getDataProcessor(param1["MODULE"]).queryEquals(param2,param3);
         var _loc5_:* = !(param3 is uint || param3 is int || param3 is Number || param3 is String || param3 is Boolean || param3 == null);
         if(_loc5_)
         {
            return union(_loc4_);
         }
         return _loc4_;
      }
      
      public static function queryString(param1:Class, param2:String, param3:String) : Vector.<uint> {
         var param1:Class = checkPackage(param1);
         var param2:String = checkField(param1,param2);
         if(!param2)
         {
            return new Vector.<uint>();
         }
         if(!param3)
         {
            throw new ArgumentError("value arg cannot be null");
         }
         else
         {
            return GameDataFileAccessor.getInstance().getDataProcessor(param1["MODULE"]).query(param2,getMatchStringFct(StringUtils.noAccent(param3).toLowerCase()));
         }
      }
      
      public static function queryGreaterThan(param1:Class, param2:String, param3:*) : Vector.<uint> {
         var param1:Class = checkPackage(param1);
         var param2:String = checkField(param1,param2);
         if(!param2)
         {
            return new Vector.<uint>();
         }
         return GameDataFileAccessor.getInstance().getDataProcessor(param1["MODULE"]).query(param2,getGreaterThanFct(param3));
      }
      
      public static function querySmallerThan(param1:Class, param2:String, param3:*) : Vector.<uint> {
         var param1:Class = checkPackage(param1);
         var param2:String = checkField(param1,param2);
         if(!param2)
         {
            return new Vector.<uint>();
         }
         return GameDataFileAccessor.getInstance().getDataProcessor(param1["MODULE"]).query(param2,getSmallerThanFct(param3));
      }
      
      public static function returnInstance(param1:Class, param2:Vector.<uint>) : Vector.<Object> {
         var _loc5_:* = undefined;
         var param1:Class = checkPackage(param1);
         var _loc3_:Vector.<Object> = new Vector.<Object>();
         var _loc4_:String = param1["MODULE"];
         var _loc6_:uint = 0;
         while(_loc6_ < param2.length)
         {
            _loc5_ = GameData.getObject(_loc4_,param2[_loc6_]);
            if(_loc5_ != null)
            {
               _loc3_.push(_loc5_);
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      public static function sort(param1:Class, param2:Vector.<uint>, param3:*, param4:*=true) : Vector.<uint> {
         var _loc5_:Vector.<String> = null;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var param1:Class = checkPackage(param1);
         if(!(param3 is String))
         {
            _loc5_ = new Vector.<String>();
            _loc6_ = 0;
            while(_loc6_ < param3.length)
            {
               _loc7_ = checkField(param1,param3[_loc6_]);
               if(_loc7_)
               {
                  _loc5_.push(_loc7_);
               }
               _loc6_++;
            }
            param3 = _loc5_;
         }
         else
         {
            param3 = checkField(param1,param3);
         }
         if(!param3 || param3.length == 0)
         {
            return new Vector.<uint>();
         }
         return GameDataFileAccessor.getInstance().getDataProcessor(param1["MODULE"]).sort(param3,param2,param4);
      }
      
      public static function sortI18n(param1:*, param2:*, param3:*) : * {
         param1.sort(getSortFunction(param1,param2,param3));
         return param1;
      }
      
      private static function getSortFunction(param1:*, param2:*, param3:*) : Function {
         var sortWay:Vector.<Number> = null;
         var indexes:Vector.<Dictionary> = null;
         var maxFieldIndex:uint = 0;
         var fieldName:String = null;
         var fieldIndex:Dictionary = null;
         var data:* = undefined;
         var datas:* = param1;
         var fieldNames:* = param2;
         var ascending:* = param3;
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
            fieldIndex = new Dictionary();
            for each (data in datas)
            {
               fieldIndex[data[fieldName]] = I18nFileAccessor.getInstance().getOrderIndex(data[fieldName]);
            }
            if(ascending.length < fieldNames.length)
            {
               ascending.push(true);
            }
            sortWay.push(ascending[i]?1:-1);
            indexes.push(fieldIndex);
            i++;
         }
         maxFieldIndex = fieldNames.length;
         return function(param1:*, param2:*):Number
         {
            var _loc3_:* = 0;
            while(_loc3_ < maxFieldIndex)
            {
               if(indexes[_loc3_][param1[fieldNames[_loc3_]]] < indexes[_loc3_][param2[fieldNames[_loc3_]]])
               {
                  return -sortWay[_loc3_];
               }
               if(indexes[_loc3_][param1[fieldNames[_loc3_]]] > indexes[_loc3_][param2[fieldNames[_loc3_]]])
               {
                  return sortWay[_loc3_];
               }
               _loc3_++;
            }
            return 0;
         };
      }
      
      private static function getMatchStringFct(param1:String) : Function {
         var pattern:String = param1;
         return function(param1:String):Boolean
         {
            return param1?!(param1.toLowerCase().indexOf(pattern) == -1):false;
         };
      }
      
      private static function getGreaterThanFct(param1:*) : Function {
         var cmpValue:* = param1;
         return function(param1:*):Boolean
         {
            return param1 > cmpValue;
         };
      }
      
      private static function getSmallerThanFct(param1:*) : Function {
         var cmpValue:* = param1;
         return function(param1:*):Boolean
         {
            return param1 < cmpValue;
         };
      }
      
      private static function checkField(param1:Class, param2:String) : String {
         var _loc3_:Vector.<String> = GameDataFileAccessor.getInstance().getDataProcessor(param1["MODULE"]).getQueryableField();
         if(_loc3_.indexOf(param2) == -1)
         {
            if(_loc3_.indexOf(param2 + "Id") == -1 || !(GameDataFileAccessor.getInstance().getDataProcessor(param1["MODULE"]).getFieldType(param2 + "Id") == GameDataTypeEnum.I18N))
            {
               _log.error("Field " + param2 + " not found in " + param1);
               return null;
            }
            param2 = param2 + "Id";
         }
         return param2;
      }
      
      private static function checkPackage(param1:Class) : Class {
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:Array = null;
         var _loc2_:Array = getQualifiedClassName(param1).split("::");
         var _loc3_:String = _loc2_[0];
         if(_loc3_ == "d2data")
         {
            _loc4_ = _loc2_[1];
            _loc5_ = DescribeTypeCache.typeDescription(GameDataList);
            for each (_loc6_ in _loc5_..constant)
            {
               _loc7_ = _loc6_.@type.toString().split("::");
               if(_loc7_[1] == _loc4_)
               {
                  return getDefinitionByName(_loc6_.@type.toString()) as Class;
               }
            }
         }
         else
         {
            if(_loc3_.indexOf("com.ankamagames.dofus.datacenter") != 0)
            {
               throw new ArgumentError(getQualifiedClassName(param1) + " is queryable (note found in datacenter package).");
            }
         }
         return param1;
      }
   }
}
