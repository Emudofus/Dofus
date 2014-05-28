package avmplus
{
   public final class DescribeType extends Object
   {
      
      public function DescribeType() {
         super();
      }
      
      public static const HIDE_NSURI_METHODS:uint = 1.0;
      
      public static const INCLUDE_BASES:uint = 2.0;
      
      public static const INCLUDE_INTERFACES:uint = 4.0;
      
      public static const INCLUDE_VARIABLES:uint = 8.0;
      
      public static const INCLUDE_ACCESSORS:uint = 16.0;
      
      public static const INCLUDE_METHODS:uint = 32.0;
      
      public static const INCLUDE_METADATA:uint = 64.0;
      
      public static const INCLUDE_CONSTRUCTOR:uint = 128.0;
      
      public static const INCLUDE_TRAITS:uint = 256.0;
      
      public static const USE_ITRAITS:uint = 512.0;
      
      public static const HIDE_OBJECT:uint = 1024.0;
      
      public static const FLASH10_FLAGS:uint;
      
      public static const ACCESSOR_FLAGS:uint;
      
      public static const INTERFACE_FLAGS:uint;
      
      public static const METHOD_FLAGS:uint;
      
      public static const VARIABLE_FLAGS:uint;
      
      public static const GET_INSTANCE_INFO:uint;
      
      public static const GET_CLASS_INFO:uint;
      
      public static function getJSONFunction() : Function {
         try
         {
            return describeTypeJSON;
         }
         catch(e:*)
         {
         }
         return null;
      }
   }
}
