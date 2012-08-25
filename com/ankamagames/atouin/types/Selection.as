package com.ankamagames.atouin.types
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.utils.*;

    public class Selection extends Object
    {
        private var _mapId:uint;
        public var renderer:IZoneRenderer;
        public var zone:IZone;
        public var cells:Vector.<uint>;
        public var color:Color;
        public var alpha:Boolean = true;
        public var cellId:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Selection));

        public function Selection()
        {
            return;
        }// end function

        public function set mapId(param1:uint) : void
        {
            this._mapId = param1;
            return;
        }// end function

        public function get mapId() : uint
        {
            if (isNaN(this._mapId))
            {
                return MapDisplayManager.getInstance().currentMapPoint.mapId;
            }
            return this._mapId;
        }// end function

        public function update() : void
        {
            if (this.renderer)
            {
                this.renderer.render(this.cells, this.color, MapDisplayManager.getInstance().getDataMapContainer(), this.alpha);
            }
            return;
        }// end function

        public function remove(param1:Vector.<uint> = null) : void
        {
            if (this.renderer)
            {
                if (!param1)
                {
                    this.renderer.remove(this.cells, MapDisplayManager.getInstance().getDataMapContainer());
                }
                else
                {
                    this.renderer.remove(param1, MapDisplayManager.getInstance().getDataMapContainer());
                }
            }
            delete this[this];
            return;
        }// end function

        public function isInside(param1:uint) : Boolean
        {
            if (!this.cells)
            {
                return false;
            }
            var _loc_2:uint = 0;
            while (_loc_2 < this.cells.length)
            {
                
                if (this.cells[_loc_2] == param1)
                {
                    return true;
                }
                _loc_2 = _loc_2 + 1;
            }
            return false;
        }// end function

    }
}
