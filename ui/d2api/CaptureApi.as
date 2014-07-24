package d2api
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class CaptureApi extends Object
   {
      
      public function CaptureApi() {
         super();
      }
      
      public function getScreen(rect:Rectangle = null, scale:Number = 1.0) : BitmapData {
         return null;
      }
      
      public function getBattleField(rect:Rectangle = null, scale:Number = 1.0) : BitmapData {
         return null;
      }
      
      public function getFromTarget(target:Object, rect:Rectangle = null, scale:Number = 1.0, transparent:Boolean = false) : BitmapData {
         return null;
      }
      
      public function jpegEncode(img:BitmapData, quality:uint = 80, askForSave:Boolean = true, fileName:String = "image.jpg") : ByteArray {
         return null;
      }
      
      public function pngEncode(img:BitmapData, askForSave:Boolean = true, fileName:String = "image.png") : ByteArray {
         return null;
      }
   }
}
