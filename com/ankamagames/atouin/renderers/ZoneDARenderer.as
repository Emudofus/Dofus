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
      
      public function ZoneDARenderer(param1:uint=0, param2:Number=1, param3:Boolean=false) {
         super();
         this._aZoneTile = new Array();
         this._aCellTile = new Array();
         this._strata = param1;
         this._fixedStrata = param3;
         this.currentStrata = !this._fixedStrata && (Atouin.getInstance().options.transparentOverlayMode)?PlacementStrataEnums.STRATA_NO_Z_ORDER:this._strata;
         this._alpha = param2;
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
      
      private static function destroyZoneTile(param1:ZoneTile) : void {
         param1.remove();
         zoneTileCache.push(param1);
      }
      
      protected var _cells:Vector.<uint>;
      
      protected var _aZoneTile:Array;
      
      protected var _aCellTile:Array;
      
      private var _alpha:Number = 0.7;
      
      protected var _fixedStrata:Boolean;
      
      protected var _strata:uint;
      
      public var currentStrata:uint = 0;
      
      public function render(param1:Vector.<uint>, param2:Color, param3:DataMapContainer, param4:Boolean=false, param5:Boolean=false) : void {
         var _loc6_:* = 0;
         var _loc7_:ZoneTile = null;
         var _loc9_:ColorTransform = null;
         this._cells = param1;
         var _loc8_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            _loc7_ = this._aZoneTile[_loc6_];
            if(!_loc7_)
            {
               _loc7_ = getZoneTile();
               this._aZoneTile[_loc6_] = _loc7_;
               _loc7_.strata = this.currentStrata;
               _loc9_ = new ColorTransform();
               _loc7_.color = param2.color;
            }
            this._aCellTile[_loc6_] = param1[_loc6_];
            _loc7_.cellId = param1[_loc6_];
            _loc7_.text = this.getText(_loc6_);
            if((param5) || !(EntitiesDisplayManager.getInstance()._dStrataRef[_loc7_] == this.currentStrata))
            {
               _loc7_.strata = EntitiesDisplayManager.getInstance()._dStrataRef[_loc7_] = this.currentStrata;
            }
            _loc7_.display();
            _loc6_++;
         }
         while(_loc6_ < _loc8_)
         {
            _loc7_ = this._aZoneTile[_loc6_];
            if(_loc7_)
            {
               destroyZoneTile(_loc7_);
            }
            _loc6_++;
         }
      }
      
      protected function getText(param1:int) : String {
         return null;
      }
      
      public function remove(param1:Vector.<uint>, param2:DataMapContainer) : void {
         var _loc4_:* = 0;
         var _loc8_:ZoneTile = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:* = 0;
         var _loc5_:Array = new Array();
         var _loc6_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc5_[param1[_loc4_]] = true;
            _loc4_++;
         }
         _loc6_ = this._aCellTile.length;
         var _loc7_:* = 0;
         while(_loc7_ < _loc6_)
         {
            if(_loc5_[this._aCellTile[_loc7_]])
            {
               _loc3_++;
               _loc8_ = this._aZoneTile[_loc7_];
               if(_loc8_)
               {
                  destroyZoneTile(_loc8_);
               }
               this._aCellTile.splice(_loc7_,1);
               this._aZoneTile.splice(_loc7_,1);
               _loc7_--;
               _loc6_--;
            }
            _loc7_++;
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
