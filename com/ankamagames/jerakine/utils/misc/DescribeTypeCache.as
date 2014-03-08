package com.ankamagames.jerakine.utils.misc
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Proxy;
   
   public class DescribeTypeCache extends Object
   {
      
      public function DescribeTypeCache() {
         super();
      }
      
      private static var _classDesc:Dictionary = new Dictionary();
      
      private static var _variables:Dictionary = new Dictionary();
      
      private static var _variablesAndAccessor:Dictionary = new Dictionary();
      
      private static var _tags:Dictionary = new Dictionary();
      
      private static var _consts:Dictionary = new Dictionary();
      
      public static function typeDescription(param1:Object, param2:Boolean=true) : XML {
         if(!param2)
         {
            return describeType(param1);
         }
         var _loc3_:String = getQualifiedClassName(param1);
         if(!_classDesc[_loc3_])
         {
            _classDesc[_loc3_] = describeType(param1);
         }
         return _classDesc[_loc3_];
      }
      
      public static function getVariables(param1:Object, param2:Boolean=false, param3:Boolean=true, param4:Boolean=false) : Array {
         var _loc6_:Array = null;
         var _loc7_:XML = null;
         var _loc8_:XML = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:XML = null;
         var _loc12_:String = null;
         var _loc5_:String = getQualifiedClassName(param1);
         if(_loc5_ == "Object")
         {
            param3 = false;
         }
         if(param3)
         {
            if((param2) && (_variables[_loc5_]))
            {
               return _variables[_loc5_];
            }
            if(!param2 && (_variablesAndAccessor[_loc5_]))
            {
               return _variablesAndAccessor[_loc5_];
            }
         }
         _loc6_ = new Array();
         _loc7_ = typeDescription(param1,param3);
         if(_loc7_.@isDynamic.toString() == "true" || param1 is Proxy)
         {
            try
            {
               for (_loc9_ in param1)
               {
                  _loc6_.push(_loc9_);
               }
            }
            catch(e:Error)
            {
            }
         }
         for each (_loc8_ in _loc7_..variable)
         {
            _loc10_ = _loc8_.@name.toString();
            if(!(_loc10_ == "MEMORY_LOG") && !(_loc10_ == "FLAG") && _loc10_.indexOf("PATTERN") == -1 && _loc10_.indexOf("OFFSET") == -1)
            {
               _loc6_.push(_loc10_);
            }
         }
         if(!param2)
         {
            for each (_loc11_ in _loc7_..accessor)
            {
               if(param4)
               {
                  if(_loc11_.@access.toString() != "readOnly")
                  {
                     _loc12_ = _loc11_.@type.toString();
                     if(_loc12_ == "uint" || _loc12_ == "int" || _loc12_ == "Number" || _loc12_ == "String" || _loc12_ == "Boolean")
                     {
                        _loc6_.push(_loc11_.@name.toString());
                     }
                  }
               }
               else
               {
                  _loc6_.push(_loc11_.@name.toString());
               }
            }
         }
         if(param3)
         {
            if(param2)
            {
               _variables[_loc5_] = _loc6_;
            }
            else
            {
               _variablesAndAccessor[_loc5_] = _loc6_;
            }
         }
         return _loc6_;
      }
      
      public static function getTags(param1:Object) : Dictionary {
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc2_:String = getQualifiedClassName(param1);
         if(_tags[_loc2_])
         {
            return _tags[_loc2_];
         }
         _tags[_loc2_] = new Dictionary();
         var _loc3_:XML = typeDescription(param1);
         for each (_loc4_ in _loc3_..metadata)
         {
            _loc6_ = _loc4_.parent().@name;
            if(!_tags[_loc2_][_loc6_])
            {
               _tags[_loc2_][_loc6_] = new Dictionary();
            }
            _tags[_loc2_][_loc6_][_loc4_.@name.toString()] = true;
         }
         for each (_loc5_ in _loc3_..variable)
         {
            _loc6_ = _loc5_.@name;
            if(!_tags[_loc2_][_loc6_])
            {
               _tags[_loc2_][_loc6_] = new Dictionary();
            }
         }
         for each (_loc5_ in _loc3_..method)
         {
            _loc6_ = _loc5_.@name;
            if(!_tags[_loc2_][_loc6_])
            {
               _tags[_loc2_][_loc6_] = new Dictionary();
            }
         }
         return _tags[_loc2_];
      }
      
      public static function getConstants(param1:Object) : Dictionary {
         var _loc4_:XML = null;
         var _loc2_:String = getQualifiedClassName(param1);
         if(_consts[_loc2_])
         {
            return _consts[_loc2_];
         }
         _consts[_loc2_] = new Dictionary();
         var _loc3_:XML = typeDescription(param1);
         for each (_loc4_ in _loc3_..constant)
         {
            _consts[_loc2_][_loc4_.@name.toString()] = _loc4_.@type.toString();
         }
         return _consts[_loc2_];
      }
      
      public static function getConstantName(param1:Class, param2:*) : String {
         var _loc4_:String = null;
         var _loc3_:Dictionary = getConstants(param1);
         for (_loc4_ in _loc3_)
         {
            if(param1[_loc4_] === param2)
            {
               return _loc4_;
            }
         }
         return null;
      }
   }
}
