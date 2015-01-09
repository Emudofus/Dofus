package com.ankamagames.atouin.types
{
    import flash.display.Sprite;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;

    public class LayerContainer extends Sprite 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LayerContainer));

        private var _nLayerId:int;
        private var _lastIndexCell:uint;

        public function LayerContainer(nId:int)
        {
            this._nLayerId = nId;
            name = ("layer" + nId);
        }

        public function get layerId():int
        {
            return (this._nLayerId);
        }

        public function addCell(cellCtr:CellContainer):void
        {
            var currentCell:CellContainer;
            var startIndex:uint;
            var i:uint = startIndex;
            while (i < numChildren)
            {
                currentCell = (getChildAt(i) as CellContainer);
                if (!!(currentCell))
                {
                    if (cellCtr.depth < currentCell.depth)
                    {
                        this._lastIndexCell = i;
                        addChildAt(cellCtr, i);
                        return;
                    };
                };
                i++;
            };
            this._lastIndexCell = numChildren;
            addChild(cellCtr);
        }


    }
}//package com.ankamagames.atouin.types

