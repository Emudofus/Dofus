package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.utils.IZoneRenderer;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.atouin.types.ZoneTile;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.types.DataMapContainer;
   import flash.geom.ColorTransform;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.atouin.Atouin;


   public class ZoneDARenderer extends Object implements IZoneRenderer
   {
         

      public function ZoneDARenderer(nStrata:uint=0, alpha:Number=1) {
         super();
         this._aZoneTile=new Array();
         this._aCellTile=new Array();
         this.strata=nStrata;
         this._alpha=alpha;
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ZoneDARenderer));

      private static var zoneTileCache:Array = new Array();

      private static function getZoneTile() : ZoneTile {
         if(zoneTileCache.length)
         {
            return zoneTileCache.shift();
         }
         return new ZoneTile();
      }

      private static function destroyZoneTile(zt:ZoneTile) : void {
         zt.remove();
         zoneTileCache.push(zt);
      }

      protected var _cells:Vector.<uint>;

      protected var _aZoneTile:Array;

      protected var _aCellTile:Array;

      private var _alpha:Number = 0.7;

      public var strata:uint = 0;

      public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, bAlpha:Boolean=false) : void {
         var j:* = 0;
         var zt:ZoneTile = null;
         var ct:ColorTransform = null;
         this._cells=cells;
         var num:int = cells.length;
         j=0;
         while(j<num)
         {
            zt=this._aZoneTile[j];
            if(!zt)
            {
               zt=getZoneTile();
               this._aZoneTile[j]=zt;
               zt.strata=this.strata;
               ct=new ColorTransform();
               zt.color=oColor.color;
            }
            this._aCellTile[j]=cells[j];
            zt.cellId=cells[j];
            zt.text=this.getText(j);
            zt.display();
            j++;
         }
         while(j<num)
         {
            zt=this._aZoneTile[j];
            if(zt)
            {
               destroyZoneTile(zt);
            }
            j++;
         }
      }

      protected function getText(count:int) : String {
         return null;
      }

      public function remove(cells:Vector.<uint>, mapContainer:DataMapContainer) : void {
         var j:* = 0;
         var zt:ZoneTile = null;
         if(!cells)
         {
            return;
         }
         var count:int = 0;
         var mapping:Array = new Array();
         var num:int = cells.length;
         j=0;
         while(j<num)
         {
            mapping[cells[j]]=true;
            j++;
         }
         num=this._aCellTile.length;
         var i:int = 0;
         while(i<num)
         {
            if(mapping[this._aCellTile[i]])
            {
               count++;
               zt=this._aZoneTile[i];
               if(zt)
               {
                  destroyZoneTile(zt);
               }
               this._aCellTile.splice(i,1);
               this._aZoneTile.splice(i,1);
               i--;
               num--;
            }
            i++;
         }
      }

      private function onPropertyChanged(e:PropertyChangeEvent) : void {
         
      }
   }

}