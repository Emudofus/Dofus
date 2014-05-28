package com.ankamagames.jerakine.utils.misc
{
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class CheckCompatibility extends Object
   {
      
      public function CheckCompatibility() {
         super();
      }
      
      private static var _cache:Dictionary;
      
      public static function isCompatible(reference:Class, target:*, strict:Boolean = false, throwError:Boolean = true) : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function getIncompatibility(reference:Class, target:*, strict:Boolean = false) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private static function throwErrorMsg(reference:Class, target:*, strict:Boolean = false) : void {
         throw new Error(target + " don\'t implement correctly [" + getIncompatibility(reference,target) + "]");
      }
   }
}
