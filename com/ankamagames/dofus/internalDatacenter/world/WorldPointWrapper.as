package com.ankamagames.dofus.internalDatacenter.world
{
    import com.ankamagames.jerakine.types.positions.WorldPoint;
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import avmplus.getQualifiedClassName;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.atouin.types.DataMapContainer;
    import com.ankamagames.dofus.datacenter.world.MapScrollAction;

    public class WorldPointWrapper extends WorldPoint implements IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WorldPointWrapper));

        public var outdoorMapId:uint;
        private var _outdoorX:int;
        private var _outdoorY:int;
        private var _topNeighbourId:int = -1;
        private var _bottomNeighbourId:int = -1;
        private var _leftNeighbourId:int = -1;
        private var _rightNeighbourId:int = -1;

        public function WorldPointWrapper(mapid:uint, fixedOutdoor:Boolean=false, outx:int=0, outy:int=0)
        {
            var _local_7:Object;
            super();
            mapId = mapid;
            setFromMapId();
            if (fixedOutdoor)
            {
                this._outdoorX = outx;
                this._outdoorY = outy;
            }
            else
            {
                _local_7 = MapPosition.getMapPositionById(mapid);
                if (!(_local_7))
                {
                    this._outdoorX = x;
                    this._outdoorY = y;
                }
                else
                {
                    this._outdoorX = _local_7.posX;
                    this._outdoorY = _local_7.posY;
                };
            };
            var dmc:DataMapContainer = MapDisplayManager.getInstance().getDataMapContainer();
            if (((((dmc) && (dmc.dataMap))) && ((dmc.dataMap.id == mapid))))
            {
                this._topNeighbourId = dmc.dataMap.topNeighbourId;
                this._bottomNeighbourId = dmc.dataMap.bottomNeighbourId;
                this._leftNeighbourId = dmc.dataMap.leftNeighbourId;
                this._rightNeighbourId = dmc.dataMap.rightNeighbourId;
            };
            var mapScrollaction:MapScrollAction = MapScrollAction.getMapScrollActionById(mapid);
            if (mapScrollaction)
            {
                if (mapScrollaction.topExists)
                {
                    this._topNeighbourId = mapScrollaction.topMapId;
                };
                if (mapScrollaction.bottomExists)
                {
                    this._bottomNeighbourId = mapScrollaction.bottomMapId;
                };
                if (mapScrollaction.leftExists)
                {
                    this._leftNeighbourId = mapScrollaction.leftMapId;
                };
                if (mapScrollaction.rightExists)
                {
                    this._rightNeighbourId = mapScrollaction.rightMapId;
                };
            };
        }

        public function get outdoorX():int
        {
            return (this._outdoorX);
        }

        public function get outdoorY():int
        {
            return (this._outdoorY);
        }

        public function get topNeighbourId():int
        {
            return (this._topNeighbourId);
        }

        public function get bottomNeighbourId():int
        {
            return (this._bottomNeighbourId);
        }

        public function get leftNeighbourId():int
        {
            return (this._leftNeighbourId);
        }

        public function get rightNeighbourId():int
        {
            return (this._rightNeighbourId);
        }

        public function setOutdoorCoords(x:int, y:int):void
        {
            this._outdoorX = x;
            this._outdoorY = y;
        }


    }
}//package com.ankamagames.dofus.internalDatacenter.world

