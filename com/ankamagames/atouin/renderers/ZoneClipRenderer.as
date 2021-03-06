﻿package com.ankamagames.atouin.renderers
{
    import com.ankamagames.atouin.utils.IZoneRenderer;
    import com.ankamagames.jerakine.types.Uri;
    import __AS3__.vec.Vector;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
    import com.ankamagames.atouin.types.ZoneClipTile;
    import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
    import com.ankamagames.jerakine.utils.prng.PRNG;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.atouin.types.DataMapContainer;

    public class ZoneClipRenderer implements IZoneRenderer 
    {

        private static var zoneTile:Array = new Array();

        private var _uri:Uri;
        private var _clipName:Array;
        private var _currentMapId:int;
        private var _needBorders:Boolean;
        protected var _aZoneTile:Array;
        protected var _aCellTile:Array;
        public var strata:uint = 0;
        protected var _cells:Vector.<uint>;

        public function ZoneClipRenderer(nStrata:uint, pClipUri:String, pClipName:Array, pCurrentMap:int=-1, pNeedBorders:Boolean=false)
        {
            this._aZoneTile = new Array();
            this._aCellTile = new Array();
            this.strata = nStrata;
            this._currentMapId = pCurrentMap;
            this._needBorders = pNeedBorders;
            this._uri = new Uri(pClipUri);
            this._clipName = pClipName;
            Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
        }

        private static function getZoneTile(pUri:Uri, pClipName:String, pNeedBorders:Boolean):ZoneClipTile
        {
            var _local_5:ZoneClipTile;
            var ct:CachedTile = getData(pUri.fileName, pClipName);
            if (ct.length)
            {
                return (ct.shift());
            };
            _local_5 = new ZoneClipTile(pUri, pClipName, pNeedBorders);
            return (_local_5);
        }

        private static function destroyZoneTile(zt:ZoneClipTile):void
        {
            zt.remove();
            var ct:CachedTile = getData(zt.uri.fileName, zt.clipName);
            ct.push(zt);
        }

        private static function getData(uri:String, clip:String):CachedTile
        {
            var i:int;
            var len:int = zoneTile.length;
            i = 0;
            while (i < len)
            {
                if ((((zoneTile[i].uriName == uri)) && ((zoneTile[i].clipName == clip))))
                {
                    return ((zoneTile[i] as CachedTile));
                };
                i = (i + 1);
            };
            var e:CachedTile = new CachedTile(uri, clip);
            zoneTile.push(e);
            return (e);
        }


        public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, bAlpha:Boolean=false, updateStrata:Boolean=false):void
        {
            var rndNum:int;
            var j:int;
            var zt:ZoneClipTile;
            this._cells = cells;
            var rnd:PRNG = new ParkMillerCarta();
            rnd.seed((this._currentMapId + 5435));
            var num:int = cells.length;
            j = 0;
            while (j < num)
            {
                zt = this._aZoneTile[j];
                if (!(zt))
                {
                    rndNum = rnd.nextIntR(0, (this._clipName.length * 8));
                    zt = getZoneTile(this._uri, this._clipName[(((((rndNum < 0)) || ((rndNum > (this._clipName.length - 1))))) ? 0 : rndNum)], this._needBorders);
                    this._aZoneTile[j] = zt;
                    zt.strata = this.strata;
                };
                this._aCellTile[j] = cells[j];
                zt.cellId = cells[j];
                zt.display();
                j++;
            };
            while (j < num)
            {
                zt = this._aZoneTile[j];
                if (zt)
                {
                    destroyZoneTile(zt);
                };
                j++;
            };
        }

        public function remove(cells:Vector.<uint>, mapContainer:DataMapContainer):void
        {
            var j:int;
            var zt:ZoneClipTile;
            if (!(cells))
            {
                return;
            };
            var count:int;
            var mapping:Array = new Array();
            var num:int = cells.length;
            j = 0;
            while (j < num)
            {
                mapping[cells[j]] = true;
                j++;
            };
            num = this._aCellTile.length;
            var i:int;
            while (i < num)
            {
                if (mapping[this._aCellTile[i]])
                {
                    count++;
                    zt = this._aZoneTile[i];
                    if (zt)
                    {
                        destroyZoneTile(zt);
                    };
                    this._aCellTile.splice(i, 1);
                    this._aZoneTile.splice(i, 1);
                    i--;
                    num--;
                };
                i++;
            };
        }

        private function onPropertyChanged(e:PropertyChangeEvent):void
        {
            var j:int;
            var zt:ZoneClipTile;
            if (e.propertyName == "transparentOverlayMode")
            {
                j = 0;
                while (j < this._aZoneTile.length)
                {
                    zt = this._aZoneTile[j];
                    zt.remove();
                    zt.display();
                    j++;
                };
            };
        }


    }
}//package com.ankamagames.atouin.renderers

import __AS3__.vec.Vector;
import com.ankamagames.atouin.types.ZoneClipTile;
import __AS3__.vec.*;

class CachedTile 
{

    public var uriName:String;
    public var clipName:String;
    /*private*/ var _list:Vector.<ZoneClipTile>;

    public function CachedTile(pName:String, pClip:String):void
    {
        this.uriName = pName;
        this.clipName = pClip;
        this._list = new Vector.<ZoneClipTile>();
    }

    public function push(value:ZoneClipTile):void
    {
        this._list.push(value);
    }

    public function shift():ZoneClipTile
    {
        return (this._list.shift());
    }

    public function get length():uint
    {
        return (this._list.length);
    }


}

