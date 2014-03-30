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
      
      public function DataMapContainer(mapData:Map) {
         super();
         if(!this._spMap)
         {
            this._spMap = new Sprite();
            this._aLayers = new Array();
            _aInteractiveCell = new Array();
         }
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onOptionChange);
         this.id = mapData.id;
         this.layerDepth = new Array();
         this._aCell = new Array();
         this._map = mapData;
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
         var sprite:Sprite = null;
         var parentSprite:Sprite = null;
         var cellReference:CellReference = null;
         var i:uint = 0;
         var k:uint = 0;
         while(k < this._aCell.length)
         {
            cellReference = this._aCell[k];
            if(cellReference)
            {
               i = 0;
               while(i < cellReference.listSprites.length)
               {
                  if(cellReference.listSprites[i] is Sprite)
                  {
                     sprite = cellReference.listSprites[i];
                     if(sprite)
                     {
                        sprite.cacheAsBitmap = false;
                        parentSprite = Sprite(sprite.parent);
                        if(parentSprite)
                        {
                           parentSprite.removeChild(sprite);
                           delete cellReference.listSprites[[i]];
                           if(!parentSprite.numChildren)
                           {
                              parentSprite.parent.removeChild(parentSprite);
                           }
                        }
                     }
                  }
                  i++;
               }
               delete this._aCell[[k]];
            }
            k++;
         }
         Atouin.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onOptionChange);
      }
      
      public function getCellReference(nId:uint) : CellReference {
         if(!this._aCell[nId])
         {
            this._aCell[nId] = new CellReference(nId);
         }
         return this._aCell[nId];
      }
      
      public function isRegisteredCell(nId:uint) : Boolean {
         return !(this._aCell[nId] == null);
      }
      
      public function getCell() : Array {
         return this._aCell;
      }
      
      public function getLayer(nId:int) : LayerContainer {
         if(!this._aLayers[nId])
         {
            this._aLayers[nId] = new LayerContainer(nId);
         }
         return this._aLayers[nId];
      }
      
      public function clean(bForceCleaning:Boolean=false) : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function get mapContainer() : Sprite {
         return this._spMap;
      }
      
      public function get dataMap() : Map {
         return this._map;
      }
      
      public function addAnimatedElement(element:WorldEntitySprite, data:EntityGraphicalElementData) : void {
         var d:Object = 
            {
               "element":element,
               "data":data
            };
         this._animatedElement.push(d);
         this.updateAnimatedElement(d);
      }
      
      public function setTemporaryAnimatedElementState(active:Boolean) : void {
         var d:Object = null;
         this._temporaryEnable = active;
         for each (d in this._animatedElement)
         {
            this.updateAnimatedElement(d);
         }
      }
      
      public function updateAllAnimatedElement() : void {
         var d:Object = null;
         for each (d in this._animatedElement)
         {
            this.updateAnimatedElement(d);
         }
      }
      
      public function get x() : Number {
         return this._spMap.x;
      }
      
      public function get y() : Number {
         return this._spMap.y;
      }
      
      public function set x(nValue:Number) : void {
         this._spMap.x = nValue;
      }
      
      public function set y(nValue:Number) : void {
         this._spMap.y = nValue;
      }
      
      public function get scaleX() : Number {
         return this._spMap.scaleX;
      }
      
      public function get scaleY() : Number {
         return this._spMap.scaleY;
      }
      
      public function set scaleX(nValue:Number) : void {
         this._spMap.scaleX = nValue;
      }
      
      public function set scaleY(nValue:Number) : void {
         this._spMap.scaleX = nValue;
      }
      
      public function addChild(item:DisplayObject) : DisplayObject {
         return this._spMap.addChild(item);
      }
      
      public function addChildAt(item:DisplayObject, index:int) : DisplayObject {
         return this._spMap.addChildAt(item,index);
      }
      
      public function getChildIndex(item:DisplayObject) : int {
         return this._spMap.getChildIndex(item);
      }
      
      public function contains(item:DisplayObject) : Boolean {
         return this._spMap.contains(item);
      }
      
      public function getChildByName(name:String) : DisplayObject {
         return this._spMap.getChildByName(name);
      }
      
      public function removeChild(item:DisplayObject) : DisplayObject {
         if((item.parent) && (item.parent == this._spMap))
         {
            return this._spMap.removeChild(item);
         }
         return null;
      }
      
      private function updateAnimatedElement(target:Object) : void {
         var ts:WorldEntitySprite = target.element;
         var eed:EntityGraphicalElementData = target.data;
         var allowAnimatedGfx:Boolean = (this._temporaryEnable) && (this._allowAnimatedGfx);
         if((allowAnimatedGfx) && (eed.playAnimation))
         {
            if(eed.maxDelay > 0)
            {
               AnimatedElementManager.removeAnimatedElement(ts);
               AnimatedElementManager.addAnimatedElement(ts,eed.minDelay * 1000,eed.maxDelay * 1000);
               if(eed.playAnimStatic)
               {
                  ts.setAnimation("AnimStatique");
               }
            }
            else
            {
               if(ts.getAnimation() != "AnimStart")
               {
                  ts.setAnimation("AnimStart");
               }
               else
               {
                  ts.restartAnimation();
               }
            }
         }
         else
         {
            AnimatedElementManager.removeAnimatedElement(ts);
            if(eed.playAnimation)
            {
               if(ts.hasAnimation("AnimStatique"))
               {
                  ts.setAnimation("AnimStatique");
               }
               else
               {
                  ts.stopAnimation();
               }
            }
            else
            {
               ts.stopAnimation();
            }
         }
      }
      
      private function onEntityRendered(e:TiphonEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onOptionChange(e:PropertyChangeEvent) : void {
         var d:Object = null;
         if(e.propertyName == "allowAnimatedGfx")
         {
            this._allowAnimatedGfx = e.propertyValue;
            for each (d in this._animatedElement)
            {
               this.updateAnimatedElement(d);
            }
         }
      }
   }
}
