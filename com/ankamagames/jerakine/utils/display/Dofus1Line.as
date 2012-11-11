package com.ankamagames.jerakine.utils.display
{
    import com.ankamagames.jerakine.types.*;
    import flash.geom.*;

    public class Dofus1Line extends Object
    {

        public function Dofus1Line()
        {
            return;
        }// end function

        public static function getLine(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : Array
        {
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_21:* = null;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = 0;
            var _loc_33:* = 0;
            var _loc_7:* = new Array();
            var _loc_8:* = new Point3D(param1, param2, param3);
            var _loc_9:* = new Point3D(param4, param5, param6);
            _loc_11 = new Point3D(_loc_8.x + 0.5, _loc_8.y + 0.5, _loc_8.z);
            var _loc_12:* = new Point3D(_loc_9.x + 0.5, _loc_9.y + 0.5, _loc_9.z);
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = _loc_11.z > _loc_12.z;
            var _loc_18:* = new Array();
            var _loc_19:* = new Array();
            var _loc_20:* = 0;
            if (Math.abs(_loc_11.x - _loc_12.x) == Math.abs(_loc_11.y - _loc_12.y))
            {
                _loc_16 = Math.abs(_loc_11.x - _loc_12.x);
                _loc_13 = _loc_12.x > _loc_11.x ? (1) : (-1);
                _loc_14 = _loc_12.y > _loc_11.y ? (1) : (-1);
                _loc_15 = _loc_16 == 0 ? (0) : (_loc_17 ? ((_loc_8.z - _loc_9.z) / _loc_16) : ((_loc_9.z - _loc_8.z) / _loc_16));
                _loc_20 = 1;
            }
            else if (Math.abs(_loc_11.x - _loc_12.x) > Math.abs(_loc_11.y - _loc_12.y))
            {
                _loc_16 = Math.abs(_loc_11.x - _loc_12.x);
                _loc_13 = _loc_12.x > _loc_11.x ? (1) : (-1);
                _loc_14 = _loc_12.y > _loc_11.y ? (Math.abs(_loc_11.y - _loc_12.y) == 0 ? (0) : (Math.abs(_loc_11.y - _loc_12.y) / _loc_16)) : ((-Math.abs(_loc_11.y - _loc_12.y)) / _loc_16);
                _loc_14 = _loc_14 * 100;
                _loc_14 = Math.ceil(_loc_14) / 100;
                _loc_15 = _loc_16 == 0 ? (0) : (_loc_17 ? ((_loc_8.z - _loc_9.z) / _loc_16) : ((_loc_9.z - _loc_8.z) / _loc_16));
                _loc_20 = 2;
            }
            else
            {
                _loc_16 = Math.abs(_loc_11.y - _loc_12.y);
                _loc_13 = _loc_12.x > _loc_11.x ? (Math.abs(_loc_11.x - _loc_12.x) == 0 ? (0) : (Math.abs(_loc_11.x - _loc_12.x) / _loc_16)) : ((-Math.abs(_loc_11.x - _loc_12.x)) / _loc_16);
                _loc_13 = _loc_13 * 100;
                _loc_13 = Math.ceil(_loc_13) / 100;
                _loc_14 = _loc_12.y > _loc_11.y ? (1) : (-1);
                _loc_15 = _loc_16 == 0 ? (0) : (_loc_17 ? ((_loc_8.z - _loc_9.z) / _loc_16) : ((_loc_9.z - _loc_8.z) / _loc_16));
                _loc_20 = 3;
            }
            _loc_10 = 0;
            while (_loc_10 < _loc_16)
            {
                
                _loc_22 = int(3 + _loc_16 / 2);
                _loc_23 = int(97 - _loc_16 / 2);
                if (_loc_20 == 2)
                {
                    _loc_24 = Math.ceil(_loc_11.y * 100 + _loc_14 * 50) / 100;
                    _loc_25 = Math.floor(_loc_11.y * 100 + _loc_14 * 150) / 100;
                    _loc_26 = Math.floor(Math.abs(Math.floor(_loc_24) * 100 - _loc_24 * 100)) / 100;
                    _loc_27 = Math.ceil(Math.abs(Math.ceil(_loc_25) * 100 - _loc_25 * 100)) / 100;
                    if (Math.floor(_loc_24) == Math.floor(_loc_25))
                    {
                        _loc_19 = [Math.floor(_loc_11.y + _loc_14)];
                        if (_loc_24 == _loc_19[0] && _loc_25 < _loc_19[0])
                        {
                            _loc_19 = [Math.ceil(_loc_11.y + _loc_14)];
                        }
                        else if (_loc_24 == _loc_19[0] && _loc_25 > _loc_19[0])
                        {
                            _loc_19 = [Math.floor(_loc_11.y + _loc_14)];
                        }
                        else if (_loc_25 == _loc_19[0] && _loc_24 < _loc_19[0])
                        {
                            _loc_19 = [Math.ceil(_loc_11.y + _loc_14)];
                        }
                        else if (_loc_25 == _loc_19[0] && _loc_24 > _loc_19[0])
                        {
                            _loc_19 = [Math.floor(_loc_11.y + _loc_14)];
                        }
                    }
                    else if (Math.ceil(_loc_24) == Math.ceil(_loc_25))
                    {
                        _loc_19 = [Math.ceil(_loc_11.y + _loc_14)];
                        if (_loc_24 == _loc_19[0] && _loc_25 < _loc_19[0])
                        {
                            _loc_19 = [Math.floor(_loc_11.y + _loc_14)];
                        }
                        else if (_loc_24 == _loc_19[0] && _loc_25 > _loc_19[0])
                        {
                            _loc_19 = [Math.ceil(_loc_11.y + _loc_14)];
                        }
                        else if (_loc_25 == _loc_19[0] && _loc_24 < _loc_19[0])
                        {
                            _loc_19 = [Math.floor(_loc_11.y + _loc_14)];
                        }
                        else if (_loc_25 == _loc_19[0] && _loc_24 > _loc_19[0])
                        {
                            _loc_19 = [Math.ceil(_loc_11.y + _loc_14)];
                        }
                    }
                    else if (Dofus1Line.int(_loc_26 * 100) <= _loc_22)
                    {
                        _loc_19 = [Math.floor(_loc_25)];
                    }
                    else if (Dofus1Line.int(_loc_27 * 100) >= _loc_23)
                    {
                        _loc_19 = [Math.floor(_loc_24)];
                    }
                    else
                    {
                        _loc_19 = [Math.floor(_loc_24), Math.floor(_loc_25)];
                    }
                }
                else if (_loc_20 == 3)
                {
                    _loc_28 = Math.ceil(_loc_11.x * 100 + _loc_13 * 50) / 100;
                    _loc_29 = Math.floor(_loc_11.x * 100 + _loc_13 * 150) / 100;
                    _loc_30 = Math.floor(Math.abs(Math.floor(_loc_28) * 100 - _loc_28 * 100)) / 100;
                    _loc_31 = Math.ceil(Math.abs(Math.ceil(_loc_29) * 100 - _loc_29 * 100)) / 100;
                    if (Math.floor(_loc_28) == Math.floor(_loc_29))
                    {
                        _loc_18 = [Math.floor(_loc_11.x + _loc_13)];
                        if (_loc_28 == _loc_18[0] && _loc_29 < _loc_18[0])
                        {
                            _loc_18 = [Math.ceil(_loc_11.x + _loc_13)];
                        }
                        else if (_loc_28 == _loc_18[0] && _loc_29 > _loc_18[0])
                        {
                            _loc_18 = [Math.floor(_loc_11.x + _loc_13)];
                        }
                        else if (_loc_29 == _loc_18[0] && _loc_28 < _loc_18[0])
                        {
                            _loc_18 = [Math.ceil(_loc_11.x + _loc_13)];
                        }
                        else if (_loc_29 == _loc_18[0] && _loc_28 > _loc_18[0])
                        {
                            _loc_18 = [Math.floor(_loc_11.x + _loc_13)];
                        }
                    }
                    else if (Math.ceil(_loc_28) == Math.ceil(_loc_29))
                    {
                        _loc_18 = [Math.ceil(_loc_11.x + _loc_13)];
                        if (_loc_28 == _loc_18[0] && _loc_29 < _loc_18[0])
                        {
                            _loc_18 = [Math.floor(_loc_11.x + _loc_13)];
                        }
                        else if (_loc_28 == _loc_18[0] && _loc_29 > _loc_18[0])
                        {
                            _loc_18 = [Math.ceil(_loc_11.x + _loc_13)];
                        }
                        else if (_loc_29 == _loc_18[0] && _loc_28 < _loc_18[0])
                        {
                            _loc_18 = [Math.floor(_loc_11.x + _loc_13)];
                        }
                        else if (_loc_29 == _loc_18[0] && _loc_28 > _loc_18[0])
                        {
                            _loc_18 = [Math.ceil(_loc_11.x + _loc_13)];
                        }
                    }
                    else if (Dofus1Line.int(_loc_30 * 100) <= _loc_22)
                    {
                        _loc_18 = [Math.floor(_loc_29)];
                    }
                    else if (Dofus1Line.int(_loc_31 * 100) >= _loc_23)
                    {
                        _loc_18 = [Math.floor(_loc_28)];
                    }
                    else
                    {
                        _loc_18 = [Math.floor(_loc_28), Math.floor(_loc_29)];
                    }
                }
                if (_loc_19.length > 0)
                {
                    _loc_32 = 0;
                    while (_loc_32 < _loc_19.length)
                    {
                        
                        _loc_21 = new Point(Math.floor(_loc_11.x + _loc_13), _loc_19[_loc_32]);
                        _loc_7.push(_loc_21);
                        _loc_32 = _loc_32 + 1;
                    }
                }
                else if (_loc_18.length > 0)
                {
                    _loc_33 = 0;
                    while (_loc_33 < _loc_18.length)
                    {
                        
                        _loc_21 = new Point(_loc_18[_loc_33], Math.floor(_loc_11.y + _loc_14));
                        _loc_7.push(_loc_21);
                        _loc_33 = _loc_33 + 1;
                    }
                }
                else if (_loc_20 == 1)
                {
                    _loc_21 = new Point(Math.floor(_loc_11.x + _loc_13), Math.floor(_loc_11.y + _loc_14));
                    _loc_7.push(_loc_21);
                }
                _loc_11.x = (_loc_11.x * 100 + _loc_13 * 100) / 100;
                _loc_11.y = (_loc_11.y * 100 + _loc_14 * 100) / 100;
                _loc_10++;
            }
            return _loc_7;
        }// end function

    }
}
