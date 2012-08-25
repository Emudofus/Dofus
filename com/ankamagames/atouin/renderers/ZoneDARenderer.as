package com.ankamagames.atouin.renderers
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class ZoneDARenderer extends Object implements IZoneRenderer
    {
        protected var _cells:Vector.<uint>;
        protected var _aZoneTile:Array;
        protected var _aCellTile:Array;
        private var _alpha:Number = 0.7;
        public var strata:uint = 0;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ZoneDARenderer));
        private static var zoneTileCache:Array = new Array();

        public function ZoneDARenderer(param1:uint = 0, param2:Number = 1)
        {
            this._aZoneTile = new Array();
            this._aCellTile = new Array();
            this.strata = param1;
            this._alpha = param2;
            Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            return;
        }// end function

        public function render(param1:Vector.<uint>, param2:Color, param3:DataMapContainer, param4:Boolean = false) : void
        {
            var _loc_5:int = 0;
            var _loc_6:ZoneTile = null;
            var _loc_8:ColorTransform = null;
            this._cells = param1;
            var _loc_7:* = param1.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_7)
            {
                
                _loc_6 = this._aZoneTile[_loc_5];
                if (!_loc_6)
                {
                    _loc_6 = getZoneTile();
                    this._aZoneTile[_loc_5] = _loc_6;
                    _loc_6.strata = this.strata;
                    _loc_8 = new ColorTransform();
                    _loc_6.color = param2.color;
                }
                this._aCellTile[_loc_5] = param1[_loc_5];
                _loc_6.cellId = param1[_loc_5];
                _loc_6.text = this.getText(_loc_5);
                _loc_6.display();
                _loc_5++;
            }
            while (_loc_5 < _loc_7)
            {
                
                _loc_6 = this._aZoneTile[_loc_5];
                if (_loc_6)
                {
                    destroyZoneTile(_loc_6);
                }
                _loc_5++;
            }
            return;
        }// end function

        protected function getText(param1:int) : String
        {
            return null;
        }// end function

        public function remove(param1:Vector.<uint>, param2:DataMapContainer) : void
        {
            var _loc_4:int = 0;
            var _loc_8:ZoneTile = null;
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

        private static function getZoneTile() : ZoneTile
        {
            if (zoneTileCache.length)
            {
                return zoneTileCache.shift();
            }
            return new ZoneTile();
        }// end function

        private static function destroyZoneTile(param1:ZoneTile) : void
        {
            param1.remove();
            zoneTileCache.push(param1);
            return;
        }// end function

    }
}
