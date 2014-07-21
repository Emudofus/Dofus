package com.ankamagames.dofus
{
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public final class BuildInfos extends Object
   {
      
      public function BuildInfos() {
         super();
      }
      
      public static var BUILD_VERSION:Version;
      
      public static var BUILD_TYPE:uint = 1;
      
      public static var BUILD_REVISION:int = 86370;
      
      public static var BUILD_PATCH:int = 0;
      
      public static const BUILD_DATE:String = "Jul 16, 2014 - 12:06:42 CEST";
   }
}
