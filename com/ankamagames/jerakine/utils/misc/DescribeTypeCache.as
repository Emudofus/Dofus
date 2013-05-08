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

      public static function typeDescription(o:Object, useCache:Boolean=true) : XML {
         if(!useCache)
         {
            return describeType(o);
         }
         var c:String = getQualifiedClassName(o);
         if(!_classDesc[c])
         {
            _classDesc[c]=describeType(o);
         }
         return _classDesc[c];
      }

      public static function getVariables(o:Object, onlyVar:Boolean=false, useCache:Boolean=true) : Array {
         var variables:Array = null;
         var description:XML = null;
         var variableNode:XML = null;
         var key:String = null;
         var accessorNode:XML = null;
         var className:String = getQualifiedClassName(o);
         if(className=="Object")
         {
            useCache=false;
         }
         if(useCache)
         {
            if((onlyVar)&&(_variables[className]))
            {
               return _variables[className];
            }
            if((!onlyVar)&&(_variablesAndAccessor[className]))
            {
               return _variablesAndAccessor[className];
            }
         }
         variables=new Array();
         description=typeDescription(o,useCache);
         if((description.@isDynamic.toString()=="true")||(o is Proxy))
         {
            try
            {
               for (key in o)
               {
                  variables.push(key);
               }
            }
            catch(e:Error)
            {
            }
         }
         for each (variableNode in description..variable)
         {
            variables.push(variableNode.@name.toString());
         }
         if(!onlyVar)
         {
            for each (accessorNode in description..accessor)
            {
               variables.push(accessorNode.@name.toString());
            }
         }
         if(useCache)
         {
            if(onlyVar)
            {
               _variables[className]=variables;
            }
            else
            {
               _variablesAndAccessor[className]=variables;
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
         _tags[className]=new Dictionary();
         var description:XML = typeDescription(o);
         for each (tagNode in description..metadata)
         {
            objectName=tagNode.parent().@name;
            if(!_tags[className][objectName])
            {
               _tags[className][objectName]=new Dictionary();
            }
            _tags[className][objectName][tagNode.@name.toString()]=true;
         }
         for each (node in description..variable)
         {
            objectName=node.@name;
            if(!_tags[className][objectName])
            {
               _tags[className][objectName]=new Dictionary();
            }
         }
         for each (node in description..method)
         {
            objectName=node.@name;
            if(!_tags[className][objectName])
            {
               _tags[className][objectName]=new Dictionary();
            }
         }
         return _tags[className];
      }


   }

}