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
      
      private static var _classDesc:Dictionary;
      
      private static var _variables:Dictionary;
      
      private static var _variablesAndAccessor:Dictionary;
      
      private static var _tags:Dictionary;
      
      private static var _consts:Dictionary;
      
      public static function typeDescription(o:Object, useCache:Boolean = true) : XML {
         if(!useCache)
         {
            return describeType(o);
         }
         var c:String = getQualifiedClassName(o);
         if(!_classDesc[c])
         {
            _classDesc[c] = describeType(o);
         }
         return _classDesc[c];
      }
      
      public static function getVariables(o:Object, onlyVar:Boolean = false, useCache:Boolean = true, skipUselessVars:Boolean = false) : Array {
         var variables:Array = null;
         var description:XML = null;
         var variableNode:XML = null;
         var key:String = null;
         var varName:String = null;
         var accessorNode:XML = null;
         var type:String = null;
         var className:String = getQualifiedClassName(o);
         if(className == "Object")
         {
            useCache = false;
         }
         if(useCache)
         {
            if((onlyVar) && (_variables[className]))
            {
               return _variables[className];
            }
            if((!onlyVar) && (_variablesAndAccessor[className]))
            {
               return _variablesAndAccessor[className];
            }
         }
         variables = new Array();
         description = typeDescription(o,useCache);
         if((description.@isDynamic.toString() == "true") || (o is Proxy))
         {
            try
            {
               for(key in o)
               {
                  variables.push(key);
               }
            }
            catch(e:Error)
            {
            }
         }
         for each(variableNode in description..variable)
         {
            varName = variableNode.@name.toString();
            if((!(varName == "MEMORY_LOG")) && (!(varName == "FLAG")) && (varName.indexOf("PATTERN") == -1) && (varName.indexOf("OFFSET") == -1))
            {
               variables.push(varName);
            }
         }
         if(!onlyVar)
         {
            for each(accessorNode in description..accessor)
            {
               if(skipUselessVars)
               {
                  if(accessorNode.@access.toString() != "readOnly")
                  {
                     type = accessorNode.@type.toString();
                     if((type == "uint") || (type == "int") || (type == "Number") || (type == "String") || (type == "Boolean"))
                     {
                        variables.push(accessorNode.@name.toString());
                     }
                  }
               }
               else
               {
                  variables.push(accessorNode.@name.toString());
               }
            }
         }
         if(useCache)
         {
            if(onlyVar)
            {
               _variables[className] = variables;
            }
            else
            {
               _variablesAndAccessor[className] = variables;
            }
         }
         return variables;
      }
      
      public static function getTags(o:Object) : Dictionary {
         var tagNode:XML = null;
         var node:XML = null;
         var objectName:String = null;
         var className:String = getQualifiedClassName(o);
         if(_tags[className])
         {
            return _tags[className];
         }
         _tags[className] = new Dictionary();
         var description:XML = typeDescription(o);
         for each(tagNode in description..metadata)
         {
            objectName = tagNode.parent().@name;
            if(!_tags[className][objectName])
            {
               _tags[className][objectName] = new Dictionary();
            }
            _tags[className][objectName][tagNode.@name.toString()] = true;
         }
         for each(node in description..variable)
         {
            objectName = node.@name;
            if(!_tags[className][objectName])
            {
               _tags[className][objectName] = new Dictionary();
            }
         }
         for each(node in description..method)
         {
            objectName = node.@name;
            if(!_tags[className][objectName])
            {
               _tags[className][objectName] = new Dictionary();
            }
         }
         return _tags[className];
      }
      
      public static function getConstants(o:Object) : Dictionary {
         var cst:XML = null;
         var className:String = getQualifiedClassName(o);
         if(_consts[className])
         {
            return _consts[className];
         }
         _consts[className] = new Dictionary();
         var description:XML = typeDescription(o);
         for each(cst in description..constant)
         {
            _consts[className][cst.@name.toString()] = cst.@type.toString();
         }
         return _consts[className];
      }
      
      public static function getConstantName(type:Class, value:*) : String {
         var constName:String = null;
         var constants:Dictionary = getConstants(type);
         for(constName in constants)
         {
            if(type[constName] === value)
            {
               return constName;
            }
         }
         return null;
      }
   }
}
