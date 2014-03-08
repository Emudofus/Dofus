package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.utils.IZoneRenderer;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.TrapZoneTile;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.filters.ColorMatrixFilter;
   
   public class TrapZoneRenderer extends Object implements IZoneRenderer
   {
      
      public function TrapZoneRenderer(nStrata:uint=10) {
         super();
         this._aZoneTile = new Array();
         this._aCellTile = new Array();
         this.strata = nStrata;
      }
      
      private var _aZoneTile:Array;
      
      private var _aCellTile:Array;
      
      public var strata:uint;
      
      public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, alpha:Boolean=false, updateStrata:Boolean=false) : void {
         var tzt:TrapZoneTile = null;
         var daCellId:uint = 0;
         var daPoint:MapPoint = null;
         var zzTop:* = false;
         var zzBottom:* = false;
         var zzRight:* = false;
         var zzLeft:* = false;
         var cid:uint = 0;
         var mp:MapPoint = null;
         var j:int = 0;
         while(j < cells.length)
         {
            if(!this._aZoneTile[j])
            {
               this._aZoneTile[j] = tzt = new TrapZoneTile();
               tzt.mouseChildren = false;
               tzt.mouseEnabled = false;
               tzt.strata = this.strata;
               tzt.filters = [new ColorMatrixFilter([0,0,0,0,oColor.red,0,0,0,0,oColor.green,0,0,0,0,oColor.blue,0,0,0,0.7,0])];
            }
            this._aCellTile[j] = cells[j];
            daCellId = cells[j];
            daPoint = MapPoint.fromCellId(daCellId);
            TrapZoneTile(this._aZoneTile[j]).cellId = daCellId;
            zzTop = false;
            zzBottom = false;
            zzRight = false;
            zzLeft = false;
            for each (cid in cells)
            {
               if(cid != daCellId)
               {
                  mp = MapPoint.fromCellId(cid);
                  if(mp.x == daPoint.x)
                  {
                     if(mp.y == daPoint.y - 1)
                     {
                        zzTop = true;
                     }
                     else
                     {
                        if(mp.y == daPoint.y + 1)
                        {
                           zzBottom = true;
                        }
                     }
                  }
                  else
                  {
                     if(mp.y == daPoint.y)
                     {
                        if(mp.x == daPoint.x - 1)
                        {
                           zzRight = true;
                        }
                        else
                        {
                           if(mp.x == daPoint.x + 1)
                           {
                              zzLeft = true;
                           }
                        }
                     }
                  }
               }
            }
            TrapZoneTile(this._aZoneTile[j]).drawStroke(zzTop,zzRight,zzBottom,zzLeft);
            TrapZoneTile(this._aZoneTile[j]).display(this.strata);
            j++;
         }
         while(j < this._aZoneTile.length)
         {
            if(this._aZoneTile[j])
            {
               (this._aZoneTile[j] as TrapZoneTile).remove();
            }
            j++;
         }
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
               delete this._aZoneTile[[j]];
               delete this._aCellTile[[j]];
            }
            j++;
         }
      }
   }
}
