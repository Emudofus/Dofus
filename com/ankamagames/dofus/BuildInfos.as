package com.ankamagames.dofus
{
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public final class BuildInfos extends Object
   {
      
      public function BuildInfos()
      {
         super();
      }
      
      public static var BUILD_VERSION:Version = new Version(2,28,0);
      
      public static var BUILD_TYPE:uint = BuildTypeEnum.RELEASE;
      
      public static var BUILD_REVISION:int = 94161;
      
      public static var BUILD_PATCH:int = 0;
      
      public static const BUILD_DATE:String = "Apr 22, 2015 - 09:08:01 CEST";
   }
}
