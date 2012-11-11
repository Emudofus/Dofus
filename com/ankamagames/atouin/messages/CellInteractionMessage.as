package com.ankamagames.atouin.messages
{
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;

    public class CellInteractionMessage extends MapMessage
    {
        private var _cellId:uint;
        private var _cellDepth:uint;
        private var _cellContainer:Sprite;
        private var _cellCoords:MapPoint;

        public function CellInteractionMessage()
        {
            return;
        }// end function

        public function get cellId() : uint
        {
            return this._cellId;
        }// end function

        public function set cellId(param1:uint) : void
        {
            this._cellId = param1;
            return;
        }// end function

        public function get cellContainer() : Sprite
        {
            return this._cellContainer;
        }// end function

        public function set cellContainer(param1:Sprite) : void
        {
            this._cellContainer = param1;
            return;
        }// end function

        public function get cellDepth() : uint
        {
            return this._cellDepth;
        }// end function

        public function set cellDepth(param1:uint) : void
        {
            this._cellDepth = param1;
            return;
        }// end function

        public function get cell() : MapPoint
        {
            return this._cellCoords;
        }// end function

        public function set cell(param1:MapPoint) : void
        {
            this._cellCoords = param1;
            return;
        }// end function

    }
}
