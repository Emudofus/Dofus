package com.ankamagames.tiphon.types.look
{
   public class EntityLookParser extends Object
   {
      
      public function EntityLookParser() {
         super();
      }
      
      public static const CURRENT_FORMAT_VERSION:uint = 0;
      
      public static const DEFAULT_NUMBER_BASE:uint = 10;
      
      public static function fromString(str:String, pFormatVersion:uint = 0, pNumberBase:uint = 10, tiphonInstance:TiphonEntityLook = null) : TiphonEntityLook {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function toString(el:TiphonEntityLook) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private static function getNumberBase(l:String) : uint {
         switch(l)
         {
            case "A":
               return 10;
            case "G":
               return 16;
            case "Z":
               return 36;
            default:
               throw new Error("Unknown number base type \'" + l + "\' in an Entity Look string.");
         }
      }
   }
}
