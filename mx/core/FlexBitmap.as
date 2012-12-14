package mx.core
{
    import flash.display.*;
    import mx.utils.*;

    public class FlexBitmap extends Bitmap
    {
        static const VERSION:String = "4.6.0.23201";

        public function FlexBitmap(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false)
        {
            super(param1, param2, param3);
            try
            {
                name = NameUtil.createUniqueName(this);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        override public function toString() : String
        {
            return NameUtil.displayObjectToString(this);
        }// end function

    }
}
