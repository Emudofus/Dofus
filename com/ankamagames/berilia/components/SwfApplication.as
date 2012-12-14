package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class SwfApplication extends GraphicContainer implements UIComponent
    {
        private var _ldr:Loader;
        private var _uri:Uri;
        private var _app:DisplayObject;
        public var loadedHandler:Function;
        public var loadErrorHandler:Function;
        public var loadProgressHandler:Function;

        public function SwfApplication()
        {
            mouseEnabled = true;
            return;
        }// end function

        public function set uri(param1:Uri) : void
        {
            if (!getUi() || !getUi().uiModule.trusted)
            {
                return;
            }
            this._uri = param1;
            this.initLoader();
            this._ldr.load(new URLRequest(param1.normalizedUri));
            return;
        }// end function

        public function get uri() : Uri
        {
            return this._uri;
        }// end function

        override public function set width(param1:Number) : void
        {
            super.width = param1;
            if (this._app)
            {
                this._app.width = param1;
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            super.height = param1;
            if (this._app)
            {
                this._app.height = param1;
            }
            return;
        }// end function

        override public function remove() : void
        {
            this.clearLoader();
            if (this._ldr && this._ldr.contentLoaderInfo)
            {
                this._ldr.contentLoaderInfo.removeEventListener(Event.INIT, this.onInit);
                this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            }
            this._ldr = null;
            this.loadedHandler = null;
            this.loadErrorHandler = null;
            return;
        }// end function

        public function bindApi(param1:String, param2) : Boolean
        {
            var propertyName:* = param1;
            var value:* = param2;
            if (!getUi() || !getUi().uiModule.trusted)
            {
                return false;
            }
            if (!this._app)
            {
                return false;
            }
            try
            {
                this._app[propertyName] = value;
            }
            catch (e:Error)
            {
                return false;
            }
            return true;
        }// end function

        private function initLoader() : void
        {
            if (!this._ldr)
            {
                this._ldr = new Loader();
                this._ldr.contentLoaderInfo.addEventListener(Event.INIT, this.onInit);
                this._ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
                this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            }
            else
            {
                this.clearLoader();
            }
            return;
        }// end function

        private function clearLoader() : void
        {
            if (this._ldr)
            {
                this._ldr.unloadAndStop();
            }
            while (numChildren)
            {
                
                removeChildAt(0);
            }
            return;
        }// end function

        private function onInit(event:Event) : void
        {
            this._app = this._ldr.content;
            this._app.width = width;
            this._app.height = height;
            addChild(this._app);
            if (this.loadedHandler != null)
            {
                this.loadedHandler(this);
            }
            return;
        }// end function

        private function onProgress(event:ProgressEvent) : void
        {
            if (this.loadProgressHandler != null)
            {
                this.loadProgressHandler(this, event);
            }
            return;
        }// end function

        private function onError(event:Event) : void
        {
            this.clearLoader();
            if (this.loadErrorHandler != null)
            {
                this.loadErrorHandler(this, event);
            }
            return;
        }// end function

    }
}
