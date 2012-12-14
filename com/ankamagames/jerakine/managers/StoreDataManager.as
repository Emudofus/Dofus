package com.ankamagames.jerakine.managers
{
    import by.blooddy.crypto.*;
    import com.ankamagames.jerakine.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.net.*;
    import flash.utils.*;

    public class StoreDataManager extends Object
    {
        private var _aData:Array;
        private var _bStoreSequence:Boolean;
        private var _nCurrentSequenceNum:uint = 0;
        private var _aStoreSequence:Array;
        private var _aSharedObjectCache:Array;
        private var _aRegisteredClassAlias:Dictionary;
        private var _describeType:Function;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(StoreDataManager));
        private static var _self:StoreDataManager;

        public function StoreDataManager()
        {
            var oClass:Class;
            var className:String;
            var s:String;
            this._describeType = DescribeTypeCache.typeDescription;
            if (_self != null)
            {
                throw new SingletonError("DataManager is a singleton and should not be instanciated directly.");
            }
            this._bStoreSequence = false;
            this._aData = new Array();
            this._aSharedObjectCache = new Array();
            this._aRegisteredClassAlias = new Dictionary();
            var aClass:* = this.getData(JerakineConstants.DATASTORE_CLASS_ALIAS, "classAliasList");
            var nonVectorClass:Array;
            var vectorClass:Array;
            var _loc_2:* = 0;
            var _loc_3:* = aClass;
            while (_loc_3 in _loc_2)
            {
                
                s = _loc_3[_loc_2];
                className = Base64.decode(s);
                _log.logDirectly(new RegisterClassLogEvent(className));
                try
                {
                    oClass = Class(getDefinitionByName(className));
                    registerClassAlias(aClass[s], oClass);
                }
                catch (e:ReferenceError)
                {
                    _log.warn("Impossible de trouver la classe " + className);
                }
                this._aRegisteredClassAlias[className] = true;
            }
            return;
        }// end function

        public function getData(param1:DataStoreType, param2:String)
        {
            var _loc_3:* = null;
            switch(param1.location)
            {
                case DataStoreEnum.LOCATION_LOCAL:
                {
                }
                case DataStoreEnum.LOCATION_SERVER:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._aData[param1.category] != null)
            {
            }
            return;
        }// end function

        public function registerClass(param1, param2:Boolean = false, param3:Boolean = true) : void
        {
            var className:String;
            var sAlias:String;
            var aClassAlias:Array;
            var desc:Object;
            var key:String;
            var tmp:String;
            var leftBracePos:int;
            var oInstance:* = param1;
            var deepClassScan:* = param2;
            var keepClassInSo:* = param3;
            if (oInstance is IExternalizable)
            {
                throw new ArgumentError("Can\'t store a customized IExternalizable in a shared object.");
            }
            if (oInstance is Secure)
            {
                throw new ArgumentError("Can\'t store a Secure class");
            }
            if (this.isComplexType(oInstance))
            {
                className = getQualifiedClassName(oInstance);
                if (this._aRegisteredClassAlias[className] == null)
                {
                    sAlias = MD5.hash(className);
                    _log.logDirectly(new RegisterClassLogEvent(className));
                    try
                    {
                        registerClassAlias(sAlias, Class(getDefinitionByName(className)));
                        _log.warn("Register " + className);
                    }
                    catch (e:Error)
                    {
                        _aRegisteredClassAlias[className] = true;
                        _log.fatal("Impossible de trouver la classe " + className + " dans l\'application domain courant");
                        return;
                    }
                    if (keepClassInSo)
                    {
                        aClassAlias = this.getSetData(JerakineConstants.DATASTORE_CLASS_ALIAS, "classAliasList", new Array());
                        aClassAlias[Base64.encode(className)] = sAlias;
                        this.setData(JerakineConstants.DATASTORE_CLASS_ALIAS, "classAliasList", aClassAlias);
                    }
                    this._aRegisteredClassAlias[className] = true;
                }
                else
                {
                    return;
                }
            }
            if (deepClassScan)
            {
                if (oInstance is Dictionary || oInstance is Array || oInstance is Vector.<null> || oInstance is Vector.<uint>)
                {
                    desc = oInstance;
                    if (oInstance is Vector.<null>)
                    {
                        tmp = getQualifiedClassName(oInstance);
                        leftBracePos = tmp.indexOf("<");
                        tmp = tmp.substr((leftBracePos + 1), tmp.lastIndexOf(">") - leftBracePos - 1);
                        this.registerClass(new (getDefinitionByName(tmp) as Class)(), true, keepClassInSo);
                    }
                }
                else
                {
                    desc = this.scanType(oInstance);
                }
                var _loc_5:* = 0;
                var _loc_6:* = desc;
                while (_loc_6 in _loc_5)
                {
                    
                    key = _loc_6[_loc_5];
                    if (this.isComplexType(oInstance[key]))
                    {
                        this.registerClass(oInstance[key], true);
                    }
                    if (desc === oInstance)
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function getClass(param1:Object) : void
        {
            var _loc_3:* = undefined;
            var _loc_2:* = this._describeType(param1);
            this.registerClass(param1);
            for (_loc_3 in _loc_2..accessor)
            {
                
                if (this.isComplexType(_loc_3))
                {
                    this.getClass(_loc_3);
                }
            }
            return;
        }// end function

        public function setData(param1:DataStoreType, param2:String, param3, param4:Boolean = false) : Boolean
        {
            var _loc_5:* = null;
            if (this._aData[param1.category] == null)
            {
                this._aData[param1.category] = new Dictionary(true);
            }
            this._aData[param1.category][param2] = param3;
            if (param1.persistant)
            {
                switch(param1.location)
                {
                    case DataStoreEnum.LOCATION_LOCAL:
                    {
                        this.registerClass(param3, param4);
                        _loc_5 = this.getSharedObject(param1.category);
                        _loc_5.data[param2] = param3;
                        if (!this._bStoreSequence)
                        {
                            if (!_loc_5.flush())
                            {
                                return false;
                            }
                        }
                        else
                        {
                            this._aStoreSequence[param1.category] = param1;
                        }
                        return true;
                    }
                    case DataStoreEnum.LOCATION_SERVER:
                    {
                        return false;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return true;
        }// end function

        public function getSetData(param1:DataStoreType, param2:String, param3)
        {
            var _loc_4:* = this.getData(param1, param2);
            if (this.getData(param1, param2) != null)
            {
                return _loc_4;
            }
            this.setData(param1, param2, param3);
            return param3;
        }// end function

        public function startStoreSequence() : void
        {
            this._bStoreSequence = true;
            if (!this._nCurrentSequenceNum)
            {
                this._aStoreSequence = new Array();
            }
            var _loc_1:* = this;
            var _loc_2:* = this._nCurrentSequenceNum + 1;
            _loc_1._nCurrentSequenceNum = _loc_2;
            return;
        }// end function

        public function stopStoreSequence() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = this;
            _loc_3._nCurrentSequenceNum = this._nCurrentSequenceNum - 1;
            this._bStoreSequence = --this._nCurrentSequenceNum != 0;
            if (this._bStoreSequence)
            {
                return;
            }
            for (_loc_2 in this._aStoreSequence)
            {
                
                _loc_1 = this._aStoreSequence[_loc_2];
                switch(_loc_1.location)
                {
                    case DataStoreEnum.LOCATION_LOCAL:
                    {
                        this.getSharedObject(_loc_1.category).flush();
                        break;
                    }
                    case DataStoreEnum.LOCATION_SERVER:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            this._aStoreSequence = null;
            return;
        }// end function

        public function clear(param1:DataStoreType) : void
        {
            this._aData = new Array();
            var _loc_2:* = this.getSharedObject(param1.category);
            _loc_2.clear();
            _loc_2.flush();
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = this._aSharedObjectCache;
            do
            {
                
                _loc_1 = _loc_3[_loc_2];
                _loc_1.clear();
                try
                {
                    _loc_1.flush();
                    _loc_1.close();
                }
                catch (e:Error)
                {
                }
            }while (_loc_3 in _loc_2)
            this._aSharedObjectCache = [];
            _self = null;
            return;
        }// end function

        public function close(param1:DataStoreType) : void
        {
            switch(param1.location)
            {
                case DataStoreEnum.LOCATION_LOCAL:
                {
                    this._aSharedObjectCache[param1.category].close();
                    delete this._aSharedObjectCache[param1.category];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getSharedObject(param1:String) : CustomSharedObject
        {
            if (this._aSharedObjectCache[param1] != null)
            {
                return this._aSharedObjectCache[param1];
            }
            var _loc_2:* = CustomSharedObject.getLocal(param1);
            _loc_2.objectEncoding = ObjectEncoding.AMF3;
            this._aSharedObjectCache[param1] = _loc_2;
            return _loc_2;
        }// end function

        private function isComplexType(param1) : Boolean
        {
            switch(true)
            {
                case param1 is int:
                case param1 is uint:
                case param1 is Number:
                case param1 is Boolean:
                case param1 is Array:
                case param1 is String:
                case param1 == null:
                case param1 == undefined:
                {
                    return false;
                }
                default:
                {
                    return true;
                    break;
                }
            }
        }// end function

        private function isComplexTypeFromString(param1:String) : Boolean
        {
            var _loc_2:* = undefined;
            switch(param1)
            {
                case "int":
                case "uint":
                case "Number":
                case "Boolean":
                case "Array":
                case "String":
                {
                    return false;
                }
                default:
                {
                    _loc_2 = this._aRegisteredClassAlias[param1];
                    if (this._aRegisteredClassAlias[param1] === true)
                    {
                        return false;
                    }
                    return true;
                    break;
                }
            }
        }// end function

        private function scanType(param1) : Object
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = new Object();
            var _loc_3:* = this._describeType(param1);
            for each (_loc_4 in _loc_3..accessor)
            {
                
                if (this.isComplexTypeFromString(_loc_4.@type))
                {
                    _loc_2[_loc_4.@name] = true;
                }
            }
            for each (_loc_5 in _loc_3..variable)
            {
                
                if (this.isComplexTypeFromString(_loc_5.@type))
                {
                    _loc_2[_loc_5.@name] = true;
                }
            }
            return _loc_2;
        }// end function

        public static function getInstance() : StoreDataManager
        {
            if (_self == null)
            {
                _self = new StoreDataManager;
            }
            return _self;
        }// end function

    }
}
