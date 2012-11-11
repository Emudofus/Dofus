package com.ankamagames.berilia.api
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.errors.*;
    import flash.utils.*;

    dynamic public class ReadOnlyObject extends Proxy implements Secure
    {
        private var _object:Object;
        private var _getQualifiedClassName:String;
        private var _properties:Array;
        private var _simplyfiedQualifiedClassName:String;
        private var _testHaveOP:Boolean = true;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        private static const _createdObjectProperties:Dictionary = new Dictionary(true);
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(ReadOnlyObject));
        private static const _readOnlyObjectList:Dictionary = new Dictionary(true);
        private static const _readOnlyObjectExist:Dictionary = new Dictionary(true);

        public function ReadOnlyObject(param1:Object, param2:Object)
        {
            SecureCenter.checkAccessKey(param2);
            this._object = param1;
            this._getQualifiedClassName = getQualifiedClassName(param1);
            if (!(this._properties && (param1 is Array || param1 is Vector.<null>)))
            {
                this._properties = DescribeTypeCache.getVariables(this._object);
                if (_createdObjectProperties[this._getQualifiedClassName])
                {
                    return;
                }
                _createdObjectProperties[this._getQualifiedClassName] = DescribeTypeCache.getVariables(this._object);
                this._properties = _createdObjectProperties[this._getQualifiedClassName];
            }
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function get simplyfiedQualifiedClassName() : String
        {
            var _loc_1:* = null;
            if (this._simplyfiedQualifiedClassName == null)
            {
                _loc_1 = this._getQualifiedClassName.split("::");
                this._simplyfiedQualifiedClassName = _loc_1[(_loc_1.length - 1)];
            }
            return this._simplyfiedQualifiedClassName;
        }// end function

        public function getObject(param1:Object)
        {
            if (param1 != SecureCenter.ACCESS_KEY)
            {
                throw new IllegalOperationError();
            }
            return this._object;
        }// end function

        override function callProperty(param1, ... args)
        {
            args = new activation;
            var haveOP:Boolean;
            var name:* = param1;
            var rest:* = args;
            switch(QName().localName)
            {
                case "toString":
                {
                    try
                    {
                        if (!this._testHaveOP)
                        {
                            haveOP = this._object.hasOwnProperty("toString");
                        }
                    }
                    catch (e:Error)
                    {
                        haveOP;
                        _testHaveOP = false;
                    }
                    if ()
                    {
                        return CallWithParameters.callR(this._object.toString, );
                    }
                    return this._object + "";
                }
                case "hasOwnProperty":
                {
                    return CallWithParameters.callR(this._object.hasOwnProperty, );
                }
                case "propertyIsEnumerable":
                {
                    return CallWithParameters.callR(this._object.propertyIsEnumerable, );
                }
                case "indexOf":
                {
                    if (this._object is Dictionary || this._object is Array || this._object is Vector.<null> || this._object is Vector.<uint> || this._object is Vector.<int> || this._object is Vector.<Number> || this._object is Vector.<Boolean>)
                    {
                        return CallWithParameters.callR(this._object.indexOf, );
                    }
                    _log.error("Try to use \'indexOf\' method on a simple ReadOnlyObject.");
                    return null;
                }
                default:
                {
                    break;
                }
            }
            var e:* = new Error();
            if (getStackTrace())
            {
                _log.error("Cannot call method on ReadOnlyObject : " +  + ", " + getStackTrace().split("at ")[2]);
            }
            else
            {
                _log.error("Cannot call method on ReadOnlyObject : " +  + ", no stack trace available");
            }
            return null;
        }// end function

        override function getProperty(param1)
        {
            if (this._object[param1] === null)
            {
                return null;
            }
            var _loc_2:* = this._object[param1];
            switch(true)
            {
                case _loc_2 is uint:
                case _loc_2 is int:
                case _loc_2 is Number:
                case _loc_2 is String:
                case _loc_2 is Boolean:
                {
                    return _loc_2;
                }
                case _loc_2 == null:
                case _loc_2 == undefined:
                case _loc_2 is Secure:
                {
                    return _loc_2;
                }
                case _loc_2 is ISecurizable:
                {
                    return (_loc_2 as ISecurizable).getSecureObject();
                }
                default:
                {
                    break;
                }
            }
            return SecureCenter.secure(_loc_2);
        }// end function

        override function nextNameIndex(param1:int) : int
        {
            var _loc_2:* = undefined;
            if (param1 == 0 && (this._object is Dictionary || this._object is Array || this._object is Vector.<null> || this._object is Vector.<uint> || this._object is Vector.<int> || this._object is Vector.<Number> || this._object is Vector.<Boolean>))
            {
                this._properties = new Array();
                for (_loc_2 in this._object)
                {
                    
                    this._properties.push(_loc_2);
                }
            }
            if (param1 < this._properties.length)
            {
                return (param1 + 1);
            }
            return 0;
        }// end function

        override function nextValue(param1:int)
        {
            var _loc_2:* = this._properties[(param1 - 1)];
            var _loc_3:* = this._object[_loc_2];
            switch(true)
            {
                case _loc_3 == null:
                case _loc_3 is uint:
                case _loc_3 is int:
                case _loc_3 is Number:
                case _loc_3 is String:
                case _loc_3 is Boolean:
                case _loc_3 == undefined:
                case _loc_3 is Secure:
                {
                    return _loc_3;
                }
                case _loc_3 is ISecurizable:
                {
                    return (_loc_3 as ISecurizable).getSecureObject();
                }
                default:
                {
                    break;
                }
            }
            return SecureCenter.secure(_loc_3);
        }// end function

        override function nextName(param1:int) : String
        {
            return this._properties[(param1 - 1)];
        }// end function

        override function setProperty(param1, param2) : void
        {
            if (this._object is ICustomSecureObject && DescribeTypeCache.getTags(this._object)[param1.localName]["Untrusted"])
            {
                this._object[param1] = param2;
                return;
            }
            var _loc_3:* = new Error();
            if (_loc_3.getStackTrace())
            {
                _log.error("Cannot set property on ReadOnlyObject : " + param1 + ", " + _loc_3.getStackTrace().split("at ")[2]);
            }
            else
            {
                _log.error("Cannot set property on ReadOnlyObject : " + param1 + ", no stack trace available");
            }
            return;
        }// end function

        override function hasProperty(param1) : Boolean
        {
            return this._object.hasOwnProperty(param1);
        }// end function

        public static function create(param1:Object) : ReadOnlyObject
        {
            var _loc_3:* = undefined;
            if (param1 is ReadOnlyObject)
            {
                return param1 as ReadOnlyObject;
            }
            if (_readOnlyObjectExist[param1])
            {
                for (_loc_3 in _readOnlyObjectList)
                {
                    
                    if (_loc_3 && _loc_3._object == param1)
                    {
                        return _loc_3;
                    }
                }
            }
            var _loc_2:* = new ReadOnlyObject(param1, SecureCenter.ACCESS_KEY);
            _readOnlyObjectList[_loc_2] = true;
            _readOnlyObjectExist[param1] = true;
            return _loc_2;
        }// end function

    }
}
