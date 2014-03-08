package com.ankamagames.tubul.factory
{
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.jerakine.types.Uri;
   import flash.filesystem.File;
   import com.ankamagames.tubul.types.sounds.LocalizedSound;
   import com.ankamagames.tubul.types.sounds.UnlocalizedSound;
   import com.ankamagames.tubul.enum.EnumSoundType;
   
   public class SoundFactory extends Object
   {
      
      public function SoundFactory() {
         super();
      }
      
      private static var _id:uint = 0;
      
      public static function getSound(pType:uint, pUri:Uri) : ISound {
         var newUriPath:String = null;
         var fileChecker:File = null;
         var isStereo:Boolean = false;
         var uriPath:String = pUri.path;
         var parentDirectory:String = uriPath.split("/")[uriPath.split("/").length - 2];
         var test:String = uriPath.substring(0,uriPath.indexOf(pUri.fileName)) + parentDirectory + "_mono";
         var subDirectory:File = new File(File.applicationDirectory.nativePath + "/" + test);
         if(subDirectory.exists)
         {
            isStereo = true;
            newUriPath = uriPath.substring(0,uriPath.indexOf(pUri.fileName)) + parentDirectory + "_mono/" + pUri.fileName;
            fileChecker = new File(File.applicationDirectory.nativePath + "/" + pUri.path);
            if(!fileChecker.exists)
            {
               fileChecker = new File(File.applicationDirectory.nativePath + "/" + newUriPath);
               if(fileChecker.exists)
               {
                  pUri = new Uri(newUriPath);
                  isStereo = false;
               }
            }
         }
         switch(pType)
         {
            case EnumSoundType.LOCALIZED_SOUND:
               switch(pUri.fileType.toUpperCase())
               {
                  case "MP3":
                     return new LocalizedSound(_id++,pUri,isStereo);
               }
            case EnumSoundType.UNLOCALIZED_SOUND:
               switch(pUri.fileType.toUpperCase())
               {
                  case "MP3":
                     return new UnlocalizedSound(_id++,pUri,isStereo);
               }
         }
      }
   }
}
