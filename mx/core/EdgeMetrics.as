package mx.core
{

    public class EdgeMetrics extends Object
    {
        public var bottom:Number;
        public var left:Number;
        public var right:Number;
        public var top:Number;
        static const VERSION:String = "4.1.0.16076";
        public static const EMPTY:EdgeMetrics = new EdgeMetrics(0, 0, 0, 0);

        public function EdgeMetrics(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
        {
            this.left = param1;
            this.top = param2;
            this.right = param3;
            this.bottom = param4;
            return;
        }// end function

        public function clone() : EdgeMetrics
        {
            return new EdgeMetrics(this.left, this.top, this.right, this.bottom);
        }// end function

    }
}
