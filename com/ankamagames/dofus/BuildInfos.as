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
      
      public static var BUILD_REVISION:int = 85397;
      
      public static var BUILD_PATCH:int = 0;
      
      public static const BUILD_DATE:String = "Jun 9, 2014 - 15:46:01 CEST";
   }
}
