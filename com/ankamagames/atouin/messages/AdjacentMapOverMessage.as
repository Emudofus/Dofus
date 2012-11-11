package com.ankamagames.atouin.messages
{
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.display.*;

    public class AdjacentMapOverMessage extends Object implements Message
    {
        private var _nDirection:uint;
        private var _spZone:DisplayObject;
        private var _cellId:int;
        private var _cellData:CellData;

        public function AdjacentMapOverMessage(param1:uint, param2:DisplayObject, param3:int, param4:CellData)
        {
            this._nDirection = param1;
            this._spZone = param2;
            this._cellId = param3;
            this._cellData = param4;
            return;
        }// end function

        public function get direction() : uint
        {
            return this._nDirection;
        }// end function

        public function get zone() : DisplayObject
        {
            return this._spZone;
        }// end function

        public function get cellId() : int
        {
            return this._cellId;
        }// end function

        public function get cellData() : CellData
        {
            return this._cellData;
        }// end function

    }
}
