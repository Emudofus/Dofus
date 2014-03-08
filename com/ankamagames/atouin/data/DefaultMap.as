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
      
      public function DefaultMap(param1:uint=0) {
         var _loc2_:* = 0;
         var _loc3_:CellData = null;
         super();
         this.id = param1;
         mapVersion = 7;
         backgroundFixtures = new Array();
         foregroundFixtures = new Array();
         layers = new Array();
         layers.push(this.createLayer(Layer.LAYER_GROUND));
         layers.push(this.createLayer(Layer.LAYER_DECOR));
         cells = new Array();
         cellsCount = AtouinConstants.MAP_CELLS_COUNT;
         _loc2_ = 0;
         while(_loc2_ < cellsCount)
         {
            _loc3_ = new CellData(this,_loc2_);
            cells.push(_loc3_);
            _loc2_++;
         }
      }
      
      override public function fromRaw(param1:IDataInput, param2:ByteArray=null) : void {
      }
      
      private function createLayer(param1:uint) : Layer {
         var _loc2_:Layer = null;
         _loc2_ = new Layer(this);
         _loc2_.cells = new Array();
         _loc2_.layerId = param1;
         _loc2_.cellsCount = 1;
         var _loc3_:Cell = new Cell(_loc2_);
         _loc3_.elements = new Array();
         _loc2_.cells.push(_loc3_);
         return _loc2_;
      }
   }
}
