package com.ankamagames.atouin
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.atouin.types.AtouinOptions;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import flash.events.MouseEvent;
   import com.ankamagames.atouin.managers.FrustumManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import com.ankamagames.atouin.messages.MapContainerRollOverMessage;
   import com.ankamagames.atouin.messages.MapContainerRollOutMessage;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.types.Frustum;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.interfaces.ISoundPositionListener;
   import com.ankamagames.atouin.messages.MapZoomMessage;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.pathfinding.Pathfinding;
   import com.ankamagames.atouin.utils.errors.AtouinError;
   import com.ankamagames.jerakine.resources.adapters.AdapterFactory;
   import com.ankamagames.atouin.resources.adapters.ElementsAdapter;
   import com.ankamagames.atouin.resources.adapters.MapsAdapter;
   
   public class Atouin extends Object
   {
      
      public function Atouin() {
         super();
         if(_self)
         {
            throw new AtouinError("Atouin is a singleton class. Please acces it through getInstance()");
         }
         else
         {
            AdapterFactory.addAdapter("ele",ElementsAdapter);
            AdapterFactory.addAdapter("dlm",MapsAdapter);
            this._cursorUpdateSprite = new Sprite();
            this._cursorUpdateSprite.graphics.beginFill(65280,0);
            this._cursorUpdateSprite.graphics.drawRect(0,0,6,6);
            this._cursorUpdateSprite.graphics.endFill();
            this._cursorUpdateSprite.useHandCursor = true;
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Atouin));
      
      private static var _self:Atouin;
      
      public static function getInstance() : Atouin {
         if(!_self)
         {
            _self = new Atouin();
         }
         return _self;
      }
      
      private var _worldContainer:DisplayObjectContainer;
      
      private var _overlayContainer:Sprite;
      
      private var _spMapContainer:Sprite;
      
      private var _spGfxontainer:Sprite;
      
      private var _spChgMapContainer:Sprite;
      
      private var _worldMask:Sprite;
      
      private var _currentZoom:Number = 1;
      
      private var _zoomPosX:int;
      
      private var _zoomPosY:int;
      
      private var _movementListeners:Array;
      
      private var _handler:MessageHandler;
      
      private var _aSprites:Array;
      
      private var _aoOptions:AtouinOptions;
      
      private var _cursorUpdateSprite:Sprite;
      
      public function get movementListeners() : Array {
         return this._movementListeners;
      }
      
      public function get worldContainer() : DisplayObjectContainer {
         return this._spMapContainer;
      }
      
      public function get selectionContainer() : DisplayObjectContainer {
         var ctr:DisplayObjectContainer = null;
         var i:* = 0;
         if(this._spMapContainer == null)
         {
            return null;
         }
         var len:Number = this._spMapContainer.numChildren;
         if(len > 1)
         {
            i = 1;
            while((!ctr) && (i < len))
            {
               ctr = this._spMapContainer.getChildAt(i) as DisplayObjectContainer;
               i++;
            }
         }
         return ctr;
      }
      
      public function get chgMapContainer() : DisplayObjectContainer {
         return this._spChgMapContainer;
      }
      
      public function get gfxContainer() : DisplayObjectContainer {
         return this._spGfxontainer;
      }
      
      public function get overlayContainer() : DisplayObjectContainer {
         return this._overlayContainer;
      }
      
      public function get handler() : MessageHandler {
         return this._handler;
      }
      
      public function set handler(value:MessageHandler) : void {
         this._handler = value;
      }
      
      public function get options() : AtouinOptions {
         return this._aoOptions;
      }
      
      public function get currentZoom() : Number {
         return this._currentZoom;
      }
      
      public function set currentZoom(value:Number) : void {
         this._currentZoom = value;
      }
      
      public function get cellOverEnabled() : Boolean {
         return InteractiveCellManager.getInstance().cellOverEnabled;
      }
      
      public function set cellOverEnabled(value:Boolean) : void {
         InteractiveCellManager.getInstance().cellOverEnabled = value;
      }
      
      public function get rootContainer() : DisplayObjectContainer {
         return this._worldContainer;
      }
      
      public function get worldIsVisible() : Boolean {
         return this._worldContainer.contains(this._spMapContainer);
      }
      
      public function setDisplayOptions(ao:AtouinOptions) : void {
         this._aoOptions = ao;
         this._worldContainer = ao.container;
         this._handler = ao.handler;
         var i:uint = 0;
         while(i < this._worldContainer.numChildren)
         {
            this._worldContainer.removeChildAt(i);
            i++;
         }
         this._overlayContainer = new Sprite();
         this._spMapContainer = new Sprite();
         this._spChgMapContainer = new Sprite();
         this._spGfxontainer = new Sprite();
         this._worldContainer.mouseEnabled = false;
         this._spMapContainer.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutMapContainer);
         this._spMapContainer.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverMapContainer);
         this._spMapContainer.tabChildren = false;
         this._spMapContainer.mouseEnabled = false;
         this._spChgMapContainer.tabChildren = false;
         this._spChgMapContainer.mouseEnabled = false;
         this._spGfxontainer.tabChildren = false;
         this._spGfxontainer.mouseEnabled = false;
         this._spGfxontainer.mouseChildren = false;
         this._overlayContainer.tabChildren = false;
         this._overlayContainer.mouseEnabled = false;
         this._worldContainer.addChild(this._spMapContainer);
         this._worldContainer.addChild(this._spChgMapContainer);
         this._worldContainer.addChild(this._spGfxontainer);
         this._worldContainer.addChild(this._overlayContainer);
         FrustumManager.getInstance().init(this._spChgMapContainer);
         this._worldMask = new Sprite();
         this._worldMask.graphics.beginFill(0);
         var w:int = StageShareManager.startWidth;
         var h:int = StageShareManager.startHeight;
         this._worldMask.graphics.drawRect(-2000,-2000,4000 + w,4000 + h);
         this._worldMask.graphics.drawRect(0,0,w,h);
         this._worldMask.graphics.endFill();
         DisplayObjectContainer(this._worldContainer.parent).addChild(this._worldMask);
         this.setFrustrum(ao.frustum);
         this.init();
      }
      
      public function onRollOverMapContainer(event:Event) : void {
         var msg:MapContainerRollOverMessage = new MapContainerRollOverMessage();
         Atouin.getInstance().handler.process(msg);
      }
      
      private function onRollOutMapContainer(event:Event) : void {
         var msg:MapContainerRollOutMessage = new MapContainerRollOutMessage();
         Atouin.getInstance().handler.process(msg);
      }
      
      public function updateCursor() : void {
         this._cursorUpdateSprite.x = StageShareManager.stage.mouseX - 3;
         this._cursorUpdateSprite.y = StageShareManager.stage.mouseY - 3;
         StageShareManager.stage.addChild(this._cursorUpdateSprite);
         EnterFrameDispatcher.addEventListener(this.removeUpdateCursorSprite,"UpdateCursorSprite",50);
      }
      
      public function showWorld(b:Boolean, resetAnimations:Boolean=false) : void {
         if(b)
         {
            this._worldContainer.addChild(this._spMapContainer);
            this._worldContainer.addChild(this._spChgMapContainer);
            this._worldContainer.addChild(this._spGfxontainer);
            this._worldContainer.addChild(this._overlayContainer);
            if((resetAnimations) && (MapDisplayManager.getInstance()) && (MapDisplayManager.getInstance().getDataMapContainer()))
            {
               MapDisplayManager.getInstance().getDataMapContainer().updateAllAnimatedElement();
            }
         }
         else
         {
            if(this._spMapContainer.parent)
            {
               this._worldContainer.removeChild(this._spMapContainer);
            }
            if(this._spChgMapContainer.parent)
            {
               this._worldContainer.removeChild(this._spChgMapContainer);
            }
            if(this._spGfxontainer.parent)
            {
               this._worldContainer.removeChild(this._spGfxontainer);
            }
            if(this._overlayContainer.parent)
            {
               this._worldContainer.removeChild(this._overlayContainer);
            }
         }
      }
      
      public function setFrustrum(f:Frustum) : void {
         if(!this._aoOptions)
         {
            _log.error("Please call setDisplayOptions once before calling setFrustrum");
            return;
         }
         this._aoOptions.frustum = f;
         this.worldContainer.scaleX = this._aoOptions.frustum.scale;
         this.worldContainer.scaleY = this._aoOptions.frustum.scale;
         this.worldContainer.x = this._aoOptions.frustum.x;
         this.worldContainer.y = this._aoOptions.frustum.y;
         this.gfxContainer.scaleX = this._aoOptions.frustum.scale;
         this.gfxContainer.scaleY = this._aoOptions.frustum.scale;
         this.gfxContainer.x = this._aoOptions.frustum.x;
         this.gfxContainer.y = this._aoOptions.frustum.y;
         this.overlayContainer.x = this._aoOptions.frustum.x;
         this.overlayContainer.y = this._aoOptions.frustum.y;
         this.overlayContainer.scaleX = this._aoOptions.frustum.scale;
         this.overlayContainer.scaleY = this._aoOptions.frustum.scale;
         FrustumManager.getInstance().frustum = f;
      }
      
      public function initPreDisplay(wp:WorldPoint) : void {
         if(((wp) && (MapDisplayManager.getInstance())) && (MapDisplayManager.getInstance().currentMapPoint) && (MapDisplayManager.getInstance().currentMapPoint.mapId == wp.mapId))
         {
            return;
         }
         MapDisplayManager.getInstance().capture();
      }
      
      public function display(wpMap:WorldPoint, decryptionKey:ByteArray=null) : uint {
         return MapDisplayManager.getInstance().display(wpMap,false,decryptionKey);
      }
      
      public function getEntity(id:int) : IEntity {
         return EntitiesManager.getInstance().getEntity(id);
      }
      
      public function getEntityOnCell(cellId:uint, oClass:*=null) : IEntity {
         return EntitiesManager.getInstance().getEntityOnCell(cellId,oClass);
      }
      
      public function clearEntities() : void {
         EntitiesManager.getInstance().clearEntities();
      }
      
      public function reset() : void {
         InteractiveCellManager.getInstance().clean();
         MapDisplayManager.getInstance().reset();
         EntitiesManager.getInstance().clearEntities();
         this.cancelZoom();
         this.showWorld(false);
      }
      
      public function displayGrid(b:Boolean, pIsInFight:Boolean=false) : void {
         InteractiveCellManager.getInstance().show((b) || (this.options.alwaysShowGrid),pIsInFight);
      }
      
      public function getIdentifiedElement(id:uint) : InteractiveObject {
         return MapDisplayManager.getInstance().getIdentifiedElement(id);
      }
      
      public function getIdentifiedElementPosition(id:uint) : MapPoint {
         return MapDisplayManager.getInstance().getIdentifiedElementPosition(id);
      }
      
      public function addListener(pListener:ISoundPositionListener) : void {
         if(this._movementListeners == null)
         {
            this._movementListeners = new Array();
         }
         this._movementListeners.push(pListener);
      }
      
      public function removeListener(pListener:ISoundPositionListener) : void {
         var index:int = Atouin.getInstance()._movementListeners.indexOf(pListener);
         if(index)
         {
            Atouin.getInstance()._movementListeners.splice(index,1);
         }
      }
      
      public function zoom(value:Number, posX:int=0, posY:int=0) : void {
         var lastZoom:* = NaN;
         if(value == 1)
         {
            this._worldContainer.scaleX = 1;
            this._worldContainer.scaleY = 1;
            this._worldContainer.x = 0;
            this._worldContainer.y = 0;
            this._currentZoom = 1;
            MapDisplayManager.getInstance().cacheAsBitmapEnabled(true);
         }
         else
         {
            if(value < 1)
            {
               value = 1;
            }
            else
            {
               if(value > AtouinConstants.MAX_ZOOM)
               {
                  value = AtouinConstants.MAX_ZOOM;
               }
            }
            lastZoom = this._currentZoom;
            this._currentZoom = value;
            if(lastZoom == this._currentZoom)
            {
               return;
            }
            if(this._currentZoom != 1)
            {
               MapDisplayManager.getInstance().cacheAsBitmapEnabled(false);
            }
            if(posX)
            {
               this._zoomPosX = posX;
            }
            else
            {
               posX = this._zoomPosX;
            }
            if(posY)
            {
               this._zoomPosY = posY;
            }
            else
            {
               posY = this._zoomPosY;
            }
            this._worldContainer.x = this._worldContainer.x - (posX * this._currentZoom - posX * this._worldContainer.scaleX);
            this._worldContainer.y = this._worldContainer.y - (posY * this._currentZoom - posY * this._worldContainer.scaleY);
            this._worldContainer.scaleX = this._currentZoom;
            this._worldContainer.scaleY = this._currentZoom;
            if(this._worldContainer.x > 0)
            {
               this._worldContainer.x = 0;
            }
            else
            {
               if(this._worldContainer.x < 1276 - 1276 * this._currentZoom)
               {
                  this._worldContainer.x = 1276 - 1276 * this._currentZoom;
               }
            }
            if(this._worldContainer.y > 0)
            {
               this._worldContainer.y = 0;
            }
            else
            {
               if(this._worldContainer.y < 876 - 876 * this._currentZoom)
               {
                  this._worldContainer.y = 876 - 876 * this._currentZoom;
               }
            }
         }
         var mzm:MapZoomMessage = new MapZoomMessage(this._currentZoom,posX,posY);
         Atouin.getInstance().handler.process(mzm);
      }
      
      public function cancelZoom() : void {
         if(this._currentZoom != 1)
         {
            this.zoom(1);
         }
      }
      
      private function removeUpdateCursorSprite(e:Event) : void {
         EnterFrameDispatcher.removeEventListener(this.removeUpdateCursorSprite);
         if(this._cursorUpdateSprite.parent)
         {
            this._cursorUpdateSprite.parent.removeChild(this._cursorUpdateSprite);
         }
      }
      
      private function init() : void {
         var elementsLoader:IResourceLoader = null;
         this._aSprites = new Array();
         if(!Elements.getInstance().parsed)
         {
            elementsLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            elementsLoader.addEventListener(ResourceErrorEvent.ERROR,this.onElementsError);
            elementsLoader.load(new Uri(Atouin.getInstance().options.elementsIndexPath));
         }
         Pathfinding.init(AtouinConstants.PATHFINDER_MIN_X,AtouinConstants.PATHFINDER_MAX_X,AtouinConstants.PATHFINDER_MIN_Y,AtouinConstants.PATHFINDER_MAX_Y);
      }
      
      private function onElementsError(ree:ResourceErrorEvent) : void {
      }
   }
}
