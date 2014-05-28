package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.logger.Logger;
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
      
      protected static const _log:Logger;
      
      public static function getQueryableFields(target:Class) : Vector.<String> {
         var target:Class = checkPackage(target);
         return GameDataFileAccessor.getInstance().getDataProcessor(target["MODULE"]).getQueryableField();
      }
      
      public static function union(... idsVectors) : Vector.<uint> {
         var ind:uint = 0;
         var id:uint = 0;
         var result:Vector.<uint> = new Vector.<uint>();
         var added:Dictionary = new Dictionary();
         var i:uint = 0;
         while(i < idsVectors.length)
         {
            if(idsVectors[i] != null)
            {
               ind = 0;
               while(ind < idsVectors[i].length)
               {
                  id = idsVectors[i][ind];
                  if(!added[id])
                  {
                     result.push(id);
                     added[id] = true;
                  }
                  ind++;
               }
            }
            i++;
         }
         return result;
      }
      
      public static function intersection(... idsVectors) : Vector.<uint> {
         var id:uint = 0;
         var ind:uint = 0;
         var newMatch:Dictionary = null;
         var i:uint = 0;
         var result:Vector.<uint> = new Vector.<uint>();
         var ids:Vector.<uint> = idsVectors[i];
         var match:Dictionary = new Dictionary();
         ind = 0;
         while(ind < idsVectors[0].length)
         {
            match[idsVectors[0][ind]] = idsVectors[0][ind];
            ind++;
         }
         i = 1;
         while(i < idsVectors.length)
         {
            newMatch = new Dictionary();
            ind = 0;
            while(ind < idsVectors[i].length)
            {
               id = idsVectors[i][ind];
               if(match[id])
               {
                  newMatch[id] = id;
               }
               ind++;
            }
            match = newMatch;
            i++;
         }
         for each(id in match)
         {
            result.push(id);
         }
         return result;
      }
      
      public static function queryEquals(target:Class, fieldName:String, value:*) : Vector.<uint> {
         var target:Class = checkPackage(target);
         var fieldName:String = checkField(target,fieldName);
         if(!fieldName)
         {
            return new Vector.<uint>();
         }
         var result:Vector.<uint> = GameDataFileAccessor.getInstance().getDataProcessor(target["MODULE"]).queryEquals(fieldName,value);
         var iterable:Boolean = !((value is uint) || (value is int) || (value is Number) || (value is String) || (value is Boolean) || (value == null));
         if(iterable)
         {
            return union(result);
         }
         return result;
      }
      
      public static function queryString(target:Class, fieldName:String, value:String) : Vector.<uint> {
         var target:Class = checkPackage(target);
         var fieldName:String = checkField(target,fieldName);
         if(!fieldName)
         {
            return new Vector.<uint>();
         }
         if(!value)
         {
            throw new ArgumentError("value arg cannot be null");
         }
         else
         {
            return GameDataFileAccessor.getInstance().getDataProcessor(target["MODULE"]).query(fieldName,getMatchStringFct(StringUtils.noAccent(value).toLowerCase()));
         }
      }
      
      public static function queryGreaterThan(target:Class, fieldName:String, value:*) : Vector.<uint> {
         var target:Class = checkPackage(target);
         var fieldName:String = checkField(target,fieldName);
         if(!fieldName)
         {
            return new Vector.<uint>();
         }
         return GameDataFileAccessor.getInstance().getDataProcessor(target["MODULE"]).query(fieldName,getGreaterThanFct(value));
      }
      
      public static function querySmallerThan(target:Class, fieldName:String, value:*) : Vector.<uint> {
         var target:Class = checkPackage(target);
         var fieldName:String = checkField(target,fieldName);
         if(!fieldName)
         {
            return new Vector.<uint>();
         }
         return GameDataFileAccessor.getInstance().getDataProcessor(target["MODULE"]).query(fieldName,getSmallerThanFct(value));
      }
      
      public static function returnInstance(target:Class, ids:Vector.<uint>) : Vector.<Object> {
         var instance:* = undefined;
         var target:Class = checkPackage(target);
         var result:Vector.<Object> = new Vector.<Object>();
         var module:String = target["MODULE"];
         var i:uint = 0;
         while(i < ids.length)
         {
            instance = GameData.getObject(module,ids[i]);
            if(instance != null)
            {
               result.push(instance);
            }
            i++;
         }
         return result;
      }
      
      public static function sort(target:Class, ids:Vector.<uint>, fieldNames:*, ascending:* = true) : Vector.<uint> {
         var cleanedFieldNames:Vector.<String> = null;
         var i:uint = 0;
         var field:String = null;
         var target:Class = checkPackage(target);
         if(!(fieldNames is String))
         {
            cleanedFieldNames = new Vector.<String>();
            i = 0;
            while(i < fieldNames.length)
            {
               field = checkField(target,fieldNames[i]);
               if(field)
               {
                  cleanedFieldNames.push(field);
               }
               i++;
            }
            fieldNames = cleanedFieldNames;
         }
         else
         {
            fieldNames = checkField(target,fieldNames);
         }
         if((!fieldNames) || (fieldNames.length == 0))
         {
            return new Vector.<uint>();
         }
         return GameDataFileAccessor.getInstance().getDataProcessor(target["MODULE"]).sort(fieldNames,ids,ascending);
      }
      
      public static function sortI18n(datas:*, fields:*, ascending:*) : * {
         datas.sort(getSortFunction(datas,fields,ascending));
         return datas;
      }
      
      private static function getSortFunction(datas:*, fieldNames:*, ascending:*) : Function {
         var sortWay:Vector.<Number> = null;
         var indexes:Vector.<Dictionary> = null;
         var maxFieldIndex:uint = 0;
         var fieldName:String = null;
         var fieldIndex:Dictionary = null;
         var data:* = undefined;
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
            for each(data in datas)
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
         return function(t1:*, t2:*):Number
         {
            var fieldIndex:* = 0;
            while(fieldIndex < maxFieldIndex)
            {
               if(indexes[fieldIndex][t1[fieldNames[fieldIndex]]] < indexes[fieldIndex][t2[fieldNames[fieldIndex]]])
               {
                  return -sortWay[fieldIndex];
               }
               if(indexes[fieldIndex][t1[fieldNames[fieldIndex]]] > indexes[fieldIndex][t2[fieldNames[fieldIndex]]])
               {
                  return sortWay[fieldIndex];
               }
               fieldIndex++;
            }
            return 0;
         };
      }
      
      private static function getMatchStringFct(pattern:String) : Function {
         return function(str:String):Boolean
         {
            return str?!(str.toLowerCase().indexOf(pattern) == -1):false;
         };
      }
      
      private static function getGreaterThanFct(cmpValue:*) : Function {
         return function(value:*):Boolean
         {
            return value > cmpValue;
         };
      }
      
      private static function getSmallerThanFct(cmpValue:*) : Function {
         return function(value:*):Boolean
         {
            return value < cmpValue;
         };
      }
      
      private static function checkField(target:Class, name:String) : String {
         var fields:Vector.<String> = GameDataFileAccessor.getInstance().getDataProcessor(target["MODULE"]).getQueryableField();
         if(fields.indexOf(name) == -1)
         {
            if((fields.indexOf(name + "Id") == -1) || (!(GameDataFileAccessor.getInstance().getDataProcessor(target["MODULE"]).getFieldType(name + "Id") == GameDataTypeEnum.I18N)))
            {
               _log.error("Field " + name + " not found in " + target);
               return null;
            }
            name = name + "Id";
         }
         return name;
      }
      
      private static function checkPackage(target:Class) : Class {
         var className:String = null;
         var desc:XML = null;
         var constant:XML = null;
         var classInfo:Array = null;
         var tmp:Array = getQualifiedClassName(target).split("::");
         var packageName:String = tmp[0];
         if(packageName == "d2data")
         {
            className = tmp[1];
            desc = DescribeTypeCache.typeDescription(GameDataList);
            for each(constant in desc..constant)
            {
               classInfo = constant.@type.toString().split("::");
               if(classInfo[1] == className)
               {
                  return getDefinitionByName(constant.@type.toString()) as Class;
               }
            }
         }
         else if(packageName.indexOf("com.ankamagames.dofus.datacenter") != 0)
         {
            throw new ArgumentError(getQualifiedClassName(target) + " is queryable (note found in datacenter package).");
         }
         
         return target;
      }
   }
}
