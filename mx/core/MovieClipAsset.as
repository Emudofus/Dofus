package mx.core
{
    import mx.core.*;

    public class MovieClipAsset extends FlexMovieClip implements IFlexAsset, IFlexDisplayObject, IBorder
    {
        private var _measuredHeight:Number;
        private var _measuredWidth:Number;
        static const VERSION:String = "4.1.0.16076";

        public function MovieClipAsset()
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

        public function get borderMetrics() : EdgeMetrics
        {
            if (scale9Grid == null)
            {
                return EdgeMetrics.EMPTY;
            }
            return new EdgeMetrics(scale9Grid.left, scale9Grid.top, Math.ceil(this.measuredWidth - scale9Grid.right), Math.ceil(this.measuredHeight - scale9Grid.bottom));
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
