package com.ankamagames.jerakine.json
{
   import __AS3__.vec.*;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public class JSONEncoder extends Object
   {
      
      public function JSONEncoder(value:*, pMaxDepth:uint=0, pShowObjectType:Boolean=false) {
         super();
         this._depthLimit = pMaxDepth;
         this._showObjectType = pShowObjectType;
         this.jsonString = this.convertToString(value);
      }
      
      private var _depthLimit:uint = 0;
      
      private var _showObjectType:Boolean = false;
      
      private var jsonString:String;
      
      public function getString() : String {
         return this.jsonString;
      }
      
      private function convertToString(value:*, depth:int=0) : String {
         if((!(this._depthLimit == 0)) && (depth > this._depthLimit))
         {
            return "";
         }
         if(value is String)
         {
            return this.escapeString(value as String);
         }
         if(value is Number)
         {
            return isFinite(value as Number)?value.toString():"null";
         }
         if(value is Boolean)
         {
            return value?"true":"false";
         }
         if((value is Array) || (value is Vector.<int>) || (value is Vector.<uint>) || (value is Vector.<String>) || (value is Vector.<Boolean>) || (value is Vector.<*>) || (value is Dictionary))
         {
            return this.arrayToString(value,depth + 1);
         }
         if((value is Object) && (!(value == null)))
         {
            return this.objectToString(value,depth + 1);
         }
         return "null";
      }
      
      private function escapeString(str:String) : String {
         var ch:String = null;
         var hexCode:String = null;
         var zeroPad:String = null;
         var s:String = "";
         var len:Number = str.length;
         var i:int = 0;
         while(i < len)
         {
            ch = str.charAt(i);
            switch(ch)
            {
               case "\"":
                  s = s + "\\\"";
                  break;
               case "\\":
                  s = s + "\\\\";
                  break;
               case "\b":
                  s = s + "\\b";
                  break;
               case "\f":
                  s = s + "\\f";
                  break;
               case "\n":
                  s = s + "\\n";
                  break;
               case "\r":
                  s = s + "\\r";
                  break;
               case "\t":
                  s = s + "\\t";
                  break;
            }
            i++;
         }
         return "\"" + s + "\"";
      }
      
      private function arrayToString(a:*, depth:int) : String {
         var value:* = undefined;
         if((!(this._depthLimit == 0)) && (depth > this._depthLimit))
         {
            return "";
         }
         var s:String = "";
         for each (value in a)
         {
            if(s.length > 0)
            {
               s = s + ",";
            }
            s = s + this.convertToString(value);
         }
         return "[" + s + "]";
      }
      
      private function objectToString(o:Object, depth:int) : String {
         var className:Array = null;
         var value:Object = null;
         var key:String = null;
         var v:XML = null;
         if((!(this._depthLimit == 0)) && (depth > this._depthLimit))
         {
            return "";
         }
         var s:String = "";
         var classInfo:XML = describeType(o);
         if(classInfo.@name.toString() == "Object")
         {
            for (key in o)
            {
               value = o[key];
               if(!(value is Function))
               {
                  if(s.length > 0)
                  {
                     s = s + ",";
                  }
                  s = s + (this.escapeString(key) + ":" + this.convertToString(value));
               }
            }
         }
         else
         {
            for each (v in classInfo..*.((name() == "variable") || (name() == "accessor") && (attribute("access").charAt(0) == "r")))
            {
               if(!((v.metadata) && (v.metadata.(@name == "Transient").length() > 0)))
               {
                  if(s.length > 0)
                  {
                     s = s + ",";
                  }
                  try
                  {
                     s = s + (this.escapeString(v.@name.toString()) + ":" + this.convertToString(o[v.@name]));
                  }
                  catch(e:Error)
                  {
                     continue;
                  }
               }
            }
         }
         if(this._showObjectType)
         {
            className = getQualifiedClassName(o).split("::");
         }
         if(className != null)
         {
            return "{" + this.escapeString("type") + ":" + this.escapeString(className.pop()) + ", " + this.escapeString("value") + ":{" + s + "}}";
         }
         return "{" + s + "}";
      }
   }
}
