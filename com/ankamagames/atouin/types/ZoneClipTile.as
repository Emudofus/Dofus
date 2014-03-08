package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.interfaces.ITransparency;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.BitmapData;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import flash.geom.Point;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import flash.system.ApplicationDomain;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import flash.display.Shape;
   import flash.display.Bitmap;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   
   public class ZoneClipTile extends Sprite implements IDisplayable, ITransparency
   {
      
      public function ZoneClipTile(pUri:Uri, pClipName:String="Bloc", pNeedBorders:Boolean=false) {
         var o:LoadedTile = null;
         this._borderSprites = new Array();
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this._needBorders = pNeedBorders;
         this._uri = pUri;
         this._clipName = pClipName;
         this._currentRessource = getRessource(pUri.fileName);
         if((this._currentRessource == null) || (loader == null) && (this._currentRessource == null))
         {
            o = new LoadedTile(this._uri.fileName);
            o.addClip(this._clipName);
            clips.push(o);
            this._currentRessource = o;
            loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            loader.addEventListener(ResourceLoadedEvent.LOADED,this.onClipLoaded);
            loader.load(this._uri,null,AdvancedSwfAdapter);
         }
         else
         {
            if((this._currentRessource.getClip(this._clipName) == null) || (this._currentRessource.getClip(this._clipName).clip == null))
            {
               if(!this._currentRessource.appDomain)
               {
                  loader.addEventListener(ResourceLoadedEvent.LOADED,this.onClipLoaded);
               }
               else
               {
                  this._currentRessource.addClip(this._clipName,this._currentRessource.appDomain.getDefinition(this._clipName));
                  this.display();
               }
            }
            else
            {
               this.display();
            }
         }
      }
      
      private static var clips:Array = new Array();
      
      private static var loader:IResourceLoader;
      
      private static var no_z_render_strata:Sprite = new Sprite();
      
      private static const BORDER_CLIP:String = "BlocageMvt";
      
      private static function getRessource(pFileName:String) : LoadedTile {
         var i:* = 0;
         var len:int = clips.length;
         i = 0;
         while(i < len)
         {
            if(clips[i].fileName == pFileName)
            {
               return clips[i] as LoadedTile;
            }
            i = i + 1;
         }
         return null;
      }
      
      public static function getTile(pUriName:String, pClipName:String) : Sprite {
         var o:LoadedTile = getRessource(pUriName);
         return new o.getClip(pClipName).clip();
      }
      
      private var _uri:Uri;
      
      private var _clipName:String;
      
      private var _needBorders:Boolean;
      
      private var _borderSprites:Array;
      
      private var _borderBitmapData:BitmapData;
      
      private var _displayMe:Boolean = false;
      
      private var _currentRessource:LoadedTile;
      
      private var _displayBehavior:IDisplayBehavior;
      
      protected var _displayed:Boolean;
      
      private var _currentCell:Point;
      
      private var _cellId:uint;
      
      public var strata:uint = 0;
      
      protected var _cellInstance:Sprite;
      
      private function onClipLoaded(e:ResourceLoadedEvent) : void {
         loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onClipLoaded);
         var appDomain:ApplicationDomain = e.resource.applicationDomain;
         var o:LoadedTile = getRessource(e.uri.fileName);
         if(o == null)
         {
            o = new LoadedTile(e.uri.fileName);
            o.addClip(this._clipName,appDomain.getDefinition(this._clipName));
            clips.push(o);
         }
         else
         {
            if((o.getClip(this._clipName) == null) || (o.getClip(this._clipName).clip == null))
            {
               o.addClip(this._clipName,appDomain.getDefinition(this._clipName));
            }
         }
         if(!o.appDomain)
         {
            o.appDomain = appDomain;
         }
         this._currentRessource = o;
         if(this._displayMe)
         {
            this._displayMe = false;
            this.display();
         }
      }
      
      public function display(wishedStrata:uint=0) : void {
         var r:Object = null;
         var spr:Sprite = null;
         var isLeftCol:* = false;
         var isRightCol:* = false;
         var isEvenRow:* = false;
         var spr2:Sprite = null;
         var spr3:Sprite = null;
         var cellSprite:Sprite = null;
         if((this._currentRessource == null) || (this._currentRessource.getClip(this._clipName) == null) || (this._currentRessource.getClip(this._clipName).clip == null))
         {
            this._displayMe = true;
         }
         else
         {
            r = this._currentRessource.getClip(this._clipName);
            if(r.clip != null)
            {
               this._cellInstance = new r.clip();
               addChild(this._cellInstance);
            }
            if(this._needBorders)
            {
               this._borderSprites = new Array();
               isLeftCol = this.cellId % 14 == 0;
               isRightCol = (this.cellId + 1) % 14 == 0;
               isEvenRow = Math.floor(this.cellId / 14) % 2 == 0;
               if((isLeftCol) && (isEvenRow))
               {
                  spr = this.getFakeTile();
                  spr.x = -AtouinConstants.CELL_HALF_WIDTH;
                  spr.y = -AtouinConstants.CELL_HALF_HEIGHT;
                  this._borderSprites.push(spr);
                  addChildAt(spr,0);
               }
               else
               {
                  if((isRightCol) && (!isEvenRow))
                  {
                     spr = this.getFakeTile();
                     spr.x = AtouinConstants.CELL_HALF_WIDTH;
                     spr.y = -AtouinConstants.CELL_HALF_HEIGHT;
                     this._borderSprites.push(spr);
                     addChildAt(spr,0);
                  }
               }
               if(this.cellId < 14)
               {
                  spr = this.getFakeTile();
                  spr.x = AtouinConstants.CELL_HALF_WIDTH;
                  spr.y = -AtouinConstants.CELL_HALF_HEIGHT;
                  this._borderSprites.push(spr);
                  addChildAt(spr,0);
               }
               else
               {
                  if(this.cellId > 545)
                  {
                     spr = this.getFakeTile();
                     spr.x = -AtouinConstants.CELL_HALF_WIDTH;
                     spr.y = AtouinConstants.CELL_HALF_HEIGHT;
                     this._borderSprites.push(spr);
                     addChild(spr);
                  }
               }
               if(this.cellId == 532)
               {
                  spr2 = this.getFakeTile();
                  spr2.x = -AtouinConstants.CELL_HALF_WIDTH;
                  spr2.y = AtouinConstants.CELL_HALF_HEIGHT;
                  this._borderSprites.push(spr2);
                  addChild(spr2);
               }
               else
               {
                  if(this.cellId == 559)
                  {
                     spr3 = this.getFakeTile();
                     spr3.x = AtouinConstants.CELL_HALF_WIDTH;
                     spr3.y = AtouinConstants.CELL_HALF_HEIGHT;
                     this._borderSprites.push(spr3);
                     addChild(spr3);
                  }
               }
            }
            if(this.strata != PlacementStrataEnums.STRATA_NO_Z_ORDER)
            {
               EntitiesDisplayManager.getInstance().displayEntity(this,MapPoint.fromCellId(this.cellId),this.strata);
            }
            else
            {
               cellSprite = InteractiveCellManager.getInstance().getCell(MapPoint.fromCellId(this.cellId).cellId);
               this.x = cellSprite.x + cellSprite.width / 2;
               this.y = cellSprite.y + cellSprite.height / 2;
               no_z_render_strata.addChild(this);
               if((!(Atouin.getInstance().selectionContainer == null)) && (!Atouin.getInstance().selectionContainer.contains(no_z_render_strata)))
               {
                  Atouin.getInstance().selectionContainer.addChildAt(no_z_render_strata,0);
               }
            }
            this._displayed = true;
         }
      }
      
      public function get displayBehaviors() : IDisplayBehavior {
         return this._displayBehavior;
      }
      
      public function set displayBehaviors(oValue:IDisplayBehavior) : void {
         this._displayBehavior = oValue;
      }
      
      public function get currentCellPosition() : Point {
         return this._currentCell;
      }
      
      public function set currentCellPosition(pValue:Point) : void {
         this._currentCell = pValue;
      }
      
      public function get displayed() : Boolean {
         return this._displayed;
      }
      
      public function get absoluteBounds() : IRectangle {
         return this._displayBehavior.getAbsoluteBounds(this);
      }
      
      public function get cellId() : uint {
         return this._cellId;
      }
      
      public function set cellId(nValue:uint) : void {
         this._cellId = nValue;
      }
      
      public function remove() : void {
         var spr:Sprite = null;
         this._displayed = false;
         if(this._borderSprites.length)
         {
            while(spr = this._borderSprites.pop())
            {
               removeChild(spr);
            }
         }
         if(this._cellInstance != null)
         {
            removeChild(this._cellInstance);
         }
         if(this.strata != PlacementStrataEnums.STRATA_NO_Z_ORDER)
         {
            EntitiesDisplayManager.getInstance().removeEntity(this);
         }
         else
         {
            if(no_z_render_strata.contains(this))
            {
               no_z_render_strata.removeChild(this);
            }
            if((no_z_render_strata.numChildren <= 0) && (Atouin.getInstance().selectionContainer) && (Atouin.getInstance().selectionContainer.contains(no_z_render_strata)))
            {
               Atouin.getInstance().selectionContainer.removeChild(no_z_render_strata);
            }
         }
      }
      
      public function getIsTransparencyAllowed() : Boolean {
         return true;
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      public function get clipName() : String {
         return this._clipName;
      }
      
      public function getFakeTile() : Sprite {
         var s:Shape = null;
         if(this._borderBitmapData == null)
         {
            s = new Shape();
            s.graphics.beginFill(16711680);
            s.graphics.moveTo(86 / 2,0);
            s.graphics.lineTo(86,43 / 2);
            s.graphics.lineTo(86 / 2,43);
            s.graphics.lineTo(0,43 / 2);
            s.graphics.endFill();
            this._borderBitmapData = new BitmapData(86,43,true,16711680);
            this._borderBitmapData.draw(s);
         }
         var bmp:Bitmap = new Bitmap(this._borderBitmapData);
         bmp.x = -86 / 2;
         bmp.y = -43 / 2;
         var spr:Sprite = new Sprite();
         spr.addChild(bmp);
         return spr;
      }
   }
}
import flash.system.ApplicationDomain;

class LoadedTile extends Object
{
   
   function LoadedTile(pName:String) {
      super();
      this.fileName = pName;
      this._clips = new Array();
   }
   
   public var fileName:String;
   
   public var appDomain:ApplicationDomain;
   
   private var _clips:Array;
   
   public function addClip(pName:String, pClip:Object=null) : void {
      var o:Object = this.getClip(pName);
      if(o == null)
      {
         o = new Object();
         o.clipName = pName;
         o.clip = pClip;
         this._clips.push(o);
      }
      else
      {
         o.clip = pClip;
      }
   }
   
   public function getClip(pName:String) : Object {
      var o:Object = null;
      for each (o in this._clips)
      {
         if(o.clipName == pName)
         {
            return o;
         }
      }
      return null;
   }
}
