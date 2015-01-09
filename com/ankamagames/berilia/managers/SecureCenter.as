package com.ankamagames.berilia.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.handlers.FocusHandler;
    import com.ankamagames.jerakine.handlers.HumanInputHandler;
    import flash.geom.Point;
    import com.ankamagames.jerakine.interfaces.Secure;
    import com.ankamagames.jerakine.interfaces.ISecurizable;
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.interfaces.IModuleUtil;
    import flash.system.ApplicationDomain;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.api.ReadOnlyObject;
    import com.ankamagames.jerakine.interfaces.INoBoxing;
    import com.ankamagames.jerakine.utils.misc.CallWithParameters;
    import flash.errors.IllegalOperationError;

    public class SecureCenter 
    {

        protected static var SharedSecureComponent:Class;
        protected static var SharedReadOnlyData:Class;
        protected static var DirectAccessObject:Class;
        public static const ACCESS_KEY:Object = new Object();
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(SecureCenter));


        public static function init(sharedSecureComponent:Object, sharedReadOnlyData:Object, directAccessObject:Object):void
        {
            SharedSecureComponent = (sharedSecureComponent as Class);
            SharedReadOnlyData = (sharedReadOnlyData as Class);
            DirectAccessObject = (directAccessObject as Class);
            FocusHandler.getInstance().handler = HumanInputHandler.getInstance().handler;
        }

        public static function destroy(target:*):void
        {
            switch (true)
            {
                case (target is SharedSecureComponent):
                    var _local_2 = SharedSecureComponent;
                    (_local_2["destroy"](target, ACCESS_KEY));
                    return;
            };
        }

        public static function secure(target:*, trusted:Boolean=false)
        {
            var iDataCenter:* = undefined;
            var iModuleUtil:* = undefined;
            switch (true)
            {
                case (target == null):
                case (target is uint):
                case (target is int):
                case (target is Number):
                case (target is String):
                case (target is Boolean):
                case (target is Point):
                case (target == undefined):
                case (target is Secure):
                case ((!((SharedSecureComponent == null))) && ((target is SharedSecureComponent))):
                case ((!((SharedReadOnlyData == null))) && ((target is SharedReadOnlyData))):
                case ((!((DirectAccessObject == null))) && ((target is DirectAccessObject))):
                    return (target);
                case (target is ISecurizable):
                    return (ISecurizable(target).getSecureObject());
                case (target is INetworkType):
                    return (SharedReadOnlyData["create"](target, "d2network", ACCESS_KEY));
                case (target is IDataCenter):
                    iDataCenter = SharedReadOnlyData["create"](target, "d2data", ACCESS_KEY);
                    return (iDataCenter);
                case (target is IModuleUtil):
                    iModuleUtil = DirectAccessObject["create"](target, "d2utils", ACCESS_KEY);
                    return (iModuleUtil);
                case (target is UiRootContainer):
                    return (SharedSecureComponent["getSecureComponent"](target, trusted, ((target.uiModule) ? target.uiModule.applicationDomain : new ApplicationDomain()), ACCESS_KEY));
                case (target is GraphicContainer):
                    return (SharedSecureComponent["getSecureComponent"](target, trusted, ((target.getUi()) ? target.getUi().uiModule.applicationDomain : null), ACCESS_KEY));
                case (target is Function):
                    return (function (... args)
                    {
                        var nb:* = args.length;
                        var i:* = 0;
                        while (i < nb)
                        {
                            args[i] = unsecure(args[i]);
                            i++;
                        };
                        return (secure(target.apply(null, args)));
                    });
                default:
                    return (ReadOnlyObject.create(target));
            };
        }

        public static function secureContent(target:Array, trusted:Boolean=false):Array
        {
            var key:*;
            var result:Array = [];
            for (key in target)
            {
                result[key] = secure(target[key], trusted);
            };
            return (result);
        }

        public static function unsecure(target:*)
        {
            switch (true)
            {
                case (((target is Secure)) && (!((target is INoBoxing)))):
                case (target is SharedSecureComponent):
                case (target is SharedReadOnlyData):
                case (target is DirectAccessObject):
                    return (target.getObject(ACCESS_KEY));
                case (target is Function):
                    return (function (... args)
                    {
                        var nb:* = args.length;
                        var i:* = 0;
                        while (i < nb)
                        {
                            args[i] = secure(args[i]);
                            i++;
                        };
                        var result:* = CallWithParameters.callR(target, args);
                        return (unsecure(result));
                    });
            };
            return (target);
        }

        public static function unsecureContent(target:Array):Array
        {
            var key:*;
            var result:Array = [];
            for (key in target)
            {
                result[key] = unsecure(target[key]);
            };
            return (result);
        }

        public static function checkAccessKey(accessKey:Object):void
        {
            if (accessKey != ACCESS_KEY)
            {
                throw (new IllegalOperationError("Wrong access key"));
            };
        }


    }
}//package com.ankamagames.berilia.managers

