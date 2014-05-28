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
   
   public dynamic class ReadOnlyObject extends Proxy implements Secure
   {
      
      public function ReadOnlyObject(o:Object, accessKey:Object) {
         super();
         SecureCenter.checkAccessKey(accessKey);
         this._object = o;
         this._getQualifiedClassName = getQualifiedClassName(o);
         if(!(this._properties && ((o is Array) || (o is Vector.<*>))))
         {
            this._properties = DescribeTypeCache.getVariables(this._object);
            if((_createdObjectProperties[this._getQualifiedClassName]) || (this._getQualifiedClassName == "Object"))
            {
               return;
            }
            _createdObjectProperties[this._getQualifiedClassName] = DescribeTypeCache.getVariables(this._object);
            this._properties = _createdObjectProperties[this._getQualifiedClassName];
         }
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary;
      
      private static const _createdObjectProperties:Dictionary;
      
      private static const _log:Logger;
      
      private static const _readOnlyObjectList:Dictionary;
      
      private static const _readOnlyObjectExist:Dictionary;
      
      public static function create(o:Object) : ReadOnlyObject {
         var roo:* = undefined;
         if(o is ReadOnlyObject)
         {
            return o as ReadOnlyObject;
         }
         if(_readOnlyObjectExist[o])
         {
            for(roo in _readOnlyObjectList)
            {
               if((roo) && (roo._object == o))
               {
                  return roo;
               }
            }
         }
         var newReadOnlyObject:ReadOnlyObject = new ReadOnlyObject(o,SecureCenter.ACCESS_KEY);
         _readOnlyObjectList[newReadOnlyObject] = true;
         _readOnlyObjectExist[o] = true;
         return newReadOnlyObject;
      }
      
      private var _object:Object;
      
      private var _getQualifiedClassName:String;
      
      private var _properties:Array;
      
      private var _simplyfiedQualifiedClassName:String;
      
      public function get simplyfiedQualifiedClassName() : String {
         var splitedClassName:Array = null;
         if(this._simplyfiedQualifiedClassName == null)
         {
            splitedClassName = this._getQualifiedClassName.split("::");
            this._simplyfiedQualifiedClassName = splitedClassName[splitedClassName.length - 1];
         }
         return this._simplyfiedQualifiedClassName;
      }
      
      public function getObject(accessKey:Object) : * {
         if(accessKey != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         else
         {
            return this._object;
         }
      }
      
      private var _testHaveOP:Boolean = true;
      
      override flash_proxy function callProperty(name:*, ... rest) : * {
         var haveOP:Boolean = false;
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
               if((this._object is Dictionary) || (this._object is Array) || (this._object is Vector.<*>) || (this._object is Vector.<uint>) || (this._object is Vector.<int>) || (this._object is Vector.<Number>) || (this._object is Vector.<Boolean>))
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
      
      override flash_proxy function getProperty(name:*) : * {
         if(this._object[name] === null)
         {
            return null;
         }
         var o:* = this._object[name];
         switch(true)
         {
            case o is uint:
            case o is int:
            case o is Number:
            case o is String:
            case o is Boolean:
               return o;
            case o == null:
            case o == undefined:
            case o is Secure:
               return o;
            case o is ISecurizable:
               return (o as ISecurizable).getSecureObject();
            default:
               return SecureCenter.secure(o);
         }
      }
      
      override flash_proxy function nextNameIndex(index:int) : int {
         var x:* = undefined;
         if((index == 0) && ((this._object is Dictionary) || (this._object is Array) || (this._object is Vector.<*>) || (this._object is Vector.<uint>) || (this._object is Vector.<int>) || (this._object is Vector.<Number>) || (this._object is Vector.<Boolean>)))
         {
            this._properties = new Array();
            for(x in this._object)
            {
               this._properties.push(x);
            }
         }
         if(index < this._properties.length)
         {
            return index + 1;
         }
         return 0;
      }
      
      override flash_proxy function nextValue(index:int) : * {
         var prop:* = this._properties[index - 1];
         var o:* = this._object[prop];
         switch(true)
         {
            case o == null:
            case o is uint:
            case o is int:
            case o is Number:
            case o is String:
            case o is Boolean:
            case o == undefined:
            case o is Secure:
               return o;
            case o is ISecurizable:
               return (o as ISecurizable).getSecureObject();
            default:
               return SecureCenter.secure(o);
         }
      }
      
      override flash_proxy function nextName(index:int) : String {
         return this._properties[index - 1];
      }
      
      override flash_proxy function setProperty(name:*, value:*) : void {
         if((this._object is ICustomSecureObject) && (DescribeTypeCache.getTags(this._object)[name.localName]["Untrusted"]))
         {
            this._object[name] = value;
            return;
         }
         var e:Error = new Error();
         if(e.getStackTrace())
         {
            _log.error("Cannot set property on ReadOnlyObject : " + name + ", " + e.getStackTrace().split("at ")[2]);
         }
         else
         {
            _log.error("Cannot set property on ReadOnlyObject : " + name + ", no stack trace available");
         }
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean {
         return this._object.hasOwnProperty(name);
      }
   }
}
