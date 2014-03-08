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
      
      public function set uri(v:Uri) : void {
         if((!getUi()) || (!getUi().uiModule.trusted))
         {
            return;
         }
         this._uri = v;
         this.initLoader();
         this._ldr.load(new URLRequest(v.normalizedUri));
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      public var loadedHandler:Function;
      
      public var loadErrorHandler:Function;
      
      public var loadProgressHandler:Function;
      
      override public function set width(nW:Number) : void {
         super.width = nW;
         if(this._app)
         {
            this._app.width = nW;
         }
      }
      
      override public function set height(nH:Number) : void {
         super.height = nH;
         if(this._app)
         {
            this._app.height = nH;
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
      
      public function bindApi(propertyName:String, value:*) : Boolean {
         if((!getUi()) || (!getUi().uiModule.trusted))
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
      
      private function onInit(e:Event) : void {
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
      
      private function onMouseMouse(e:MouseEvent) : void {
         stage.dispatchEvent(e);
      }
      
      private function onProgress(e:ProgressEvent) : void {
         if(this.loadProgressHandler != null)
         {
            this.loadProgressHandler(this,e);
         }
      }
      
      private function onError(e:Event) : void {
         this.clearLoader();
         if(this.loadErrorHandler != null)
         {
            this.loadErrorHandler(this,e);
         }
      }
   }
}
