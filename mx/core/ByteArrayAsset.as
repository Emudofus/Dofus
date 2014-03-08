package mx.core
{
   import flash.utils.ByteArray;
   
   use namespace mx_internal;
   
   public class ByteArrayAsset extends ByteArray implements IFlexAsset
   {
      
      public function ByteArrayAsset() {
         super();
      }
      
      mx_internal  static const VERSION:String = "4.6.0.23201";
   }
}
