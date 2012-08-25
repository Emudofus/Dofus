package com.ankamagames.jerakine.map
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.utils.*;

    public class LosDetector extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(LosDetector));

        public function LosDetector()
        {
            return;
        }// end function

        public static function getCell(param1:IDataMapProvider, param2:Vector.<uint>, param3:MapPoint) : Vector.<uint>
        {
            var _loc_5:uint = 0;
            var _loc_8:Array = null;
            var _loc_9:Boolean = false;
            var _loc_10:String = null;
            var _loc_11:MapPoint = null;
            var _loc_13:int = 0;
            var _loc_4:* = new Array();
            var _loc_6:MapPoint = null;
            _loc_5 = 0;
            while (_loc_5 < param2.length)
            {
                
                _loc_6 = MapPoint.fromCellId(param2[_loc_5]);
                _loc_4.push({p:_loc_6, dist:param3.distanceToCell(_loc_6)});
                _loc_5 = _loc_5 + 1;
            }
            _loc_4.sortOn("dist", Array.DESCENDING | Array.NUMERIC);
            var _loc_7:* = new Object();
            var _loc_12:* = new Vector.<uint>;
            _loc_5 = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_11 = MapPoint(_loc_4[_loc_5].p);
                if (_loc_7[_loc_11.x + "_" + _loc_11.y] != null && param3.x + param3.y != _loc_11.x + _loc_11.y && param3.x - param3.y != _loc_11.x - _loc_11.y)
                {
                }
                else
                {
                    _loc_8 = Dofus1Line.getLine(param3.x, param3.y, 0, _loc_11.x, _loc_11.y, 0);
                    if (_loc_8.length == 0)
                    {
                        _loc_12.push(_loc_11.cellId);
                    }
                    else
                    {
                        _loc_9 = true;
                        _loc_13 = 0;
                        while (_loc_13 < _loc_8.length)
                        {
                            
                            _loc_10 = Math.floor(_loc_8[_loc_13].x) + "_" + Math.floor(_loc_8[_loc_13].y);
                            if (!MapPoint.isInMap(_loc_8[_loc_13].x, _loc_8[_loc_13].y))
                            {
                            }
                            else if (_loc_13 > 0 && param1.hasEntity(Math.floor(_loc_8[(_loc_13 - 1)].x), Math.floor(_loc_8[(_loc_13 - 1)].y)))
                            {
                                _loc_9 = false;
                            }
                            else if (_loc_8[_loc_13].x + _loc_8[_loc_13].y == param3.x + param3.y || _loc_8[_loc_13].x - _loc_8[_loc_13].y == param3.x - param3.y)
                            {
                                _loc_9 = _loc_9 && param1.pointLos(Math.floor(_loc_8[_loc_13].x), Math.floor(_loc_8[_loc_13].y), true);
                            }
                            else if (_loc_7[_loc_10] == null)
                            {
                                _loc_9 = _loc_9 && param1.pointLos(Math.floor(_loc_8[_loc_13].x), Math.floor(_loc_8[_loc_13].y), true);
                            }
                            else
                            {
                                _loc_9 = _loc_9 && _loc_7[_loc_10];
                            }
                            _loc_13++;
                        }
                        _loc_7[_loc_10] = _loc_9;
                    }
                }
                _loc_5 = _loc_5 + 1;
            }
            _loc_5 = 0;
            while (_loc_5 < param2.length)
            {
                
                _loc_6 = MapPoint.fromCellId(param2[_loc_5]);
                if (_loc_7[_loc_6.x + "_" + _loc_6.y])
                {
                    _loc_12.push(_loc_6.cellId);
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_12;
        }// end function

    }
}
