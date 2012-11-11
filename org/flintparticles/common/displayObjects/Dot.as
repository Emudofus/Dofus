package org.flintparticles.common.displayObjects
{
    import flash.display.*;

    public class Dot extends Shape
    {

        public function Dot(param1:Number, param2:uint = 16777215, param3:String = "normal")
        {
            graphics.beginFill(param2);
            graphics.drawCircle(0, 0, param1);
            graphics.endFill();
            blendMode = param3;
            return;
        }// end function

    }
}
