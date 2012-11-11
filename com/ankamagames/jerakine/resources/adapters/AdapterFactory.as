package com.ankamagames.jerakine.resources.adapters
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.impl.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.files.*;
    import flash.utils.*;

    public class AdapterFactory extends Object
    {
        private var include_SimpleLoaderAdapter:SimpleLoaderAdapter = null;
        private static var _customAdapters:Dictionary = new Dictionary();

        public function AdapterFactory()
        {
            return;
        }// end function

        public static function getAdapter(param1:Uri) : IAdapter
        {
            var _loc_3:* = undefined;
            switch(param1.fileType)
            {
                case "xml":
                case "meta":
                case "dm":
                case "dt":
                {
                    return new XmlAdapter();
                }
                case "png":
                case "gif":
                case "jpg":
                case "jpeg":
                case "wdp":
                {
                    return new BitmapAdapter();
                }
                case "txt":
                case "css":
                {
                    return new TxtAdapter();
                }
                case "swf":
                {
                    return new SwfAdapter();
                }
                case "aswf":
                {
                    return new AdvancedSwfAdapter();
                }
                case "swl":
                {
                    return new SwlAdapter();
                }
                case "dx":
                {
                    return new DxAdapter();
                }
                case "zip":
                {
                    return new ZipAdapter();
                }
                case "mp3":
                {
                    return new MP3Adapter();
                }
                default:
                {
                    if (param1.subPath)
                    {
                        switch(FileUtils.getExtension(param1.path))
                        {
                            case "swf":
                            {
                                return new AdvancedSwfAdapter();
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    break;
                }
            }
            var _loc_2:* = _customAdapters[param1.fileType] as Class;
            if (_loc_2)
            {
                _loc_3 = new _loc_2;
                if (!(_loc_3 is IAdapter))
                {
                    throw new ResourceError("Registered custom adapter for extension " + param1.fileType + " isn\'t an IAdapter class.");
                }
                return _loc_3;
            }
            if (param1.fileType.substr(-1) == "s")
            {
                return new SignedFileAdapter();
            }
            return new BinaryAdapter();
        }// end function

        public static function addAdapter(param1:String, param2:Class) : void
        {
            _customAdapters[param1] = param2;
            return;
        }// end function

        public static function removeAdapter(param1:String) : void
        {
            delete _customAdapters[param1];
            return;
        }// end function

    }
}
