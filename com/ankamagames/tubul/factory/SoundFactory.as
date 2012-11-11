package com.ankamagames.tubul.factory
{
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tubul.enum.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.sounds.*;
    import flash.filesystem.*;

    public class SoundFactory extends Object
    {
        private static var _id:uint = 0;

        public function SoundFactory()
        {
            return;
        }// end function

        public static function getSound(param1:uint, param2:Uri) : ISound
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_3:* = false;
            var _loc_4:* = param2.path;
            var _loc_5:* = param2.path.split("/")[_loc_4.split("/").length - 2];
            var _loc_6:* = _loc_4.substring(0, _loc_4.indexOf(param2.fileName)) + _loc_5 + "_mono";
            var _loc_7:* = new File(File.applicationDirectory.nativePath + "/" + _loc_6);
            if (new File(File.applicationDirectory.nativePath + "/" + _loc_6).exists)
            {
                _loc_3 = true;
                _loc_8 = _loc_4.substring(0, _loc_4.indexOf(param2.fileName)) + _loc_5 + "_mono/" + param2.fileName;
                _loc_9 = new File(File.applicationDirectory.nativePath + "/" + param2.path);
                if (!_loc_9.exists)
                {
                    _loc_9 = new File(File.applicationDirectory.nativePath + "/" + _loc_8);
                    if (_loc_9.exists)
                    {
                        param2 = new Uri(_loc_8);
                        _loc_3 = false;
                    }
                }
            }
            switch(param1)
            {
                case EnumSoundType.LOCALIZED_SOUND:
                {
                    switch(param2.fileType.toUpperCase())
                    {
                        case "MP3":
                        {
                            return new LocalizedSound(_id++, param2, _loc_3);
                        }
                        default:
                        {
                            break;
                        }
                    }
                    throw new ArgumentError("Unknown type file " + param2.fileType.toUpperCase());
                }
                case EnumSoundType.UNLOCALIZED_SOUND:
                {
                    switch(param2.fileType.toUpperCase())
                    {
                        case "MP3":
                        {
                            return new UnlocalizedSound(_id++, param2, _loc_3);
                        }
                        default:
                        {
                            break;
                        }
                    }
                    throw new ArgumentError("Unknown type file " + param2.fileType.toUpperCase());
                }
                default:
                {
                    break;
                }
            }
            throw new ArgumentError("Unknown sound type " + param1 + ". See EnumSoundType");
        }// end function

    }
}
