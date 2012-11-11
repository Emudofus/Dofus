package com.ankamagames.atouin.messages
{
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class MapsLoadingCompleteMessage extends MapMessage
    {
        private var _map:WorldPoint;
        private var _mapData:Map;

        public function MapsLoadingCompleteMessage(param1:WorldPoint, param2:Map) : void
        {
            this._map = param1;
            this._mapData = param2;
            return;
        }// end function

        public function get mapPoint() : WorldPoint
        {
            return this._map;
        }// end function

        public function get mapData() : Map
        {
            return this._mapData;
        }// end function

    }
}
