package com.ankamagames.atouin.renderers
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.filters.*;

    public class TrapZoneRenderer extends Object implements IZoneRenderer
    {
        private var _aZoneTile:Array;
        private var _aCellTile:Array;
        public var strata:uint;

        public function TrapZoneRenderer(param1:uint = 10)
        {
            this._aZoneTile = new Array();
            this._aCellTile = new Array();
            this.strata = param1;
            return;
        }// end function

        public function render(param1:Vector.<uint>, param2:Color, param3:DataMapContainer, param4:Boolean = false) : void
        {
            var _loc_5:TrapZoneTile = null;
            var _loc_7:uint = 0;
            var _loc_8:MapPoint = null;
            var _loc_9:Boolean = false;
            var _loc_10:Boolean = false;
            var _loc_11:Boolean = false;
            var _loc_12:Boolean = false;
            var _loc_13:uint = 0;
            var _loc_14:MapPoint = null;
            var _loc_6:int = 0;
            while (_loc_6 < param1.length)
            {
                
                if (!this._aZoneTile[_loc_6])
                {
                    var _loc_15:* = new TrapZoneTile();
                    _loc_5 = new TrapZoneTile();
                    this._aZoneTile[_loc_6] = _loc_15;
                    _loc_5.mouseChildren = false;
                    _loc_5.mouseEnabled = false;
                    _loc_5.strata = this.strata;
                    _loc_5.filters = [new ColorMatrixFilter([0, 0, 0, 0, param2.red, 0, 0, 0, 0, param2.green, 0, 0, 0, 0, param2.blue, 0, 0, 0, 0.7, 0])];
                }
                this._aCellTile[_loc_6] = param1[_loc_6];
                _loc_7 = param1[_loc_6];
                _loc_8 = MapPoint.fromCellId(_loc_7);
                TrapZoneTile(this._aZoneTile[_loc_6]).cellId = _loc_7;
                _loc_9 = false;
                _loc_10 = false;
                _loc_11 = false;
                _loc_12 = false;
                for each (_loc_13 in param1)
                {
                    
                    if (_loc_13 == _loc_7)
                    {
                        continue;
                    }
                    _loc_14 = MapPoint.fromCellId(_loc_13);
                    if (_loc_14.x == _loc_8.x)
                    {
                        if (_loc_14.y == (_loc_8.y - 1))
                        {
                            _loc_9 = true;
                        }
                        else if (_loc_14.y == (_loc_8.y + 1))
                        {
                            _loc_10 = true;
                        }
                        continue;
                    }
                    if (_loc_14.y == _loc_8.y)
                    {
                        if (_loc_14.x == (_loc_8.x - 1))
                        {
                            _loc_11 = true;
                            continue;
                        }
                        if (_loc_14.x == (_loc_8.x + 1))
                        {
                            _loc_12 = true;
                        }
                    }
                }
                TrapZoneTile(this._aZoneTile[_loc_6]).drawStroke(_loc_9, _loc_11, _loc_10, _loc_12);
                TrapZoneTile(this._aZoneTile[_loc_6]).display();
                _loc_6++;
            }
            while (_loc_6 < this._aZoneTile.length)
            {
                
                if (this._aZoneTile[_loc_6])
                {
                    (this._aZoneTile[_loc_6] as TrapZoneTile).remove();
                }
                _loc_6++;
            }
            return;
        }// end function

        public function remove(param1:Vector.<uint>, param2:DataMapContainer) : void
        {
            if (!param1)
            {
                return;
            }
            var _loc_3:* = new Array();
            var _loc_4:int = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_3[param1[_loc_4]] = true;
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < this._aCellTile.length)
            {
                
                if (_loc_3[this._aCellTile[_loc_4]])
                {
                    if (this._aZoneTile[_loc_4])
                    {
                        TrapZoneTile(this._aZoneTile[_loc_4]).remove();
                    }
                    delete this._aZoneTile[_loc_4];
                    delete this._aCellTile[_loc_4];
                }
                _loc_4++;
            }
            return;
        }// end function

    }
}
