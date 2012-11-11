package com.ankamagames.atouin.types
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.pools.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class CellReference extends Object
    {
        private var _visible:Boolean;
        private var _lock:Boolean = false;
        public var id:uint;
        public var listSprites:Array;
        public var elevation:int = 0;
        public var x:Number = 0;
        public var y:Number = 0;
        public var width:Number = 0;
        public var height:Number = 0;
        public var mov:Boolean;
        public var isDisabled:Boolean = false;
        public var rendered:Boolean = false;
        public var heightestDecor:Sprite;
        public var gfxId:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CellReference));

        public function CellReference(param1:uint)
        {
            this.id = param1;
            this.listSprites = new Array();
            this.gfxId = new Array();
            return;
        }// end function

        public function addSprite(param1:DisplayObject) : void
        {
            this.listSprites.push(param1);
            return;
        }// end function

        public function addGfx(param1:int) : void
        {
            this.gfxId.push(param1);
            return;
        }// end function

        public function lock() : void
        {
            this._lock = true;
            return;
        }// end function

        public function get locked() : Boolean
        {
            return this._lock;
        }// end function

        public function get visible() : Boolean
        {
            return this._visible;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (this._visible != param1)
            {
                this._visible = param1;
                _loc_2 = 0;
                while (_loc_2 < this.listSprites.length)
                {
                    
                    this.listSprites[_loc_2].visible = param1;
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        public function get bounds() : Rectangle
        {
            var _loc_3:* = null;
            var _loc_1:* = (PoolsManager.getInstance().getRectanglePool().checkOut() as PoolableRectangle).renew();
            var _loc_2:* = PoolsManager.getInstance().getRectanglePool().checkOut() as PoolableRectangle;
            for each (_loc_3 in this.listSprites)
            {
                
                _loc_1.extend(_loc_2.renew(_loc_3.x, _loc_3.y, _loc_3.width, _loc_3.height));
            }
            PoolsManager.getInstance().getRectanglePool().checkIn(_loc_2);
            PoolsManager.getInstance().getRectanglePool().checkIn(_loc_1);
            return _loc_1 as Rectangle;
        }// end function

        public function getAvgColor() : uint
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_6:* = this.listSprites.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_6)
            {
                
                _loc_4 = (this.listSprites[_loc_5] as DisplayObject).transform.colorTransform;
                _loc_1 = _loc_1 + _loc_4.redOffset * _loc_4.redMultiplier;
                _loc_2 = _loc_2 + _loc_4.greenOffset * _loc_4.greenMultiplier;
                _loc_3 = _loc_3 + _loc_4.blueOffset * _loc_4.blueMultiplier;
                _loc_5 = _loc_5 + 1;
            }
            _loc_1 = _loc_1 / _loc_6;
            _loc_2 = _loc_2 / _loc_6;
            _loc_3 = _loc_3 / _loc_6;
            return _loc_1 << 16 | _loc_2 << 8 | _loc_3;
        }// end function

    }
}
