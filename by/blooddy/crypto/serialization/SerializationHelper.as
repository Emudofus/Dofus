package by.blooddy.crypto.serialization
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public final class SerializationHelper extends Object
   {
      
      public function SerializationHelper() {
         super();
         Error.throwError(ArgumentError,2012,getQualifiedClassName(this));
      }
      
      private static const _EMPTY_ARR:Array;
      
      private static const _HASH_CLASS:Dictionary;
      
      private static const _HASH_INSTANCE:Dictionary;
      
      public static function getPropertyNames(o:Object) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
