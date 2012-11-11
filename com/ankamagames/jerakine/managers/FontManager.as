package com.ankamagames.jerakine.managers
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.files.*;
    import flash.utils.*;

    public class FontManager extends Object
    {
        private var _log:Logger;
        private var _handler:MessageHandler;
        private var _loader:IResourceLoader;
        private var _data:XML;
        private var _lang:String;
        private var _fonts:Dictionary;
        private static var _self:FontManager;
        public static var initialized:Boolean = false;

        public function FontManager()
        {
            this._log = Log.getLogger(getQualifiedClassName(FontManager));
            if (_self != null)
            {
                throw new SingletonError("FontManager is a singleton and should not be instanciated directly.");
            }
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onFileLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            return;
        }// end function

        public function set handler(param1:MessageHandler) : void
        {
            this._handler = param1;
            return;
        }// end function

        public function loadFile(param1:String) : void
        {
            var _loc_2:* = FileUtils.getExtension(param1);
            this._lang = LangManager.getInstance().getEntry("config.lang.current");
            if (_loc_2 == null)
            {
                throw new FileTypeError(param1 + " have no type (no extension found).");
            }
            var _loc_3:* = new Uri(param1);
            _loc_3.tag = param1;
            this._loader.load(_loc_3);
            return;
        }// end function

        public function getRealFontName(param1:String) : String
        {
            if (this._fonts[param1])
            {
                return this._fonts[param1].realname;
            }
            return "";
        }// end function

        public function getFontsList() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = new Array();
            for each (_loc_2 in this._fonts)
            {
                
                _loc_1.push(_loc_2.url);
            }
            return _loc_1;
        }// end function

        public function getSizeMultipicator(param1:String) : Number
        {
            if (this._fonts[param1])
            {
                return Number(this._fonts[param1].sizemultiplicator);
            }
            return 1;
        }// end function

        public function getFontClassName(param1:String) : String
        {
            return this._fonts[param1].classname;
        }// end function

        private function onFileLoaded(event:ResourceLoadedEvent) : void
        {
            var xml:XMLList;
            var length:int;
            var i:int;
            var name:String;
            var o:Object;
            var e:* = event;
            this._data = new XML(e.resource);
            this._fonts = new Dictionary();
            var _loc_4:* = 0;
            var _loc_5:* = this._data.Fonts;
            var _loc_3:* = new XMLList("");
            for each (_loc_6 in _loc_5)
            {
                
                var _loc_7:* = _loc_5[_loc_4];
                with (_loc_5[_loc_4])
                {
                    if (@lang == _lang)
                    {
                        _loc_3[_loc_4] = _loc_6;
                    }
                }
            }
            xml = _loc_3;
            if (xml.length() == 0)
            {
                var _loc_4:* = 0;
                var _loc_5:* = this._data.Fonts;
                var _loc_3:* = new XMLList("");
                for each (_loc_6 in _loc_5)
                {
                    
                    var _loc_7:* = _loc_5[_loc_4];
                    with (_loc_5[_loc_4])
                    {
                        if (@lang == "")
                        {
                            _loc_3[_loc_4] = _loc_6;
                        }
                    }
                }
                xml = _loc_3;
            }
            length = xml.font.length();
            i;
            while (i < length)
            {
                
                name = xml.font[i].@name;
                o;
                this._fonts[name] = o;
                i = (i + 1);
            }
            this._handler.process(new LangFileLoadedMessage(e.uri.uri, true, e.uri.uri));
            this._handler.process(new LangAllFilesLoadedMessage(e.uri.uri, true));
            initialized = true;
            return;
        }// end function

        private function onLoadError(event:ResourceErrorEvent) : void
        {
            this._handler.process(new LangFileLoadedMessage(event.uri.uri, false, event.uri.uri));
            this._log.warn("can\'t load " + event.uri.uri);
            return;
        }// end function

        public static function getInstance() : FontManager
        {
            if (_self == null)
            {
                _self = new FontManager;
            }
            return _self;
        }// end function

    }
}
