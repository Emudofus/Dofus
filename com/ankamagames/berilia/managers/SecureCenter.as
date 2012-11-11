package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.api.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.errors.*;
    import flash.utils.*;

    public class SecureCenter extends Object
    {
        static var SharedSecureComponent:Class;
        static var SharedReadOnlyData:Class;
        static var DirectAccessObject:Class;
        public static const ACCESS_KEY:Object = new Object();
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(SecureCenter));

        public function SecureCenter()
        {
            return;
        }// end function

        public static function init(param1:Object, param2:Object, param3:Object) : void
        {
            SharedSecureComponent = param1 as Class;
            SharedReadOnlyData = param2 as Class;
            DirectAccessObject = param3 as Class;
            return;
        }// end function

        public static function destroy(param1) : void
        {
            switch(true)
            {
                case param1 is SharedSecureComponent:
                {
                    var _loc_2:* = SharedSecureComponent;
                    _loc_2.SharedSecureComponent["destroy"](param1, ACCESS_KEY);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function secure(param1, param2:Boolean = false)
        {
            var iDataCenter:*;
            var iModuleUtil:*;
            var target:* = param1;
            var trusted:* = param2;
            switch(true)
            {
                case target == null:
                case target is uint:
                case target is int:
                case target is Number:
                case target is String:
                case target is Boolean:
                case target == undefined:
                case target is Secure:
                case SharedSecureComponent != null && target is SharedSecureComponent:
                case SharedReadOnlyData != null && target is SharedReadOnlyData:
                {
                    return target;
                }
                case target is ISecurizable:
                {
                    return ISecurizable(target).getSecureObject();
                }
                case target is INetworkType:
                {
                    var _loc_4:* = SharedReadOnlyData;
                    return _loc_4.SharedReadOnlyData["create"](target, "d2network", ACCESS_KEY);
                }
                case target is IDataCenter:
                {
                    var _loc_4:* = SharedReadOnlyData;
                    iDataCenter = _loc_4.SharedReadOnlyData["create"](target, "d2data", ACCESS_KEY);
                    return iDataCenter;
                }
                case target is IModuleUtil:
                {
                    var _loc_4:* = DirectAccessObject;
                    iModuleUtil = _loc_4.DirectAccessObject["create"](target, "d2utils", ACCESS_KEY);
                    return iModuleUtil;
                }
                case target is UiRootContainer:
                {
                    var _loc_4:* = SharedSecureComponent;
                    return _loc_4.SharedSecureComponent["getSecureComponent"](target, trusted, target.uiModule.applicationDomain, ACCESS_KEY);
                }
                case target is GraphicContainer:
                {
                    var _loc_4:* = SharedSecureComponent;
                    return _loc_4.SharedSecureComponent["getSecureComponent"](target, trusted, target.getUi() ? (target.getUi().uiModule.applicationDomain) : (null), ACCESS_KEY);
                }
                case target is Function:
                {
                    return function (... args)
            {
                args = args.length;
                var _loc_3:* = 0;
                while (_loc_3 < args)
                {
                    
                    args[_loc_3] = unsecure(args[_loc_3]);
                    _loc_3 = _loc_3 + 1;
                }
                return secure(target.apply(null, args));
            }// end function
            ;
                }
                default:
                {
                    return ReadOnlyObject.create(target);
                    break;
                }
            }
        }// end function

        public static function secureContent(param1:Array, param2:Boolean = false) : Array
        {
            var _loc_4:* = undefined;
            var _loc_3:* = [];
            for (_loc_4 in param1)
            {
                
                _loc_3[_loc_4] = secure(param1[_loc_4], param2);
            }
            return _loc_3;
        }// end function

        public static function unsecure(param1)
        {
            var target:* = param1;
            switch(true)
            {
                case target is Secure && !(target is INoBoxing):
                case target is SharedSecureComponent:
                case target is SharedReadOnlyData:
                case target is DirectAccessObject:
                {
                    return target.getObject(ACCESS_KEY);
                }
                case target is Function:
                {
                    return function (... args)
            {
                args = args.length;
                var _loc_3:* = 0;
                while (_loc_3 < args)
                {
                    
                    args[_loc_3] = secure(args[_loc_3]);
                    _loc_3 = _loc_3 + 1;
                }
                var _loc_4:* = CallWithParameters.callR(target, args);
                return unsecure(_loc_4);
            }// end function
            ;
                }
                default:
                {
                    break;
                }
            }
            return target;
        }// end function

        public static function unsecureContent(param1:Array) : Array
        {
            var _loc_3:* = undefined;
            var _loc_2:* = [];
            for (_loc_3 in param1)
            {
                
                _loc_2[_loc_3] = unsecure(param1[_loc_3]);
            }
            return _loc_2;
        }// end function

        public static function checkAccessKey(param1:Object) : void
        {
            if (param1 != ACCESS_KEY)
            {
                throw new IllegalOperationError("Wrong access key");
            }
            return;
        }// end function

    }
}
