package com.ankamagames.jerakine.json
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public class JSONEncoder extends Object
   {
      
      public function JSONEncoder(param1:*, param2:uint=0, param3:Boolean=false) {
         super();
         this._depthLimit = param2;
         this._showObjectType = param3;
         this.jsonString = this.convertToString(param1);
      }
      
      private var _depthLimit:uint = 0;
      
      private var _showObjectType:Boolean = false;
      
      private var jsonString:String;
      
      public function getString() : String {
         return this.jsonString;
      }
      
      private function convertToString(param1:*, param2:int=0) : String {
         if(!(this._depthLimit == 0) && param2 > this._depthLimit)
         {
            return "";
         }
         if(param1 is String)
         {
            return this.escapeString(param1 as String);
         }
         if(param1 is Number)
         {
            return isFinite(param1 as Number)?param1.toString():"null";
         }
         if(param1 is Boolean)
         {
            return param1?"true":"false";
         }
         if(param1 is Array || param1 is Vector.<int> || param1 is Vector.<uint> || param1 is Vector.<String> || param1 is Vector.<Boolean> || param1 is Vector.<*> || param1 is Dictionary)
         {
            return this.arrayToString(param1,param2 + 1);
         }
         if(param1 is Object && !(param1 == null))
         {
            return this.objectToString(param1,param2 + 1);
         }
         return "null";
      }
      
      private function escapeString(param1:String) : String {
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc2_:* = "";
         var _loc4_:Number = param1.length;
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = param1.charAt(_loc5_);
            switch(_loc3_)
            {
               case "\"":
                  _loc2_ = _loc2_ + "\\\"";
                  break;
               case "\\":
                  _loc2_ = _loc2_ + "\\\\";
                  break;
               case "\b":
                  _loc2_ = _loc2_ + "\\b";
                  break;
               case "\f":
                  _loc2_ = _loc2_ + "\\f";
                  break;
               case "\n":
                  _loc2_ = _loc2_ + "\\n";
                  break;
               case "\r":
                  _loc2_ = _loc2_ + "\\r";
                  break;
               case "\t":
                  _loc2_ = _loc2_ + "\\t";
                  break;
               default:
                  if(_loc3_ < " ")
                  {
                     _loc6_ = _loc3_.charCodeAt(0).toString(16);
                     _loc7_ = _loc6_.length == 2?"00":"000";
                     _loc2_ = _loc2_ + ("\\u" + _loc7_ + _loc6_);
                  }
                  else
                  {
                     _loc2_ = _loc2_ + _loc3_;
                  }
            }
            _loc5_++;
         }
         return "\"" + _loc2_ + "\"";
      }
      
      private function arrayToString(param1:*, param2:int) : String {
         var _loc4_:* = undefined;
         if(!(this._depthLimit == 0) && param2 > this._depthLimit)
         {
            return "";
         }
         var _loc3_:* = "";
         for each (_loc4_ in param1)
         {
            if(_loc3_.length > 0)
            {
               _loc3_ = _loc3_ + ",";
            }
            _loc3_ = _loc3_ + this.convertToString(_loc4_);
         }
         return "[" + _loc3_ + "]";
      }
      
      private function objectToString(param1:Object, param2:int) : String {
         var className:Array = null;
         var value:Object = null;
         var key:String = null;
         var v:XML = null;
         var o:Object = param1;
         var depth:int = param2;
         if(!(this._depthLimit == 0) && depth > this._depthLimit)
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
            for each (v in classInfo..*.(name() == "variable" || name() == "accessor" && attribute("access").charAt(0) == "r"))
            {
               if(!((v.metadata) && v.metadata.(@name == "Transient").length() > 0))
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
