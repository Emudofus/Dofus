package d2api
{
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    public class CaptureApi 
    {


        [Untrusted]
        public function getScreen(rect:Rectangle=null, scale:Number=1):BitmapData
        {
            return (null);
        }

        [Untrusted]
        public function getBattleField(rect:Rectangle=null, scale:Number=1):BitmapData
        {
            return (null);
        }

        [Untrusted]
        public function getFromTarget(target:Object, rect:Rectangle=null, scale:Number=1, transparent:Boolean=false):BitmapData
        {
            return (null);
        }

        [Untrusted]
        public function jpegEncode(img:BitmapData, quality:uint=80, askForSave:Boolean=true, fileName:String="image.jpg"):ByteArray
        {
            return (null);
        }

        [Untrusted]
        public function pngEncode(img:BitmapData, askForSave:Boolean=true, fileName:String="image.png"):ByteArray
        {
            return (null);
        }


    }
}//package d2api

