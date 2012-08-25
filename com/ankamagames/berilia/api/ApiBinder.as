package com.ankamagames.berilia.api
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.system.*;
    import flash.utils.*;

    public class ApiBinder extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ApiBinder));
        private static var _apiClass:Array = new Array();
        private static var _apiInstance:Array = new Array();
        private static var _apiData:Array = new Array();

        public function ApiBinder()
        {
            return;
        }// end function

        public static function addApi(param1:String, param2:Class) : void
        {
            _apiClass[param1] = param2;
            return;
        }// end function

        public static function removeApi(param1:String) : void
        {
            delete _apiClass[param1];
            return;
        }// end function

        public static function reset() : void
        {
            _apiInstance = [];
            _apiData = [];
            return;
        }// end function

        public static function addApiData(param1:String, param2) : void
        {
            _apiData[param1] = param2;
            return;
        }// end function

        public static function getApiData(param1:String)
        {
            return _apiData[param1];
        }// end function

        public static function removeApiData(param1:String) : void
        {
            _apiData[param1] = null;
            return;
        }// end function

        public static function initApi(param1:Object, param2:UiModule, param3:ApplicationDomain = null) : String
        {
            var _loc_4:Object = null;
            var _loc_6:XML = null;
            var _loc_7:* = undefined;
            var _loc_8:String = null;
            var _loc_9:String = null;
            addApiData("module", param2);
            var _loc_5:* = DescribeTypeCache.typeDescription(param1);
            for each (_loc_6 in _loc_5..variable)
            {
                
                for each (_loc_7 in _loc_6.metadata)
                {
                    
                    if (_loc_7.@name == "Module" && !UiModuleManager.getInstance().getModules()[_loc_7.arg.@value])
                    {
                        return _loc_7.arg.@value;
                    }
                }
                if (_loc_6.@type.toString().indexOf("d2api::") == 0)
                {
                    _loc_8 = _loc_6.@type.toString();
                    _loc_8 = _loc_8.substr(7, _loc_8.length - 10);
                    _loc_4 = getApiInstance(_loc_8, param2.trusted, param3);
                    param2.apiList.push(_loc_4);
                    param1[_loc_6.@name] = _loc_4;
                    continue;
                }
                for each (_loc_7 in _loc_6.metadata)
                {
                    
                    if (_loc_7.@name == "Api")
                    {
                        if (_loc_7.arg.@key == "name")
                        {
                            _loc_4 = getApiInstance(_loc_7.arg.@value, param2.trusted, param3);
                            param2.apiList.push(_loc_4);
                            param1[_loc_6.@name] = _loc_4;
                        }
                        else
                        {
                            throw new ApiError(param2.id + " module, unknow property \"" + _loc_6..metadata.arg.@key + "\" in Api tag");
                        }
                    }
                    if (_loc_7.@name == "Module")
                    {
                        if (_loc_7.arg.@key == "name")
                        {
                            _loc_9 = _loc_7.arg.@value;
                            if (!UiModuleManager.getInstance().getModules()[_loc_9])
                            {
                                throw new ApiError("Module " + _loc_9 + " does not exist (in " + param2.id + ")");
                            }
                            if (param2.trusted || _loc_9 == "Ankama_Common" || _loc_9 == "Ankama_ContextMenu" || !UiModuleManager.getInstance().getModules()[_loc_9].trusted)
                            {
                                param1[_loc_6.@name] = new ModuleReference(UiModule(UiModuleManager.getInstance().getModules()[_loc_9]).mainClass, SecureCenter.ACCESS_KEY);
                            }
                            else
                            {
                                throw new ApiError(param2.id + ", untrusted module cannot acces to trusted modules " + _loc_9);
                            }
                            continue;
                        }
                        throw new ApiError(param2.id + " module, unknow property \"" + _loc_7.arg.@key + "\" in Api tag");
                    }
                }
            }
            return null;
        }// end function

        private static function getApiInstance(param1:String, param2:Boolean, param3:ApplicationDomain) : Object
        {
            var apiDesc:XML;
            var api:Object;
            var apiRef:*;
            var instancied:Boolean;
            var meta:XML;
            var tag:String;
            var help:String;
            var boxing:Boolean;
            var method:XML;
            var accessor:XML;
            var metaData:XML;
            var metaData2:*;
            var name:* = param1;
            var trusted:* = param2;
            var sharedDefinition:* = param3;
            if (_apiInstance[name] && _apiInstance[name][trusted])
            {
                return _apiInstance[name][trusted];
            }
            if (_apiClass[name])
            {
                apiDesc = DescribeTypeCache.typeDescription(_apiClass[name]);
                api = new (sharedDefinition.getDefinition("d2api::" + name + "Api") as Class)();
                apiRef = _apiClass[name];
                instancied;
                var _loc_5:int = 0;
                var _loc_6:* = apiDesc..metadata;
                while (_loc_6 in _loc_5)
                {
                    
                    meta = _loc_6[_loc_5];
                    if (meta.@name == "InstanciedApi")
                    {
                        apiRef = new _apiClass[name];
                        instancied;
                        break;
                    }
                }
                var _loc_5:int = 0;
                var _loc_6:* = apiDesc..method;
                while (_loc_6 in _loc_5)
                {
                    
                    method = _loc_6[_loc_5];
                    boxing;
                    var _loc_7:int = 0;
                    var _loc_8:* = method.metadata;
                    while (_loc_8 in _loc_7)
                    {
                        
                        metaData = _loc_8[_loc_7];
                        if (metaData.@name == "Untrusted" || metaData.@name == "Trusted" || metaData.@name == "Deprecated")
                        {
                            tag = metaData.@name;
                            if (metaData.@name == "Deprecated")
                            {
                                var _loc_10:int = 0;
                                var _loc_11:* = metaData.arg;
                                var _loc_9:* = new XMLList("");
                                for each (_loc_12 in _loc_11)
                                {
                                    
                                    var _loc_13:* = _loc_11[_loc_10];
                                    with (_loc_11[_loc_10])
                                    {
                                        if (@key == "help")
                                        {
                                            _loc_9[_loc_10] = _loc_12;
                                        }
                                    }
                                }
                                help = _loc_9.@value;
                            }
                        }
                        if (metaData.@name == "NoBoxing")
                        {
                            boxing;
                        }
                    }
                    if (tag != "Untrusted" && tag != "Trusted" && tag != "Deprecated")
                    {
                        throw new ApiError("Missing tag [Untrusted / Trusted] before function \"" + method.@name + "\" in " + _apiClass[name]);
                    }
                    if (tag == "Untrusted" || (tag == "Trusted" || tag == "Deprecated") && trusted)
                    {
                        if (tag == "Deprecated")
                        {
                            api[method.@name] = createDepreciatedMethod(apiRef[method.@name], method.@name, help);
                        }
                        else if (boxing)
                        {
                            api[method.@name] = SecureCenter.secure(apiRef[method.@name]);
                        }
                        else
                        {
                            api[method.@name] = apiRef[method.@name];
                        }
                        continue;
                    }
                    api[method.@name] = GenericApiFunction.getRestrictedFunctionAccess(apiRef[method.@name]);
                }
                var _loc_5:int = 0;
                var _loc_6:* = apiDesc..accessor;
                while (_loc_6 in _loc_5)
                {
                    
                    accessor = _loc_6[_loc_5];
                    var _loc_7:int = 0;
                    var _loc_8:* = accessor.metadata;
                    while (_loc_8 in _loc_7)
                    {
                        
                        metaData2 = _loc_8[_loc_7];
                        if (metaData2.@name == "ApiData")
                        {
                            apiRef[accessor.@name] = _apiData[metaData2.arg.@value];
                            break;
                        }
                    }
                }
                if (!instancied)
                {
                    if (!_apiInstance[name])
                    {
                        _apiInstance[name] = new Array();
                    }
                    _apiInstance[name][trusted] = api;
                }
                return api;
            }
            else
            {
                _log.error("Api [" + name + "] is not avaible");
            }
            return null;
        }// end function

        private static function createDepreciatedMethod(param1:Function, param2:String, param3:String) : Function
        {
            var fct:* = param1;
            var fctName:* = param2;
            var help:* = param3;
            return function (... args)
            {
                args = new Error();
                if (args.getStackTrace())
                {
                    _log.fatal(fctName + " is a deprecated api function, called at " + args.getStackTrace().split("at ")[2] + (help.length ? (help + "\n") : ("")));
                }
                else
                {
                    _log.fatal(fctName + " is a deprecated api function. No stack trace available");
                }
                return CallWithParameters.callR(fct, args);
            }// end function
            ;
        }// end function

    }
}
