package com.ankamagames.dofus.misc
{
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public class BuildTypeParser extends Object
   {
      
      public function BuildTypeParser() {
         super();
      }
      
      public static function getTypeName(type:uint) : String {
         switch(type)
         {
            case BuildTypeEnum.RELEASE:
               return "RELEASE";
            case BuildTypeEnum.BETA:
               return "BETA";
            case BuildTypeEnum.ALPHA:
               return "ALPHA";
            case BuildTypeEnum.TESTING:
               return "TESTING";
            case BuildTypeEnum.INTERNAL:
               return "INTERNAL";
            case BuildTypeEnum.DEBUG:
               return "DEBUG";
         }
      }
      
      public static function getTypeColor(type:uint) : uint {
         switch(type)
         {
            case BuildTypeEnum.RELEASE:
               return 10079232;
            case BuildTypeEnum.BETA:
               return 16763904;
            case BuildTypeEnum.ALPHA:
               return 16750848;
            case BuildTypeEnum.TESTING:
               return 16737792;
            case BuildTypeEnum.INTERNAL:
               return 6724095;
            case BuildTypeEnum.DEBUG:
               return 10053375;
         }
      }
   }
}
