package com.ankamagames.atouin.types
{
    import com.ankamagames.jerakine.logger.*;
    import flash.display.*;
    import flash.utils.*;

    public class LayerContainer extends Sprite
    {
        private var _nLayerId:int;
        private var _lastIndexCell:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(LayerContainer));

        public function LayerContainer(param1:int)
        {
            this._nLayerId = param1;
            name = "layer" + param1;
            return;
        }// end function

        public function get layerId() : int
        {
            return this._nLayerId;
        }// end function

        public function addCell(param1:CellContainer) : void
        {
            var _loc_2:CellContainer = null;
            var _loc_3:uint = 0;
            var _loc_4:* = _loc_3;
            while (_loc_4 < numChildren)
            {
                
                _loc_2 = getChildAt(_loc_4) as CellContainer;
                if (!_loc_2)
                {
                }
                else if (param1.depth < _loc_2.depth)
                {
                    this._lastIndexCell = _loc_4;
                    addChildAt(param1, _loc_4);
                    return;
                }
                _loc_4 = _loc_4 + 1;
            }
            this._lastIndexCell = numChildren;
            addChild(param1);
            return;
        }// end function

    }
}
