package com.ankamagames.atouin.data
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.*;

    public class DefaultMap extends Map
    {

        public function DefaultMap(param1:uint = 0)
        {
            var _loc_3:CellData = null;
            this.id = param1;
            mapVersion = 7;
            backgroundFixtures = new Array();
            foregroundFixtures = new Array();
            layers = new Array();
            layers.push(this.createLayer(Layer.LAYER_GROUND));
            layers.push(this.createLayer(Layer.LAYER_DECOR));
            cells = new Array();
            cellsCount = AtouinConstants.MAP_CELLS_COUNT;
            var _loc_2:int = 0;
            while (_loc_2 < cellsCount)
            {
                
                _loc_3 = new CellData(this);
                cells.push(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        private function createLayer(param1:uint) : Layer
        {
            var _loc_2:* = new Layer(this);
            _loc_2.cells = new Array();
            _loc_2.layerId = param1;
            _loc_2.cellsCount = 1;
            var _loc_3:* = new Cell(_loc_2);
            _loc_3.elements = new Array();
            _loc_2.cells.push(_loc_3);
            return _loc_2;
        }// end function

    }
}
