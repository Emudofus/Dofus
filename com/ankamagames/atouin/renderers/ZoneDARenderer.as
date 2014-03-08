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
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   
   public class ZoneDARenderer extends Object implements IZoneRenderer
   {
      
      public function ZoneDARenderer(nStrata:uint=0, alpha:Number=1, fixedStrata:Boolean=false) {
         super();
         this._aZoneTile = new Array();
         this._aCellTile = new Array();
         this._strata = nStrata;
         this._fixedStrata = fixedStrata;
         this.currentStrata = (!this._fixedStrata) && (Atouin.getInstance().options.transparentOverlayMode)?PlacementStrataEnums.STRATA_NO_Z_ORDER:this._strata;
         this._alpha = alpha;
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
      
      protected var _fixedStrata:Boolean;
      
      protected var _strata:uint;
      
      public var currentStrata:uint = 0;
      
      public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, bAlpha:Boolean=false, updateStrata:Boolean=false) : void {
         var j:* = 0;
         var zt:ZoneTile = null;
         var ct:ColorTransform = null;
         this._cells = cells;
         var num:int = cells.length;
         j = 0;
         while(j < num)
         {
            zt = this._aZoneTile[j];
            if(!zt)
            {
               zt = getZoneTile();
               this._aZoneTile[j] = zt;
               zt.strata = this.currentStrata;
               ct = new ColorTransform();
               zt.color = oColor.color;
            }
            this._aCellTile[j] = cells[j];
            zt.cellId = cells[j];
            zt.text = this.getText(j);
            if((updateStrata) || (!(EntitiesDisplayManager.getInstance()._dStrataRef[zt] == this.currentStrata)))
            {
               zt.strata = EntitiesDisplayManager.getInstance()._dStrataRef[zt] = this.currentStrata;
            }
            zt.display();
            j++;
         }
         while(j < num)
         {
            zt = this._aZoneTile[j];
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
         j = 0;
         while(j < num)
         {
            mapping[cells[j]] = true;
            j++;
         }
         num = this._aCellTile.length;
         var i:int = 0;
         while(i < num)
         {
            if(mapping[this._aCellTile[i]])
            {
               count++;
               zt = this._aZoneTile[i];
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
      
      public function get fixedStrata() : Boolean {
         return this._fixedStrata;
      }
      
      public function restoreStrata() : void {
         this.currentStrata = this._strata;
      }
   }
}
