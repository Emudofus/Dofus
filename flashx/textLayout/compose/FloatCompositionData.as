package flashx.textLayout.compose
{
    import flash.display.*;
    import flash.geom.*;

    public class FloatCompositionData extends Object
    {
        public var graphic:DisplayObject;
        public var columnIndex:int;
        public var floatType:String;
        public var x:Number;
        public var y:Number;
        public var alpha:Number;
        public var matrix:Matrix;
        public var absolutePosition:int;
        public var depth:Number;
        public var knockOutWidth:Number;
        public var parent:DisplayObjectContainer;

        public function FloatCompositionData(param1:int, param2:DisplayObject, param3:String, param4:Number, param5:Number, param6:Number, param7:Matrix, param8:Number, param9:Number, param10:int, param11:DisplayObjectContainer)
        {
            this.absolutePosition = param1;
            this.graphic = param2;
            this.floatType = param3;
            this.x = param4;
            this.y = param5;
            this.alpha = param6;
            this.matrix = param7;
            this.depth = param8;
            this.knockOutWidth = param9;
            this.columnIndex = param10;
            this.parent = param11;
            return;
        }// end function

    }
}
