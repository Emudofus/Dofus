package com.ankamagames.atouin.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.Sprite;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.atouin.utils.VisibleCellDetection;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.data.elements.subtypes.EntityGraphicalElementData;
   import flash.display.DisplayObject;
   import com.ankamagames.atouin.managers.AnimatedElementManager;
   import com.ankamagames.tiphon.events.TiphonEvent;
   
   public class DataMapContainer extends Object
   {
      
      public function DataMapContainer(param1:Map) {
         super();
         if(!this._spMap)
         {
            this._spMap = new Sprite();
            this._aLayers = new Array();
            _aInteractiveCell = new Array();
         }
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onOptionChange);
         this.id = param1.id;
         this.layerDepth = new Array();
         this._aCell = new Array();
         this._map = param1;
         this._animatedElement = new Array();
         this._allowAnimatedGfx = Atouin.getInstance().options.allowAnimatedGfx;
      }
      
      private static var _aInteractiveCell:Array;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DataMapContainer));
      
      public static function get interactiveCell() : Array {
         return _aInteractiveCell;
      }
      
      private var _spMap:Sprite;
      
      private var _aLayers:Array;
      
      private var _aCell:Array;
      
      private var _map:Map;
      
      private var _animatedElement:Array;
      
      private var _allowAnimatedGfx:Boolean;
      
      private var _temporaryEnable:Boolean = true;
      
      public var layerDepth:Array;
      
      public var id:int;
      
      public var rendered:Boolean = false;
      
      public function removeContainer() : void {
         var _loc1_:Sprite = null;
         var _loc2_:Sprite = null;
         var _loc3_:CellReference = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < this._aCell.length)
         {
            _loc3_ = this._aCell[_loc5_];
            if(_loc3_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.listSprites.length)
               {
                  if(_loc3_.listSprites[_loc4_] is Sprite)
                  {
                     _loc1_ = _loc3_.listSprites[_loc4_];
                     if(_loc1_)
                     {
                        _loc1_.cacheAsBitmap = false;
                        _loc2_ = Sprite(_loc1_.parent);
                        if(_loc2_)
                        {
                           _loc2_.removeChild(_loc1_);
                           delete _loc3_.listSprites[[_loc4_]];
                           if(!_loc2_.numChildren)
                           {
                              _loc2_.parent.removeChild(_loc2_);
                           }
                        }
                     }
                  }
                  _loc4_++;
               }
               delete this._aCell[[_loc5_]];
            }
            _loc5_++;
         }
         Atouin.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onOptionChange);
      }
      
      public function getCellReference(param1:uint) : CellReference {
         if(!this._aCell[param1])
         {
            this._aCell[param1] = new CellReference(param1);
         }
         return this._aCell[param1];
      }
      
      public function isRegisteredCell(param1:uint) : Boolean {
         return !(this._aCell[param1] == null);
      }
      
      public function getCell() : Array {
         return this._aCell;
      }
      
      public function getLayer(param1:int) : LayerContainer {
         if(!this._aLayers[param1])
         {
            this._aLayers[param1] = new LayerContainer(param1);
         }
         return this._aLayers[param1];
      }
      
      public function clean(param1:Boolean=false) : Boolean {
         var _loc2_:Sprite = null;
         var _loc3_:Sprite = null;
         var _loc4_:CellReference = null;
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:WorldPoint = null;
         if(!param1)
         {
            _loc6_ = VisibleCellDetection.detectCell(false,this._map,WorldPoint.fromMapId(this.id),Atouin.getInstance().options.frustum,MapDisplayManager.getInstance().currentMapPoint).cell;
         }
         else
         {
            _loc6_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < this._aCell.length)
            {
               _loc6_[_loc5_] = _loc5_;
               _loc5_++;
            }
         }
         for (_loc7_ in _loc6_)
         {
            _loc4_ = this._aCell[_loc7_];
            if(_loc4_)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc4_.listSprites.length)
               {
                  _loc2_ = _loc4_.listSprites[_loc5_];
                  if(_loc2_)
                  {
                     _loc2_.cacheAsBitmap = false;
                     _loc3_ = Sprite(_loc2_.parent);
                     _loc3_.removeChild(_loc2_);
                     delete _loc4_.listSprites[[_loc5_]];
                     if(!_loc3_.numChildren)
                     {
                        _loc3_.parent.removeChild(_loc3_);
                     }
                  }
                  _loc5_++;
               }
               delete this._aCell[[_loc7_]];
            }
         }
         _loc8_ = WorldPoint.fromMapId(this._map.id);
         _loc8_.x = _loc8_.x - MapDisplayManager.getInstance().currentMapPoint.x;
         _loc8_.y = _loc8_.y - MapDisplayManager.getInstance().currentMapPoint.y;
         return Math.abs(_loc8_.x) > 1 || Math.abs(_loc8_.y) > 1;
      }
      
      public function get mapContainer() : Sprite {
         return this._spMap;
      }
      
      public function get dataMap() : Map {
         return this._map;
      }
      
      public function addAnimatedElement(param1:WorldEntitySprite, param2:EntityGraphicalElementData) : void {
         var _loc3_:Object = 
            {
               "element":param1,
               "data":param2
            };
         this._animatedElement.push(_loc3_);
         this.updateAnimatedElement(_loc3_);
      }
      
      public function setTemporaryAnimatedElementState(param1:Boolean) : void {
         var _loc2_:Object = null;
         this._temporaryEnable = param1;
         for each (_loc2_ in this._animatedElement)
         {
            this.updateAnimatedElement(_loc2_);
         }
      }
      
      public function updateAllAnimatedElement() : void {
         var _loc1_:Object = null;
         for each (_loc1_ in this._animatedElement)
         {
            this.updateAnimatedElement(_loc1_);
         }
      }
      
      public function get x() : Number {
         return this._spMap.x;
      }
      
      public function get y() : Number {
         return this._spMap.y;
      }
      
      public function set x(param1:Number) : void {
         this._spMap.x = param1;
      }
      
      public function set y(param1:Number) : void {
         this._spMap.y = param1;
      }
      
      public function get scaleX() : Number {
         return this._spMap.scaleX;
      }
      
      public function get scaleY() : Number {
         return this._spMap.scaleY;
      }
      
      public function set scaleX(param1:Number) : void {
         this._spMap.scaleX = param1;
      }
      
      public function set scaleY(param1:Number) : void {
         this._spMap.scaleX = param1;
      }
      
      public function addChild(param1:DisplayObject) : DisplayObject {
         return this._spMap.addChild(param1);
      }
      
      public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject {
         return this._spMap.addChildAt(param1,param2);
      }
      
      public function getChildIndex(param1:DisplayObject) : int {
         return this._spMap.getChildIndex(param1);
      }
      
      public function contains(param1:DisplayObject) : Boolean {
         return this._spMap.contains(param1);
      }
      
      public function getChildByName(param1:String) : DisplayObject {
         return this._spMap.getChildByName(param1);
      }
      
      public function removeChild(param1:DisplayObject) : DisplayObject {
         if((param1.parent) && param1.parent == this._spMap)
         {
            return this._spMap.removeChild(param1);
         }
         return null;
      }
      
      private function updateAnimatedElement(param1:Object) : void {
         var _loc2_:WorldEntitySprite = param1.element;
         var _loc3_:EntityGraphicalElementData = param1.data;
         var _loc4_:Boolean = (this._temporaryEnable) && (this._allowAnimatedGfx);
         if((_loc4_) && (_loc3_.playAnimation))
         {
            if(_loc3_.maxDelay > 0)
            {
               AnimatedElementManager.removeAnimatedElement(_loc2_);
               AnimatedElementManager.addAnimatedElement(_loc2_,_loc3_.minDelay * 1000,_loc3_.maxDelay * 1000);
               if(_loc3_.playAnimStatic)
               {
                  _loc2_.setAnimation("AnimStatique");
               }
            }
            else
            {
               if(_loc2_.getAnimation() != "AnimStart")
               {
                  _loc2_.setAnimation("AnimStart");
               }
               else
               {
                  _loc2_.restartAnimation();
               }
            }
         }
         else
         {
            AnimatedElementManager.removeAnimatedElement(_loc2_);
            if(_loc3_.playAnimation)
            {
               if(_loc2_.hasAnimation("AnimStatique"))
               {
                  _loc2_.setAnimation("AnimStatique");
               }
               else
               {
                  _loc2_.stopAnimation();
               }
            }
            else
            {
               _loc2_.stopAnimation();
            }
         }
      }
      
      private function onEntityRendered(param1:TiphonEvent) : void {
         var _loc2_:Object = null;
         for each (_loc2_ in this._animatedElement)
         {
            if(_loc2_.element == param1.sprite)
            {
               param1.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
               this.updateAnimatedElement(_loc2_);
               break;
            }
         }
         param1.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
      }
      
      private function onOptionChange(param1:PropertyChangeEvent) : void {
         var _loc2_:Object = null;
         if(param1.propertyName == "allowAnimatedGfx")
         {
            this._allowAnimatedGfx = param1.propertyValue;
            for each (_loc2_ in this._animatedElement)
            {
               this.updateAnimatedElement(_loc2_);
            }
         }
      }
   }
}
