package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellZoneCellManager;
   import com.ankamagames.jerakine.utils.display.spellZone.ICellZoneProvider;
   import com.ankamagames.jerakine.utils.display.spellZone.IZoneShape;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellZoneComponent extends GraphicContainer implements FinalizableUIComponent
   {
      
      public function SpellZoneComponent() {
         super();
         disabled = false;
         this._spellZoneManager = new SpellZoneCellManager();
         addChild(this._spellZoneManager);
      }
      
      private var _cellWidth:Number;
      
      private var _cellHeight:Number;
      
      private var _spellRange:uint;
      
      private var _centerCellId:uint;
      
      private var _verticalCells:uint;
      
      private var _horizontalCells:uint;
      
      private var _cellRatio:Number = 2;
      
      private var _spellZoneManager:SpellZoneCellManager;
      
      private var _spellLevel:ICellZoneProvider;
      
      private var _infiniteLabel:Label;
      
      private var _minRange:uint;
      
      private var _maxRange:uint;
      
      private var _infiniteRange:Boolean = false;
      
      private var _finalized:Boolean;
      
      public function setSpellLevel(param1:ICellZoneProvider) : void {
         var _loc5_:Object = null;
         this._spellLevel = param1;
         this._spellZoneManager.spellLevel = this._spellLevel;
         var _loc2_:Boolean = this._spellLevel.minimalRange == 0 && this._spellLevel.maximalRange == 0 || this._spellLevel.maximalRange == 63;
         var _loc3_:* = false;
         var _loc4_:* = true;
         for each (_loc5_ in this._spellLevel.spellZoneEffects)
         {
            if(!(_loc5_.zoneSize == 0 && _loc5_.zoneShape == 80))
            {
               _loc4_ = false;
            }
         }
         if((_loc2_) && !_loc4_ || (_loc3_))
         {
            this._infiniteRange = false;
            return;
         }
         this._infiniteRange = false;
         this.setRange(this._spellLevel.minimalRange,this._spellLevel.maximalRange);
      }
      
      private function setRange(param1:uint, param2:uint) : void {
         var _loc3_:uint = 0;
         var _loc4_:IZoneShape = null;
         this._minRange = param1;
         this._maxRange = param2;
         this._horizontalCells = this._maxRange + 2 + 1;
         if(this._spellLevel)
         {
            _loc3_ = 0;
            for each (_loc4_ in this._spellLevel.spellZoneEffects)
            {
               if(_loc3_ < _loc4_.zoneSize / 2 && !(_loc4_.zoneSize == 63))
               {
                  _loc3_ = _loc4_.zoneSize;
               }
            }
            this._horizontalCells = this._horizontalCells + _loc3_;
         }
         if(this._horizontalCells % 2 == 0)
         {
            this._horizontalCells++;
         }
         if(this._horizontalCells > 14)
         {
            this._horizontalCells = 14;
         }
         this._verticalCells = this._horizontalCells * 2-1;
         if(this._verticalCells > 20)
         {
            this._verticalCells = 20;
         }
         this._centerCellId = this.getCenterCellId(this._horizontalCells);
      }
      
      public function removeCells() : void {
         this._spellZoneManager.remove();
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function set finalized(param1:Boolean) : void {
         this._finalized = param1;
      }
      
      public function finalize() : void {
         var _loc1_:String = null;
         if(this._infiniteRange)
         {
            if(this.contains(this._spellZoneManager))
            {
               removeChild(this._spellZoneManager);
            }
            if((this._infiniteLabel) && (this.contains(this._infiniteLabel)))
            {
               return;
            }
            this._infiniteLabel = new Label();
            this._infiniteLabel.width = this.width;
            this._infiniteLabel.multiline = true;
            this._infiniteLabel.wordWrap = true;
            this._infiniteLabel.css = new Uri("[config.ui.skin]css/normal.css");
            this._infiniteLabel.cssClass = "center";
            _loc1_ = I18n.getUiText("ui.common.infiniteRange");
            this._infiniteLabel.text = _loc1_;
            addChild(this._infiniteLabel);
            this._infiniteLabel.y = (height - this._infiniteLabel.height) / 2;
         }
         else
         {
            if((this._infiniteLabel) && (this.contains(this._infiniteLabel)))
            {
               removeChild(this._infiniteLabel);
            }
            if(!this.contains(this._spellZoneManager))
            {
               addChild(this._spellZoneManager);
            }
            this._spellZoneManager.setDisplayZone(__width,__height);
            this._cellWidth = __width / this._horizontalCells;
            this._cellHeight = this._cellWidth / this._cellRatio;
            this._spellZoneManager.show();
            this._finalized = true;
            getUi().iAmFinalized(this);
         }
      }
      
      override public function remove() : void {
         this.removeCells();
      }
      
      private function getCenterCellId(param1:uint) : uint {
         var _loc2_:uint = param1;
         var _loc3_:uint = 0;
         var _loc4_:uint = MapPoint.fromCoords(_loc2_,_loc3_).cellId;
         return _loc4_;
      }
   }
}
