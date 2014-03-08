package com.ankamagames.berilia.types.data
{
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.resources.loaders.impl.ParallelRessourceLoader;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.Bitmap;
   import flash.utils.Timer;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import flash.events.Event;
   
   public class MapArea extends Rectangle
   {
      
      public function MapArea(param1:Uri, param2:Number, param3:Number, param4:Number, param5:Number, param6:Map) {
         this.src = param1;
         this.parent = param6;
         super(param2,param3,param4,param5);
      }
      
      private static var _mapLoader:ParallelRessourceLoader = new ParallelRessourceLoader(10);
      
      private static var _freeBitmap:Array = [];
      
      public static var currentScale:Number;
      
      public var src:Uri;
      
      public var parent:Map;
      
      private var _bitmap:Bitmap;
      
      private var _active:Boolean;
      
      private var _freeTimer:Timer;
      
      public function get isUsed() : Boolean {
         return this._active;
      }
      
      public function getBitmap() : DisplayObject {
         this._active = true;
         if(this._freeTimer)
         {
            this._freeTimer.removeEventListener(TimerEvent.TIMER,this.onDeathCountDown);
            this._freeTimer.stop();
            this._freeTimer = null;
         }
         if(!this._bitmap || !this._bitmap.bitmapData)
         {
            if(_freeBitmap.length)
            {
               this._bitmap = _freeBitmap.pop();
            }
            else
            {
               this._bitmap = new Bitmap();
            }
            _mapLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoad);
            this._bitmap.x = x;
            this._bitmap.y = y;
            _mapLoader.load(this.src);
         }
         return this._bitmap;
      }
      
      public function free(param1:Boolean=false) : void {
         this._active = false;
         if(param1)
         {
            this.onDeathCountDown(null);
            return;
         }
         if(!this._freeTimer)
         {
            this._freeTimer = new Timer(3000);
            this._freeTimer.addEventListener(TimerEvent.TIMER,this.onDeathCountDown);
         }
         this._freeTimer.start();
      }
      
      private function onDeathCountDown(param1:Event) : void {
         if(this._freeTimer)
         {
            this._freeTimer.removeEventListener(TimerEvent.TIMER,this.onDeathCountDown);
            this._freeTimer.stop();
            this._freeTimer = null;
         }
         if(this._active)
         {
            return;
         }
         if(this._bitmap)
         {
            if(this._bitmap.parent)
            {
               this._bitmap.parent.removeChild(this._bitmap);
            }
            this._bitmap.bitmapData = null;
            if(this._bitmap.bitmapData)
            {
               this._bitmap.bitmapData.dispose();
            }
            _freeBitmap.push(this._bitmap);
            this._bitmap = null;
         }
      }
      
      private function onLoad(param1:ResourceLoadedEvent) : void {
         var _loc2_:* = false;
         if((this._active) && param1.uri == this.src)
         {
            this._bitmap.bitmapData = param1.resource;
            _loc2_ = !(this._bitmap.width == this._bitmap.height);
            this._bitmap.width = width + 1;
            this._bitmap.height = height + 1;
            if(!_loc2_)
            {
               return;
            }
            if(isNaN(currentScale))
            {
               if(this._bitmap.scaleX == this._bitmap.scaleY)
               {
                  currentScale = this._bitmap.scaleX;
               }
               else
               {
                  if(x + width > this.parent.initialWidth)
                  {
                     currentScale = this._bitmap.scaleY;
                  }
                  else
                  {
                     if(y + height > this.parent.initialHeight)
                     {
                        currentScale = this._bitmap.scaleX;
                     }
                  }
               }
            }
            if(!(this._bitmap.scaleX == this._bitmap.scaleY) && (currentScale))
            {
               this._bitmap.scaleX = this._bitmap.scaleY = currentScale;
            }
         }
      }
   }
}
