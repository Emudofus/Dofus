package com.ankamagames.dofus
{
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;


   public final class BuildInfos extends Object
   {
         

      public function BuildInfos() {
         super();
      }

      public static var BUILD_VERSION:Version = new Version(2,11,0);

      public static var BUILD_TYPE:uint = BuildTypeEnum.BETA;

      public static var BUILD_REVISION:int = 35100;

      public static var BUILD_PATCH:int = 0;

      public static const BUILD_DATE:String = "Apr 10, 2013 - 13:11:46 CEST";


   }

}