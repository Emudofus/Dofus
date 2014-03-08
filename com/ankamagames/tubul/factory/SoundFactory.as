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
      
      public static function getSound(param1:uint, param2:Uri) : ISound {
         var _loc8_:String = null;
         var _loc9_:File = null;
         var _loc3_:* = false;
         var _loc4_:String = param2.path;
         var _loc5_:String = _loc4_.split("/")[_loc4_.split("/").length - 2];
         var _loc6_:* = _loc4_.substring(0,_loc4_.indexOf(param2.fileName)) + _loc5_ + "_mono";
         var _loc7_:File = new File(File.applicationDirectory.nativePath + "/" + _loc6_);
         if(_loc7_.exists)
         {
            _loc3_ = true;
            _loc8_ = _loc4_.substring(0,_loc4_.indexOf(param2.fileName)) + _loc5_ + "_mono/" + param2.fileName;
            _loc9_ = new File(File.applicationDirectory.nativePath + "/" + param2.path);
            if(!_loc9_.exists)
            {
               _loc9_ = new File(File.applicationDirectory.nativePath + "/" + _loc8_);
               if(_loc9_.exists)
               {
                  param2 = new Uri(_loc8_);
                  _loc3_ = false;
               }
            }
         }
         switch(param1)
         {
            case EnumSoundType.LOCALIZED_SOUND:
               switch(param2.fileType.toUpperCase())
               {
                  case "MP3":
                     return new LocalizedSound(_id++,param2,_loc3_);
                  default:
                     throw new ArgumentError("Unknown type file " + param2.fileType.toUpperCase());
               }
            case EnumSoundType.UNLOCALIZED_SOUND:
               switch(param2.fileType.toUpperCase())
               {
                  case "MP3":
                     return new UnlocalizedSound(_id++,param2,_loc3_);
                  default:
                     throw new ArgumentError("Unknown type file " + param2.fileType.toUpperCase());
               }
            default:
               throw new ArgumentError("Unknown sound type " + param1 + ". See EnumSoundType");
         }
      }
   }
}
