package com.ankamagames.dofus
{
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public final class BuildInfos extends Object
   {
      
      public function BuildInfos() {
         super();
      }
      
      public static var BUILD_VERSION:Version = new Version(2,18,2);
      
      public static var BUILD_TYPE:uint = BuildTypeEnum.RELEASE;
      
      public static var BUILD_REVISION:int = 82300;
      
      public static var BUILD_PATCH:int = 0;
      
      public static const BUILD_DATE:String = "Feb 24, 2014 - 10:21:36 CET";
   }
}
