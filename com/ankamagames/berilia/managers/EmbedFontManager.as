package com.ankamagames.berilia.managers
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.files.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class EmbedFontManager extends EventDispatcher
    {
        private var _aFonts:Array;
        private var _currentlyLoading:String;
        private var _loadingFonts:Array;
        private var _loader:IResourceLoader;
        private static var _self:EmbedFontManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EmbedFontManager));

        public function EmbedFontManager()
        {
            if (_self != null)
            {
                throw new SingletonError("EmbedFontManager constructor should not be called directly.");
            }
            _self = this;
            this._aFonts = new Array();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onComplete);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onError);
            this._loader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE, this.onAllFontLoaded);
            return;
        }// end function

        public function initialize(param1:Array) : void
        {
            if (this._loadingFonts == null)
            {
                this._loadingFonts = new Array();
            }
            this._loadingFonts = this._loadingFonts.concat(param1);
            this.loadFonts();
            return;
        }// end function

        public function isEmbed(param1:String) : Boolean
        {
            return this._aFonts[param1] == true;
        }// end function

        public function getFont(param1:String) : Font
        {
            var _loc_2:* = Font.enumerateFonts();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (Font(_loc_2[_loc_3]).fontName.toUpperCase() == param1.toUpperCase())
                {
                    return _loc_2[_loc_3];
                }
                _loc_3 = _loc_3 + 1;
            }
            return null;
        }// end function

        private function loadFonts() : void
        {
            var _loc_2:* = null;
            if (this._currentlyLoading != null)
            {
                return;
            }
            if (this._loadingFonts.length == 0)
            {
                dispatchEvent(new Event(Event.COMPLETE));
                return;
            }
            var _loc_1:* = new Array();
            for each (_loc_2 in this._loadingFonts)
            {
                
                _loc_1.push(new Uri(_loc_2));
            }
            this._loadingFonts = null;
            this._loader.load(_loc_1);
            return;
        }// end function

        private function onComplete(event:ResourceLoadedEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = Swl(event.resource).getDefinition(FileUtils.getFileStartName(event.uri.uri)) as Class;
            this._aFonts[FileUtils.getFileStartName(event.uri.uri)] = true;
            if (_loc_2["EMBED_FONT"])
            {
                Font.registerFont(_loc_2["EMBED_FONT"]);
            }
            else
            {
                _loc_3 = _loc_2["FONTS_LIST"];
                if (_loc_3)
                {
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3.length)
                    {
                        
                        Font.registerFont(_loc_3[_loc_4]);
                        _loc_4++;
                    }
                }
            }
            this._currentlyLoading = null;
            return;
        }// end function

        private function onAllFontLoaded(event:ResourceLoaderProgressEvent) : void
        {
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        private function onError(event:ResourceErrorEvent) : void
        {
            _log.error("Unabled to load a font : " + event.uri);
            return;
        }// end function

        public static function getInstance() : EmbedFontManager
        {
            if (_self == null)
            {
                _self = new EmbedFontManager;
            }
            return _self;
        }// end function

    }
}
