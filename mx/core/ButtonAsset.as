package mx.core
{
    import mx.core.*;

    public class ButtonAsset extends FlexSimpleButton implements IFlexAsset, IFlexDisplayObject
    {
        private var _measuredHeight:Number;
        private var _measuredWidth:Number;
        static const VERSION:String = "4.1.0.16076";

        public function ButtonAsset()
        {
            this._measuredWidth = width;
            this._measuredHeight = height;
            return;
        }// end function

        public function get measuredHeight() : Number
        {
            return this._measuredHeight;
        }// end function

        public function get measuredWidth() : Number
        {
            return this._measuredWidth;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function setActualSize(param1:Number, param2:Number) : void
        {
            width = param1;
            height = param2;
            return;
        }// end function

    }
}
