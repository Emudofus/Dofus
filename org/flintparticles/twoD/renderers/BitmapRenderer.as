package org.flintparticles.twoD.renderers
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import org.flintparticles.common.renderers.*;
    import org.flintparticles.twoD.particles.*;

    public class BitmapRenderer extends SpriteRendererBase
    {
        protected var _bitmap:Bitmap;
        protected var _bitmapData:BitmapData;
        protected var _preFilters:Array;
        protected var _postFilters:Array;
        protected var _colorMap:Array;
        protected var _smoothing:Boolean;
        protected var _canvas:Rectangle;
        static var ZERO_POINT:Point = new Point(0, 0);

        public function BitmapRenderer(param1:Rectangle, param2:Boolean = false)
        {
            mouseEnabled = false;
            mouseChildren = false;
            this._smoothing = param2;
            this._preFilters = new Array();
            this._postFilters = new Array();
            this._canvas = param1;
            this.createBitmap();
            return;
        }// end function

        public function addFilter(param1:BitmapFilter, param2:Boolean = false) : void
        {
            if (param2)
            {
                this._postFilters.push(param1);
            }
            else
            {
                this._preFilters.push(param1);
            }
            return;
        }// end function

        public function removeFilter(param1:BitmapFilter) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this._preFilters.length)
            {
                
                if (this._preFilters[_loc_2] == param1)
                {
                    this._preFilters.splice(_loc_2, 1);
                    return;
                }
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this._postFilters.length)
            {
                
                if (this._postFilters[_loc_2] == param1)
                {
                    this._postFilters.splice(_loc_2, 1);
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function setPaletteMap(param1:Array = null, param2:Array = null, param3:Array = null, param4:Array = null) : void
        {
            this._colorMap = new Array(4);
            this._colorMap[0] = param4;
            this._colorMap[1] = param1;
            this._colorMap[2] = param2;
            this._colorMap[3] = param3;
            return;
        }// end function

        public function clearPaletteMap() : void
        {
            this._colorMap = null;
            return;
        }// end function

        protected function createBitmap() : void
        {
            if (!this._canvas)
            {
                return;
            }
            if (this._bitmap && this._bitmapData)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            }
            if (this._bitmap)
            {
                removeChild(this._bitmap);
            }
            this._bitmap = new Bitmap(null, "auto", this._smoothing);
            this._bitmapData = new BitmapData(this._canvas.width, this._canvas.height, true, 0);
            this._bitmap.bitmapData = this._bitmapData;
            addChild(this._bitmap);
            this._bitmap.x = this._canvas.x;
            this._bitmap.y = this._canvas.y;
            return;
        }// end function

        public function get canvas() : Rectangle
        {
            return this._canvas;
        }// end function

        public function set canvas(param1:Rectangle) : void
        {
            this._canvas = param1;
            this.createBitmap();
            return;
        }// end function

        override protected function renderParticles(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (!this._bitmap)
            {
                return;
            }
            this._bitmapData.lock();
            _loc_3 = this._preFilters.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._bitmapData.applyFilter(this._bitmapData, this._bitmapData.rect, BitmapRenderer.ZERO_POINT, this._preFilters[_loc_2]);
                _loc_2++;
            }
            if (_loc_3 == 0 && this._postFilters.length == 0)
            {
                this._bitmapData.fillRect(this._bitmap.bitmapData.rect, 0);
            }
            _loc_3 = param1.length;
            if (_loc_3)
            {
                _loc_2 = _loc_3;
                while (_loc_2--)
                {
                    
                    this.drawParticle(param1[_loc_2]);
                }
            }
            _loc_3 = this._postFilters.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._bitmapData.applyFilter(this._bitmapData, this._bitmapData.rect, BitmapRenderer.ZERO_POINT, this._postFilters[_loc_2]);
                _loc_2++;
            }
            if (this._colorMap)
            {
                this._bitmapData.paletteMap(this._bitmapData, this._bitmapData.rect, ZERO_POINT, this._colorMap[1], this._colorMap[2], this._colorMap[3], this._colorMap[0]);
            }
            this._bitmapData.unlock();
            return;
        }// end function

        protected function drawParticle(param1:Particle2D) : void
        {
            var _loc_2:Matrix = null;
            _loc_2 = param1.matrixTransform;
            _loc_2.translate(-this._canvas.x, -this._canvas.y);
            this._bitmapData.draw(param1.image, _loc_2, param1.colorTransform, DisplayObject(param1.image).blendMode, null, this._smoothing);
            return;
        }// end function

    }
}
