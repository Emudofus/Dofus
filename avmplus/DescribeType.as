package avmplus
{
   public final class DescribeType extends Object
   {
      
      public function DescribeType() {
         super();
      }
      
      public static const HIDE_NSURI_METHODS:uint = HIDE_NSURI_METHODS;
      
      public static const INCLUDE_BASES:uint = INCLUDE_BASES;
      
      public static const INCLUDE_INTERFACES:uint = INCLUDE_INTERFACES;
      
      public static const INCLUDE_VARIABLES:uint = INCLUDE_VARIABLES;
      
      public static const INCLUDE_ACCESSORS:uint = INCLUDE_ACCESSORS;
      
      public static const INCLUDE_METHODS:uint = INCLUDE_METHODS;
      
      public static const INCLUDE_METADATA:uint = INCLUDE_METADATA;
      
      public static const INCLUDE_CONSTRUCTOR:uint = INCLUDE_CONSTRUCTOR;
      
      public static const INCLUDE_TRAITS:uint = INCLUDE_TRAITS;
      
      public static const USE_ITRAITS:uint = USE_ITRAITS;
      
      public static const HIDE_OBJECT:uint = HIDE_OBJECT;
      
      public static const FLASH10_FLAGS:uint = FLASH10_FLAGS;
      
      public static const ACCESSOR_FLAGS:uint = INCLUDE_TRAITS | INCLUDE_ACCESSORS;
      
      public static const INTERFACE_FLAGS:uint = INCLUDE_TRAITS | INCLUDE_INTERFACES;
      
      public static const METHOD_FLAGS:uint = INCLUDE_TRAITS | INCLUDE_METHODS;
      
      public static const VARIABLE_FLAGS:uint = INCLUDE_TRAITS | INCLUDE_VARIABLES;
      
      public static const GET_INSTANCE_INFO:uint = INCLUDE_BASES | INCLUDE_INTERFACES | INCLUDE_VARIABLES | INCLUDE_ACCESSORS | INCLUDE_METHODS | INCLUDE_METADATA | INCLUDE_CONSTRUCTOR | INCLUDE_TRAITS | USE_ITRAITS;
      
      public static const GET_CLASS_INFO:uint = INCLUDE_INTERFACES | INCLUDE_VARIABLES | INCLUDE_ACCESSORS | INCLUDE_METHODS | INCLUDE_METADATA | INCLUDE_TRAITS | HIDE_OBJECT;
      
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
