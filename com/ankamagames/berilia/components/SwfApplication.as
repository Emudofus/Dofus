package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.UIComponent;
   import flash.display.Loader;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import flash.net.URLRequest;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   
   public class SwfApplication extends GraphicContainer implements UIComponent
   {
      
      public function SwfApplication() {
         super();
         mouseEnabled = true;
      }
      
      private var _ldr:Loader;
      
      private var _uri:Uri;
      
      private var _app:DisplayObject;
      
      public function set uri(param1:Uri) : void {
         if(!getUi() || !getUi().uiModule.trusted)
         {
            return;
         }
         this._uri = param1;
         this.initLoader();
         this._ldr.load(new URLRequest(param1.normalizedUri));
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      public var loadedHandler:Function;
      
      public var loadErrorHandler:Function;
      
      public var loadProgressHandler:Function;
      
      override public function set width(param1:Number) : void {
         super.width = param1;
         if(this._app)
         {
            this._app.width = param1;
         }
      }
      
      override public function set height(param1:Number) : void {
         super.height = param1;
         if(this._app)
         {
            this._app.height = param1;
         }
      }
      
      override public function remove() : void {
         this.clearLoader();
         if((this._ldr) && (this._ldr.contentLoaderInfo))
         {
            this._ldr.contentLoaderInfo.removeEventListener(Event.INIT,this.onInit);
            this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         }
         if(this._app)
         {
            this._app.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMouse);
         }
         this._ldr = null;
         this.loadedHandler = null;
         this.loadErrorHandler = null;
      }
      
      public function bindApi(param1:String, param2:*) : Boolean {
         var propertyName:String = param1;
         var value:* = param2;
         if(!getUi() || !getUi().uiModule.trusted)
         {
            return false;
         }
         if(!this._app)
         {
            return false;
         }
         try
         {
            this._app[propertyName] = value;
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      private function initLoader() : void {
         if(!this._ldr)
         {
            this._ldr = new Loader();
            this._ldr.contentLoaderInfo.addEventListener(Event.INIT,this.onInit);
            this._ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         }
         else
         {
            this.clearLoader();
         }
      }
      
      private function clearLoader() : void {
         if(this._ldr)
         {
            this._ldr.unloadAndStop();
         }
         while(numChildren)
         {
            removeChildAt(0);
         }
      }
      
      private function onInit(param1:Event) : void {
         this._app = this._ldr.content;
         this._app.width = width;
         this._app.height = height;
         addChild(this._app);
         this._app.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMouse);
         if(this.loadedHandler != null)
         {
            this.loadedHandler(this);
         }
      }
      
      private function onMouseMouse(param1:MouseEvent) : void {
         stage.dispatchEvent(param1);
      }
      
      private function onProgress(param1:ProgressEvent) : void {
         if(this.loadProgressHandler != null)
         {
            this.loadProgressHandler(this,param1);
         }
      }
      
      private function onError(param1:Event) : void {
         this.clearLoader();
         if(this.loadErrorHandler != null)
         {
            this.loadErrorHandler(this,param1);
         }
      }
   }
}
