package com.ankamagames.dofus
{
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public final class BuildInfos extends Object
   {
      
      public function BuildInfos() {
         super();
      }
      
      public static var BUILD_VERSION:Version = new Version(2,19,0);
      
      public static var BUILD_TYPE:uint = BuildTypeEnum.BETA;
      
      public static var BUILD_REVISION:int = 83515;
      
      public static var BUILD_PATCH:int = 0;
      
      public static const BUILD_DATE:String = "Mar 28, 2014 - 17:42:03 CET";
   }
}
