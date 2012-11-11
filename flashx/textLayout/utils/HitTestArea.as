package flashx.textLayout.utils
{
    import flash.geom.*;
    import flashx.textLayout.elements.*;

    public class HitTestArea extends Object
    {
        private var tl:HitTestArea = null;
        private var tr:HitTestArea = null;
        private var bl:HitTestArea = null;
        private var br:HitTestArea = null;
        private var _rect:Rectangle;
        private var _xm:Number;
        private var _ym:Number;
        private var _owner:FlowElement = null;

        public function HitTestArea(param1:Object)
        {
            this.initialize(param1);
            return;
        }// end function

        function initialize(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_3:* = 0;
            if (param1)
            {
                for (_loc_2 in param1)
                {
                    
                    if (++_loc_3 > 1)
                    {
                        break;
                    }
                }
            }
            if (++_loc_3 == 0)
            {
                this._rect = new Rectangle();
                var _loc_10:* = 0;
                this._ym = 0;
                this._xm = _loc_10;
                return;
            }
            if (_loc_3 == 1)
            {
                for each (_loc_2 in param1)
                {
                    
                    this._rect = _loc_2.rect;
                    this._xm = this._rect.left;
                    this._ym = this._rect.top;
                    this._owner = _loc_2.owner;
                    return;
                }
            }
            for each (_loc_2 in param1)
            {
                
                _loc_4 = _loc_2.rect;
                if (!this._rect)
                {
                    this._rect = _loc_4;
                    continue;
                }
                this._rect = this._rect.union(_loc_4);
            }
            this._xm = Math.ceil(this._rect.left + this._rect.width / 2);
            this._ym = Math.ceil(this._rect.top + this._rect.height / 2);
            if (this._rect.width <= 3 || this._rect.height <= 3)
            {
                for each (_loc_2 in param1)
                {
                    
                    this._owner = _loc_2.owner;
                    return;
                }
            }
            for each (_loc_2 in param1)
            {
                
                _loc_4 = _loc_2.rect;
                if (_loc_4.equals(this._rect))
                {
                    continue;
                }
                if (_loc_4.contains(this._xm, this._ym))
                {
                    _loc_6 = this._xm - _loc_4.left;
                    _loc_7 = _loc_4.right - this._xm;
                    _loc_8 = this._ym - _loc_4.top;
                    _loc_9 = _loc_4.bottom - this._ym;
                    this._xm = _loc_6 > _loc_7 ? (this._xm + _loc_7) : (this._xm - _loc_6);
                    this._ym = _loc_8 > _loc_9 ? (this._ym + _loc_9) : (this._ym - _loc_8);
                    break;
                }
            }
            _loc_5 = new Rectangle(this._rect.left, this._rect.top, this._xm - this._rect.left, this._ym - this._rect.top);
            this.addQuadrant(param1, "tl", _loc_5);
            _loc_5.left = this._xm;
            _loc_5.right = this._rect.right;
            this.addQuadrant(param1, "tr", _loc_5);
            _loc_5.left = this._rect.left;
            _loc_5.top = this._ym;
            _loc_5.right = this._xm;
            _loc_5.bottom = this._rect.bottom;
            this.addQuadrant(param1, "bl", _loc_5);
            _loc_5.left = this._xm;
            _loc_5.right = this._rect.right;
            this.addQuadrant(param1, "br", _loc_5);
            return;
        }// end function

        public function hitTest(param1:Number, param2:Number) : FlowElement
        {
            if (!this._rect.contains(param1, param2))
            {
                return null;
            }
            if (this._owner)
            {
                return this._owner;
            }
            var _loc_3:* = param2 < this._ym ? ("t") : ("b");
            _loc_3 = _loc_3 + (param1 < this._xm ? ("l") : ("r"));
            var _loc_4:* = this[_loc_3];
            if (this[_loc_3] == null)
            {
                return null;
            }
            return _loc_4.hitTest(param1, param2);
        }// end function

        private function addQuadrant(param1:Object, param2:String, param3:Rectangle) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (param3.isEmpty())
            {
                return;
            }
            var _loc_4:* = {};
            var _loc_5:* = 0;
            for each (_loc_6 in param1)
            {
                
                _loc_7 = _loc_6.rect.intersection(param3);
                if (!_loc_7.isEmpty())
                {
                    _loc_4[++_loc_5] = {owner:_loc_6.owner, rect:_loc_7};
                }
            }
            if (_loc_5 > 0)
            {
                this[param2] = new HitTestArea(_loc_4);
            }
            return;
        }// end function

    }
}
