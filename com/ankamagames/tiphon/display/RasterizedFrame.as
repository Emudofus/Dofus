package com.ankamagames.tiphon.display
{
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.display.MovieClip;

    public class RasterizedFrame 
    {

        public var bitmapData:BitmapData;
        public var x:Number = 0;
        public var y:Number = 0;

        public function RasterizedFrame(target:MovieClip, index:int)
        {
            var bmpd:BitmapData;
            var mtx:Matrix;
            var sX:Number;
            var sY:Number;
            var bmpW:Number;
            var bmpH:Number;
            var drawX:Number;
            var drawY:Number;
            super();
            target.gotoAndStop((index + 1));
            var bounds:Rectangle = target.getBounds(target);
            if ((bounds.width + bounds.height))
            {
                mtx = new Matrix();
                sX = target.scaleX;
                sY = target.scaleY;
                bmpW = (((sX > 0)) ? (bounds.width * sX) : (-(bounds.width) * sX));
                bmpH = (((sY > 0)) ? (bounds.height * sY) : (-(bounds.height) * sY));
                drawX = (((sX > 0)) ? (bounds.x * sX) : ((bounds.x + bounds.width) * sX));
                drawY = (((sY > 0)) ? (bounds.y * sY) : ((bounds.y + bounds.height) * sY));
                mtx.scale(sX, sY);
                mtx.translate(-(drawX), -(drawY));
                this.x = drawX;
                this.y = drawY;
                bmpd = new BitmapData(bmpW, bmpH, true, 0xFFFFFF);
                bmpd.draw(target, mtx, null, null, null, true);
            }
            else
            {
                bmpd = new BitmapData(1, 1, true, 0xFFFFFF);
            };
            this.bitmapData = bmpd;
            if ((((target.currentFrame == target.framesLoaded)) && (target.parent)))
            {
                target.parent.removeChild(target);
            };
        }

        public function toString():String
        {
            return ((((((((((("[RasterizedFrame " + this.x) + ",") + this.y) + ": ") + this.bitmapData) + " (") + this.bitmapData.width) + "/") + this.bitmapData.height) + ")]"));
        }


    }
}//package com.ankamagames.tiphon.display

