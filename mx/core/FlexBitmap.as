package mx.core
{
   import flash.display.Bitmap;
   import mx.utils.NameUtil;
   import flash.display.BitmapData;

   use namespace mx_internal;

   public class FlexBitmap extends Bitmap
   {
         

      public function FlexBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false) {
         super(bitmapData,pixelSnapping,smoothing);
         try
         {
            name=NameUtil.createUniqueName(this);
         }
         catch(e:Error)
         {
         }
      }

      mx_internal  static const VERSION:String = "4.6.0.23201";

      override public function toString() : String {
         return NameUtil.displayObjectToString(this);
      }
   }

}