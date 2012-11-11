package com.ankamagames.berilia.types.data
{
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.impl.*;
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class MapArea extends Rectangle
    {
        public var src:Uri;
        public var parent:Map;
        private var _bitmap:Bitmap;
        private var _active:Boolean;
        private var _freeTimer:Timer;
        private static var _mapLoader:ParallelRessourceLoader = new ParallelRessourceLoader(10);
        private static var _freeBitmap:Array = [];

        public function MapArea(param1:Uri, param2:Number, param3:Number, param4:Number, param5:Number, param6:Map)
        {
            this.src = param1;
            this.parent = param6;
            super(param2, param3, param4, param5);
            return;
        }// end function

        public function get isUsed() : Boolean
        {
            return this._active;
        }// end function

        public function getBitmap() : DisplayObject
        {
            this._active = true;
            if (this._freeTimer)
            {
                this._freeTimer.removeEventListener(TimerEvent.TIMER, this.onDeathCountDown);
                this._freeTimer.stop();
                this._freeTimer = null;
            }
            if (!this._bitmap || !this._bitmap.bitmapData)
            {
                if (_freeBitmap.length)
                {
                    this._bitmap = _freeBitmap.pop();
                }
                else
                {
                    this._bitmap = new Bitmap();
                }
                _mapLoader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
                this._bitmap.x = x;
                this._bitmap.y = y;
                _mapLoader.load(this.src);
            }
            return this._bitmap;
        }// end function

        public function free(param1:Boolean = false) : void
        {
            this._active = false;
            if (param1)
            {
                this.onDeathCountDown(null);
                return;
            }
            if (!this._freeTimer)
            {
                this._freeTimer = new Timer(3000);
                this._freeTimer.addEventListener(TimerEvent.TIMER, this.onDeathCountDown);
            }
            this._freeTimer.start();
            return;
        }// end function

        private function onDeathCountDown(event:Event) : void
        {
            if (this._freeTimer)
            {
                this._freeTimer.removeEventListener(TimerEvent.TIMER, this.onDeathCountDown);
                this._freeTimer.stop();
                this._freeTimer = null;
            }
            if (this._active)
            {
                return;
            }
            if (this._bitmap)
            {
                if (this._bitmap.parent)
                {
                    this._bitmap.parent.removeChild(this._bitmap);
                }
                this._bitmap.bitmapData = null;
                if (this._bitmap.bitmapData)
                {
                    this._bitmap.bitmapData.dispose();
                }
                _freeBitmap.push(this._bitmap);
                this._bitmap = null;
            }
            return;
        }// end function

        private function onLoad(event:ResourceLoadedEvent) : void
        {
            if (this._active && event.uri == this.src)
            {
                this._bitmap.bitmapData = event.resource;
                this._bitmap.width = width + 1;
                this._bitmap.height = height + 1;
            }
            return;
        }// end function

    }
}
