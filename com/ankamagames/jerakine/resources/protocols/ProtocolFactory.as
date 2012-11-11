package com.ankamagames.jerakine.resources.protocols
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.impl.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.utils.*;

    public class ProtocolFactory extends Object
    {
        private static var _customProtocols:Dictionary = new Dictionary();

        public function ProtocolFactory()
        {
            return;
        }// end function

        public static function getProtocol(param1:Uri) : IProtocol
        {
            var _loc_3:* = undefined;
            switch(param1.protocol)
            {
                case "http":
                {
                    return new HttpProtocol();
                }
                case "httpc":
                {
                    return new HttpCacheProtocol();
                }
                case "file":
                {
                    if (AirScanner.hasAir())
                    {
                        return new FileProtocol();
                    }
                    return new FileFlashProtocol();
                }
                case "zip":
                {
                    return new ZipProtocol();
                }
                case "upd":
                {
                    return new UpdaterProtocol();
                }
                case "pak":
                case "pak2":
                case "d2p":
                {
                    return new PakProtocol2();
                }
                case "d2pOld":
                {
                    return new PakProtocol();
                }
                default:
                {
                    break;
                }
            }
            var _loc_2:* = _customProtocols[param1.protocol] as Class;
            if (_loc_2)
            {
                _loc_3 = new _loc_2;
                if (!(_loc_3 is IProtocol))
                {
                    throw new ResourceError("Registered custom protocol for extension " + param1.protocol + " isn\'t an IProtocol class.");
                }
                return _loc_3;
            }
            throw new ArgumentError("Unknown protocol \'" + param1.protocol + "\' in the URI \'" + param1 + "\'.");
        }// end function

        public static function addProtocol(param1:String, param2:Class) : void
        {
            _customProtocols[param1] = param2;
            return;
        }// end function

        public static function removeProtocol(param1:String) : void
        {
            delete _customProtocols[param1];
            return;
        }// end function

    }
}
