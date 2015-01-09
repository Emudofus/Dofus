package com.ankamagames.tubul.factory
{
    import flash.filesystem.File;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.tubul.types.sounds.LocalizedSound;
    import com.ankamagames.tubul.enum.EnumSoundType;
    import com.ankamagames.tubul.types.sounds.UnlocalizedSound;
    import com.ankamagames.tubul.interfaces.ISound;

    public class SoundFactory 
    {

        private static var _id:uint = 0;


        public static function getSound(pType:uint, pUri:Uri):ISound
        {
            var newUriPath:String;
            var fileChecker:File;
            var isStereo:Boolean;
            var uriPath:String = pUri.path;
            var parentDirectory:String = uriPath.split("/")[(uriPath.split("/").length - 2)];
            var test:String = ((uriPath.substring(0, uriPath.indexOf(pUri.fileName)) + parentDirectory) + "_mono");
            var subDirectory:File = new File(((File.applicationDirectory.nativePath + "/") + test));
            if (subDirectory.exists)
            {
                isStereo = true;
                newUriPath = (((uriPath.substring(0, uriPath.indexOf(pUri.fileName)) + parentDirectory) + "_mono/") + pUri.fileName);
                fileChecker = new File(((File.applicationDirectory.nativePath + "/") + pUri.path));
                if (!(fileChecker.exists))
                {
                    fileChecker = new File(((File.applicationDirectory.nativePath + "/") + newUriPath));
                    if (fileChecker.exists)
                    {
                        pUri = new Uri(newUriPath);
                        isStereo = false;
                    };
                };
            };
            switch (pType)
            {
                case EnumSoundType.LOCALIZED_SOUND:
                    switch (pUri.fileType.toUpperCase())
                    {
                        case "MP3":
                            return (new LocalizedSound(_id++, pUri, isStereo));
                    };
                    throw (new ArgumentError(("Unknown type file " + pUri.fileType.toUpperCase())));
                case EnumSoundType.UNLOCALIZED_SOUND:
                    switch (pUri.fileType.toUpperCase())
                    {
                        case "MP3":
                            return (new UnlocalizedSound(_id++, pUri, isStereo));
                    };
                    throw (new ArgumentError(("Unknown type file " + pUri.fileType.toUpperCase())));
            };
            throw (new ArgumentError((("Unknown sound type " + pType) + ". See EnumSoundType")));
        }


    }
}//package com.ankamagames.tubul.factory

