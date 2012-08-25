package com.ankamagames.dofus.internalDatacenter.world
{
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class WorldPointWrapper extends WorldPoint implements IDataCenter
    {
        public var outdoorMapId:uint;
        private var _outdoorX:int;
        private var _outdoorY:int;

        public function WorldPointWrapper(param1:uint, param2:Boolean = false, param3:int = 0, param4:int = 0)
        {
            var _loc_5:Object = null;
            mapId = param1;
            setFromMapId();
            if (param2)
            {
                this._outdoorX = param3;
                this._outdoorY = param4;
            }
            else
            {
                _loc_5 = MapPosition.getMapPositionById(param1);
                if (!_loc_5)
                {
                    this._outdoorX = x;
                    this._outdoorY = y;
                }
                else
                {
                    this._outdoorX = _loc_5.posX;
                    this._outdoorY = _loc_5.posY;
                }
            }
            return;
        }// end function

        public function get outdoorX() : int
        {
            return this._outdoorX;
        }// end function

        public function get outdoorY() : int
        {
            return this._outdoorY;
        }// end function

        public function setOutdoorCoords(param1:int, param2:int) : void
        {
            this._outdoorX = param1;
            this._outdoorY = param2;
            return;
        }// end function

    }
}
