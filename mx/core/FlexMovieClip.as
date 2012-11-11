package mx.core
{
    import flash.display.*;
    import mx.utils.*;

    public class FlexMovieClip extends MovieClip
    {
        static const VERSION:String = "4.1.0.16076";

        public function FlexMovieClip()
        {
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
