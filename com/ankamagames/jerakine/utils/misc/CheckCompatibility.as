package com.ankamagames.jerakine.utils.misc
{
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class CheckCompatibility extends Object
   {
      
      public function CheckCompatibility() {
         super();
      }
      
      private static var _cache:Dictionary = new Dictionary(true);
      
      public static function isCompatible(reference:Class, target:*, strict:Boolean=false, throwError:Boolean=true) : Boolean {
         var cacheKey:Class = null;
         var method:XML = null;
         var param:XML = null;
         if(target is Class)
         {
            cacheKey = target;
         }
         else
         {
            cacheKey = getDefinitionByName(getQualifiedClassName(target)) as Class;
         }
         if(!_cache[reference])
         {
            _cache[reference] = new Dictionary(true);
         }
         if(_cache[reference][cacheKey] != null)
         {
            if((throwError) && (!_cache[reference][cacheKey]))
            {
               throwErrorMsg(reference,target,strict);
            }
            return _cache[reference][cacheKey];
         }
         var referenceDesc:XML = DescribeTypeCache.typeDescription(reference);
         var targetDesc:XML = DescribeTypeCache.typeDescription(target);
         for each (method in referenceDesc..method)
         {
            if(!targetDesc..method.((@name == method.@name) && ((@returnType == method.@returnType) || (!strict) && (method.@returnType == "Object"))).length())
            {
               _cache[reference][cacheKey] = false;
               if(throwError)
               {
                  throwErrorMsg(reference,target,strict);
               }
               return false;
            }
            for each (param in method..parameter)
            {
               if(!targetDesc..method.(@name == method.@name)..parameter.((@index == param.@index) && (@type == param.@type) && (@optional == param.@optional)).length())
               {
                  _cache[reference][cacheKey] = false;
                  if(throwError)
                  {
                     throwErrorMsg(reference,target,strict);
                  }
                  return false;
               }
            }
         }
         _cache[reference][cacheKey] = true;
         return true;
      }
      
      public static function getIncompatibility(reference:Class, target:*, strict:Boolean=false) : String {
         var method:XML = null;
         var param:XML = null;
         var fct:String = null;
         var referenceDesc:XML = DescribeTypeCache.typeDescription(reference);
         var targetDesc:XML = DescribeTypeCache.typeDescription(target);
         var ok:Boolean = true;
         for each (method in referenceDesc..method)
         {
            fct = "public function " + method.@name + "(";
            if(!targetDesc..method.((@name == method.@name) && ((@returnType == method.@returnType) || (!strict) && (method.@returnType == "Object"))).length())
            {
               ok = false;
            }
            for each (param in method..parameter)
            {
               fct = fct + ((parseInt(param.@index) > 1?", ":"") + "param" + param.@index + " : " + param.@type);
               if(!targetDesc..method.(@name == method.@name)..parameter.((@index == param.@index) && (@type == param.@type) && (@optional == param.@optional)).length())
               {
                  ok = false;
               }
            }
            fct = fct + (") : " + method.@returnType);
            if(!ok)
            {
               return fct;
            }
         }
         return null;
      }
      
      private static function throwErrorMsg(reference:Class, target:*, strict:Boolean=false) : void {
         throw new Error(target + " don\'t implement correctly [" + getIncompatibility(reference,target) + "]");
      }
   }
}
