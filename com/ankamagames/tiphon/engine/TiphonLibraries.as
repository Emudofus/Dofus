package com.ankamagames.tiphon.engine
{


   public class TiphonLibraries extends Object
   {
         

      public function TiphonLibraries() {
         super();
      }

      public static const skullLibrary:LibrariesManager = new LibrariesManager("skullLibrary",LibrariesManager.TYPE_BONE);

      public static const skinLibrary:LibrariesManager = new LibrariesManager("skinLibrary",LibrariesManager.TYPE_SKIN);


   }

}