package com.ankamagames.atouin.data
{
   import com.ankamagames.atouin.data.map.Map;
   import flash.utils.IDataInput;
   import flash.utils.ByteArray;
   import com.ankamagames.atouin.data.map.Layer;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class DefaultMap extends Map
   {
      
      public function DefaultMap(id:uint=0) {
         var l:* = 0;
         var cd:CellData = null;
         super();
         this.id = id;
         mapVersion = 7;
         backgroundFixtures = new Array();
         foregroundFixtures = new Array();
         layers = new Array();
         layers.push(this.createLayer(Layer.LAYER_GROUND));
         layers.push(this.createLayer(Layer.LAYER_DECOR));
         cells = new Array();
         cellsCount = AtouinConstants.MAP_CELLS_COUNT;
         l = 0;
         while(l < cellsCount)
         {
            cd = new CellData(this,l);
            cells.push(cd);
            l++;
         }
      }
      
      override public function fromRaw(raw:IDataInput, decryptionKey:ByteArray=null) : void {
      }
      
      private function createLayer(id:uint) : Layer {
         var bgLayer:Layer = null;
         bgLayer = new Layer(this);
         bgLayer.cells = new Array();
         bgLayer.layerId = id;
         bgLayer.cellsCount = 1;
         var firstCell:Cell = new Cell(bgLayer);
         firstCell.elements = new Array();
         bgLayer.cells.push(firstCell);
         return bgLayer;
      }
   }
}
