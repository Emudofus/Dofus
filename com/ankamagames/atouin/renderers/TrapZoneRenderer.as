package com.ankamagames.atouin.renderers
{
    import com.ankamagames.atouin.utils.IZoneRenderer;
    import com.ankamagames.atouin.types.TrapZoneTile;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import flash.filters.ColorMatrixFilter;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.atouin.types.DataMapContainer;

    public class TrapZoneRenderer implements IZoneRenderer 
    {

        private var _aZoneTile:Array;
        private var _aCellTile:Array;
        private var _visible:Boolean;
        public var strata:uint;

        public function TrapZoneRenderer(nStrata:uint=10, visible:Boolean=true)
        {
            this._aZoneTile = new Array();
            this._aCellTile = new Array();
            this._visible = visible;
            this.strata = nStrata;
        }

        public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, alpha:Boolean=false, updateStrata:Boolean=false):void
        {
            var tzt:TrapZoneTile;
            var daCellId:uint;
            var daPoint:MapPoint;
            var zzTop:Boolean;
            var zzBottom:Boolean;
            var zzRight:Boolean;
            var zzLeft:Boolean;
            var cid:uint;
            var mp:MapPoint;
            var j:int;
            while (j < cells.length)
            {
                if (!(this._aZoneTile[j]))
                {
                    tzt = new TrapZoneTile();
                    this._aZoneTile[j] = tzt;
                    tzt.mouseChildren = false;
                    tzt.mouseEnabled = false;
                    tzt.strata = this.strata;
                    tzt.visible = this._visible;
                    tzt.filters = [new ColorMatrixFilter([0, 0, 0, 0, oColor.red, 0, 0, 0, 0, oColor.green, 0, 0, 0, 0, oColor.blue, 0, 0, 0, 0.7, 0])];
                };
                this._aCellTile[j] = cells[j];
                daCellId = cells[j];
                daPoint = MapPoint.fromCellId(daCellId);
                TrapZoneTile(this._aZoneTile[j]).cellId = daCellId;
                zzTop = false;
                zzBottom = false;
                zzRight = false;
                zzLeft = false;
                for each (cid in cells)
                {
                    if (cid == daCellId)
                    {
                    }
                    else
                    {
                        mp = MapPoint.fromCellId(cid);
                        if (mp.x == daPoint.x)
                        {
                            if (mp.y == (daPoint.y - 1))
                            {
                                zzTop = true;
                            }
                            else
                            {
                                if (mp.y == (daPoint.y + 1))
                                {
                                    zzBottom = true;
                                };
                            };
                        }
                        else
                        {
                            if (mp.y == daPoint.y)
                            {
                                if (mp.x == (daPoint.x - 1))
                                {
                                    zzRight = true;
                                }
                                else
                                {
                                    if (mp.x == (daPoint.x + 1))
                                    {
                                        zzLeft = true;
                                    };
                                };
                            };
                        };
                    };
                };
                TrapZoneTile(this._aZoneTile[j]).drawStroke(zzTop, zzRight, zzBottom, zzLeft);
                TrapZoneTile(this._aZoneTile[j]).display(this.strata);
                j++;
            };
            while (j < this._aZoneTile.length)
            {
                if (this._aZoneTile[j])
                {
                    (this._aZoneTile[j] as TrapZoneTile).remove();
                };
                j++;
            };
        }

        public function remove(cells:Vector.<uint>, mapContainer:DataMapContainer):void
        {
            if (!(cells))
            {
                return;
            };
            var mapping:Array = new Array();
            var j:int;
            while (j < cells.length)
            {
                mapping[cells[j]] = true;
                j++;
            };
            j = 0;
            while (j < this._aCellTile.length)
            {
                if (mapping[this._aCellTile[j]])
                {
                    if (this._aZoneTile[j])
                    {
                        TrapZoneTile(this._aZoneTile[j]).remove();
                    };
                    delete this._aZoneTile[j];
                    delete this._aCellTile[j];
                };
                j++;
            };
        }


    }
}//package com.ankamagames.atouin.renderers

