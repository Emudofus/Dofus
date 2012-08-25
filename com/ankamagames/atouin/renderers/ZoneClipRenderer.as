package com.ankamagames.atouin.renderers
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.prng.*;

    public class ZoneClipRenderer extends Object implements IZoneRenderer
    {
        private var _uri:Uri;
        private var _clipName:Array;
        private var _currentMapId:int;
        private var _needBorders:Boolean;
        protected var _aZoneTile:Array;
        protected var _aCellTile:Array;
        public var strata:uint = 0;
        protected var _cells:Vector.<uint>;
        private static var zoneTile:Array = new Array();

        public function ZoneClipRenderer(param1:uint, param2:String, param3:Array, param4:int = -1, param5:Boolean = false)
        {
            this._aZoneTile = new Array();
            this._aCellTile = new Array();
            this.strata = param1;
            this._currentMapId = param4;
            this._needBorders = param5;
            this._uri = new Uri(param2);
            this._clipName = param3;
            Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            return;
        }// end function

        public function render(param1:Vector.<uint>, param2:Color, param3:DataMapContainer, param4:Boolean = false) : void
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:ZoneClipTile = null;
            this._cells = param1;
            var _loc_5:* = new ParkMillerCarta();
            new ParkMillerCarta().seed(this._currentMapId + 5435);
            var _loc_9:* = param1.length;
            _loc_7 = 0;
            while (_loc_7 < _loc_9)
            {
                
                _loc_8 = this._aZoneTile[_loc_7];
                if (!_loc_8)
                {
                    _loc_6 = _loc_5.nextIntR(0, this._clipName.length * 8);
                    _loc_8 = getZoneTile(this._uri, this._clipName[_loc_6 < 0 || _loc_6 > (this._clipName.length - 1) ? (0) : (_loc_6)], this._needBorders);
                    this._aZoneTile[_loc_7] = _loc_8;
                    _loc_8.strata = this.strata;
                }
                this._aCellTile[_loc_7] = param1[_loc_7];
                _loc_8.cellId = param1[_loc_7];
                _loc_8.display();
                _loc_7++;
            }
            while (_loc_7 < _loc_9)
            {
                
                _loc_8 = this._aZoneTile[_loc_7];
                if (_loc_8)
                {
                    destroyZoneTile(_loc_8);
                }
                _loc_7++;
            }
            return;
        }// end function

        public function remove(param1:Vector.<uint>, param2:DataMapContainer) : void
        {
            var _loc_4:int = 0;
            var _loc_8:ZoneClipTile = null;
            if (!param1)
            {
                return;
            }
            var _loc_3:int = 0;
            var _loc_5:* = new Array();
            var _loc_6:* = param1.length;
            _loc_4 = 0;
            while (_loc_4 < _loc_6)
            {
                
                _loc_5[param1[_loc_4]] = true;
                _loc_4++;
            }
            _loc_6 = this._aCellTile.length;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_6)
            {
                
                if (_loc_5[this._aCellTile[_loc_7]])
                {
                    _loc_3++;
                    _loc_8 = this._aZoneTile[_loc_7];
                    if (_loc_8)
                    {
                        destroyZoneTile(_loc_8);
                    }
                    this._aCellTile.splice(_loc_7, 1);
                    this._aZoneTile.splice(_loc_7, 1);
                    _loc_7 = _loc_7 - 1;
                    _loc_6 = _loc_6 - 1;
                }
                _loc_7++;
            }
            return;
        }// end function

        private function onPropertyChanged(event:PropertyChangeEvent) : void
        {
            return;
        }// end function

        private static function getZoneTile(param1:Uri, param2:String, param3:Boolean) : ZoneClipTile
        {
            var _loc_5:ZoneClipTile = null;
            var _loc_4:* = getData(param1.fileName, param2);
            if (getData(param1.fileName, param2).length)
            {
                return _loc_4.shift();
            }
            _loc_5 = new ZoneClipTile(param1, param2, param3);
            return _loc_5;
        }// end function

        private static function destroyZoneTile(param1:ZoneClipTile) : void
        {
            param1.remove();
            var _loc_2:* = getData(param1.uri.fileName, param1.clipName);
            _loc_2.push(param1);
            return;
        }// end function

        private static function getData(param1:String, param2:String) : CachedTile
        {
            var _loc_3:int = 0;
            var _loc_4:* = zoneTile.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_4)
            {
                
                if (zoneTile[_loc_3].uriName == param1 && zoneTile[_loc_3].clipName == param2)
                {
                    return zoneTile[_loc_3] as ;
                }
                _loc_3 = _loc_3 + 1;
            }
            var _loc_5:* = new CachedTile(param1, param2);
            zoneTile.push(_loc_5);
            return _loc_5;
        }// end function

    }
}

class CachedTile extends Object
{
    public var uriName:String;
    public var clipName:String;
    private var _list:Vector.<ZoneClipTile>;

    function CachedTile(param1:String, param2:String) : void
    {
        this.uriName = param1;
        this.clipName = param2;
        this._list = new Vector.<ZoneClipTile>;
        return;
    }// end function

    public function push(param1:ZoneClipTile) : void
    {
        this._list.push(param1);
        return;
    }// end function

    public function shift() : ZoneClipTile
    {
        return this._list.shift();
    }// end function

    public function get length() : uint
    {
        return this._list.length;
    }// end function

}

