package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.utils.IZoneRenderer;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.TrapZoneTile;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.filters.ColorMatrixFilter;
   
   public class TrapZoneRenderer extends Object implements IZoneRenderer
   {
      
      public function TrapZoneRenderer(nStrata:uint = 10) {
         super();
         this._aZoneTile = new Array();
         this._aCellTile = new Array();
         this.strata = nStrata;
      }
      
      private var _aZoneTile:Array;
      
      private var _aCellTile:Array;
      
      public var strata:uint;
      
      public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, alpha:Boolean = false, updateStrata:Boolean = false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function remove(cells:Vector.<uint>, mapContainer:DataMapContainer) : void {
         if(!cells)
         {
            return;
         }
         var mapping:Array = new Array();
         var j:int = 0;
         while(j < cells.length)
         {
            mapping[cells[j]] = true;
            j++;
         }
         j = 0;
         while(j < this._aCellTile.length)
         {
            if(mapping[this._aCellTile[j]])
            {
               if(this._aZoneTile[j])
               {
                  TrapZoneTile(this._aZoneTile[j]).remove();
               }
               delete this._aZoneTile[j];
               delete this._aCellTile[j];
            }
            j++;
         }
      }
   }
}
