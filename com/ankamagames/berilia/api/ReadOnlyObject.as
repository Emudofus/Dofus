package com.ankamagames.berilia.api
{
   import flash.utils.Proxy;
   import com.ankamagames.jerakine.interfaces.Secure;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.errors.IllegalOperationError;
   import flash.utils.flash_proxy;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.interfaces.ISecurizable;
   import com.ankamagames.jerakine.interfaces.ICustomSecureObject;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   
   use namespace flash_proxy;
   
   public dynamic class ReadOnlyObject extends Proxy implements Secure
   {
      
      public function ReadOnlyObject(param1:Object, param2:Object) {
         super();
         SecureCenter.checkAccessKey(param2);
         this._object = param1;
         this._getQualifiedClassName = getQualifiedClassName(param1);
         if(!((this._properties) && (param1 is Array || param1 is Vector.<*>)))
         {
            this._properties = DescribeTypeCache.getVariables(this._object);
            if((_createdObjectProperties[this._getQualifiedClassName]) || this._getQualifiedClassName == "Object")
            {
               return;
            }
            _createdObjectProperties[this._getQualifiedClassName] = DescribeTypeCache.getVariables(this._object);
            this._properties = _createdObjectProperties[this._getQualifiedClassName];
         }
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private static const _createdObjectProperties:Dictionary = new Dictionary(true);
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ReadOnlyObject));
      
      private static const _readOnlyObjectList:Dictionary = new Dictionary(true);
      
      private static const _readOnlyObjectExist:Dictionary = new Dictionary(true);
      
      public static function create(param1:Object) : ReadOnlyObject {
         var _loc3_:* = undefined;
         if(param1 is ReadOnlyObject)
         {
            return param1 as ReadOnlyObject;
         }
         if(_readOnlyObjectExist[param1])
         {
            for (_loc3_ in _readOnlyObjectList)
            {
               if((_loc3_) && _loc3_._object == param1)
               {
                  return _loc3_;
               }
            }
         }
         var _loc2_:ReadOnlyObject = new ReadOnlyObject(param1,SecureCenter.ACCESS_KEY);
         _readOnlyObjectList[_loc2_] = true;
         _readOnlyObjectExist[param1] = true;
         return _loc2_;
      }
      
      private var _object:Object;
      
      private var _getQualifiedClassName:String;
      
      private var _properties:Array;
      
      private var _simplyfiedQualifiedClassName:String;
      
      public function get simplyfiedQualifiedClassName() : String {
         var _loc1_:Array = null;
         if(this._simplyfiedQualifiedClassName == null)
         {
            _loc1_ = this._getQualifiedClassName.split("::");
            this._simplyfiedQualifiedClassName = _loc1_[_loc1_.length-1];
         }
         return this._simplyfiedQualifiedClassName;
      }
      
      public function getObject(param1:Object) : * {
         if(param1 != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         else
         {
            return this._object;
         }
      }
      
      private var _testHaveOP:Boolean = true;
      
      override flash_proxy function callProperty(param1:*, ... rest) : * {
         var haveOP:Boolean = false;
         var name:* = param1;
         switch(QName(name).localName)
         {
            case "toString":
               try
               {
                  if(!this._testHaveOP)
                  {
                     haveOP = this._object.hasOwnProperty("toString");
                  }
               }
               catch(e:Error)
               {
                  haveOP = false;
                  _testHaveOP = false;
               }
               if(haveOP)
               {
                  return CallWithParameters.callR(this._object.toString,rest);
               }
               return this._object + "";
            case "getBounds":
               return this._object[name](SecureCenter.unsecure(rest[0]));
            case "hasOwnProperty":
               return CallWithParameters.callR(this._object.hasOwnProperty,rest);
            case "propertyIsEnumerable":
               return CallWithParameters.callR(this._object.propertyIsEnumerable,rest);
            case "indexOf":
               if(this._object is Dictionary || this._object is Array || this._object is Vector.<*> || this._object is Vector.<uint> || this._object is Vector.<int> || this._object is Vector.<Number> || this._object is Vector.<Boolean>)
               {
                  return CallWithParameters.callR(this._object.indexOf,rest);
               }
               _log.error("Try to use \'indexOf\' method on a simple ReadOnlyObject.");
               return null;
            default:
               e = new Error();
               if(e.getStackTrace())
               {
                  _log.error("Cannot call method on ReadOnlyObject : " + name + ", " + e.getStackTrace().split("at ")[2]);
               }
               else
               {
                  _log.error("Cannot call method on ReadOnlyObject : " + name + ", no stack trace available");
               }
               return null;
         }
      }
      
      override flash_proxy function getProperty(param1:*) : * {
         if(this._object[param1] === null)
         {
            return null;
         }
         var _loc2_:* = this._object[param1];
         switch(true)
         {
            case _loc2_ is uint:
            case _loc2_ is int:
            case _loc2_ is Number:
            case _loc2_ is String:
            case _loc2_ is Boolean:
               return _loc2_;
            case _loc2_ == null:
            case _loc2_ == undefined:
            case _loc2_ is Secure:
               return _loc2_;
            case _loc2_ is ISecurizable:
               return (_loc2_ as ISecurizable).getSecureObject();
            default:
               return SecureCenter.secure(_loc2_);
         }
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int {
         var _loc2_:* = undefined;
         if(param1 == 0 && (this._object is Dictionary || this._object is Array || this._object is Vector.<*> || this._object is Vector.<uint> || this._object is Vector.<int> || this._object is Vector.<Number> || this._object is Vector.<Boolean>))
         {
            this._properties = new Array();
            for (_loc2_ in this._object)
            {
               this._properties.push(_loc2_);
            }
         }
         if(param1 < this._properties.length)
         {
            return param1 + 1;
         }
         return 0;
      }
      
      override flash_proxy function nextValue(param1:int) : * {
         var _loc2_:* = this._properties[param1-1];
         var _loc3_:* = this._object[_loc2_];
         switch(true)
         {
            case _loc3_ == null:
            case _loc3_ is uint:
            case _loc3_ is int:
            case _loc3_ is Number:
            case _loc3_ is String:
            case _loc3_ is Boolean:
            case _loc3_ == undefined:
            case _loc3_ is Secure:
               return _loc3_;
            case _loc3_ is ISecurizable:
               return (_loc3_ as ISecurizable).getSecureObject();
            default:
               return SecureCenter.secure(_loc3_);
         }
      }
      
      override flash_proxy function nextName(param1:int) : String {
         return this._properties[param1-1];
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void {
         if(this._object is ICustomSecureObject && (DescribeTypeCache.getTags(this._object)[param1.localName]["Untrusted"]))
         {
            this._object[param1] = param2;
            return;
         }
         var _loc3_:Error = new Error();
         if(_loc3_.getStackTrace())
         {
            _log.error("Cannot set property on ReadOnlyObject : " + param1 + ", " + _loc3_.getStackTrace().split("at ")[2]);
         }
         else
         {
            _log.error("Cannot set property on ReadOnlyObject : " + param1 + ", no stack trace available");
         }
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean {
         return this._object.hasOwnProperty(param1);
      }
   }
}
