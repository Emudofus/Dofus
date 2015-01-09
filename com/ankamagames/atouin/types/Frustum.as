package com.ankamagames.atouin.types
{
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.jerakine.utils.display.StageShareManager;

    public class Frustum extends Rectangle 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Frustum));
        public static const MAX_WIDTH:Number = ((AtouinConstants.MAP_WIDTH + 0.5) * AtouinConstants.CELL_WIDTH);//1247
        public static const MAX_HEIGHT:Number = ((AtouinConstants.MAP_HEIGHT + 0.5) * AtouinConstants.CELL_HEIGHT);//881.5
        public static const RATIO:Number = (MAX_WIDTH / MAX_HEIGHT);//1.41463414634146

        private var _marginLeft:int;
        private var _marginRight:int;
        private var _marginTop:int;
        private var _marginBottom:int;
        public var scale:Number;

        public function Frustum(marginRight:uint=0, marginTop:uint=0, marginLeft:uint=0, marginBottom:uint=0)
        {
            this._marginTop = marginTop;
            this._marginRight = marginRight;
            this._marginBottom = marginBottom;
            this._marginLeft = marginLeft;
            this.refresh();
        }

        public function refresh():Frustum
        {
            var divX:Number;
            var divY:Number;
            width = ((MAX_WIDTH + this._marginRight) + this._marginLeft);
            height = ((MAX_HEIGHT + this._marginTop) + this._marginBottom);
            var yScale:Number = (StageShareManager.startHeight / height);
            width = (MAX_WIDTH * yScale);
            height = (MAX_HEIGHT * yScale);
            if ((width / height) < RATIO)
            {
                height = (width / RATIO);
            };
            if ((width / height) > RATIO)
            {
                width = (height * RATIO);
            };
            this.scale = yScale;
            var xSpace:Number = (((StageShareManager.startWidth - (MAX_WIDTH * this.scale)) + this._marginLeft) - this._marginRight);
            var ySpace:Number = (((StageShareManager.startHeight - (MAX_HEIGHT * this.scale)) + this._marginTop) - this._marginBottom);
            if (((this._marginLeft) && (this._marginRight)))
            {
                divX = ((this._marginLeft + this._marginRight) / this._marginLeft);
            }
            else
            {
                if (this._marginLeft)
                {
                    divX = (2 + (xSpace / this._marginLeft));
                }
                else
                {
                    if (this._marginRight)
                    {
                        divX = (2 - (xSpace / this._marginRight));
                    }
                    else
                    {
                        divX = 2;
                    };
                };
            };
            if (((this._marginTop) && (this._marginBottom)))
            {
                divY = ((this._marginTop + this._marginBottom) / this._marginTop);
            }
            else
            {
                if (this._marginTop)
                {
                    divY = (2 + (ySpace / this._marginTop));
                }
                else
                {
                    if (this._marginBottom)
                    {
                        divY = ((ySpace / this._marginBottom) - 2);
                    }
                    else
                    {
                        divY = 2;
                    };
                };
            };
            x = (xSpace / divX);
            y = (ySpace / divY);
            return (this);
        }

        override public function toString():String
        {
            return (((super.toString() + " scale=") + this.scale));
        }


    }
}//package com.ankamagames.atouin.types

