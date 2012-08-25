package com.ankamagames.berilia.types.data
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import flash.text.*;
    import flash.utils.*;

    public class ExtendedStyleSheet extends StyleSheet
    {
        private var _inherit:Array;
        private var _inherited:uint;
        private var _url:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ExtendedStyleSheet));
        private static const CSS_INHERITANCE_KEYWORD:String = "extends";
        private static const CSS_FILES_KEYWORD:String = "files";

        public function ExtendedStyleSheet(param1:String)
        {
            this._inherit = new Array();
            this._inherited = 0;
            this._url = param1;
            return;
        }// end function

        public function get inherit() : Array
        {
            return this._inherit;
        }// end function

        public function get ready() : Boolean
        {
            return this._inherited == this._inherit.length;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

        override public function parseCSS(param1:String) : void
        {
            var _loc_3:Object = null;
            var _loc_4:RegExp = null;
            var _loc_5:Array = null;
            var _loc_6:String = null;
            var _loc_7:uint = 0;
            super.parseCSS(param1);
            var _loc_2:* = styleNames.indexOf(CSS_INHERITANCE_KEYWORD);
            if (_loc_2 != -1)
            {
                _loc_3 = getStyle(styleNames[_loc_2]);
                if (_loc_3[CSS_FILES_KEYWORD])
                {
                    _loc_4 = /url\(''?([^'']*)''\)?""url\('?([^']*)'\)?/g;
                    _loc_5 = String(_loc_3[CSS_FILES_KEYWORD]).match(_loc_4);
                    _loc_7 = 0;
                    while (_loc_7 < _loc_5.length)
                    {
                        
                        _loc_6 = String(_loc_5[_loc_7]).replace(_loc_4, "$1");
                        if (this._inherit.indexOf(_loc_6) == -1)
                        {
                            _loc_6 = LangManager.getInstance().replaceKey(_loc_6);
                            CssManager.getInstance().askCss(_loc_6, new Callback(this.makeMerge, _loc_6));
                            this._inherit.push(_loc_6);
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                else
                {
                    _log.warn("property \'" + CSS_FILES_KEYWORD + "\' wasn\'t found (flash css doesn\'t support space between property name and colon, propertyName:value)");
                    dispatchEvent(new CssEvent(CssEvent.CSS_PARSED, false, false, this));
                }
            }
            else
            {
                dispatchEvent(new CssEvent(CssEvent.CSS_PARSED, false, false, this));
            }
            return;
        }// end function

        public function merge(param1:ExtendedStyleSheet, param2:Boolean = false) : void
        {
            var _loc_3:Object = null;
            var _loc_4:Object = null;
            var _loc_6:String = null;
            var _loc_5:uint = 0;
            while (_loc_5 < param1.styleNames.length)
            {
                
                if (param1.styleNames[_loc_5] == CSS_INHERITANCE_KEYWORD)
                {
                }
                else
                {
                    _loc_3 = getStyle(param1.styleNames[_loc_5]);
                    _loc_4 = param1.getStyle(param1.styleNames[_loc_5]);
                    if (_loc_3)
                    {
                        for (_loc_6 in _loc_4)
                        {
                            
                            if (_loc_3[_loc_6] == null || param2)
                            {
                                _loc_3[_loc_6] = _loc_4[_loc_6];
                            }
                        }
                        _loc_4 = _loc_3;
                    }
                    setStyle(param1.styleNames[_loc_5], _loc_4);
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        override public function toString() : String
        {
            var _loc_2:Object = null;
            var _loc_4:String = null;
            var _loc_1:String = "";
            _loc_1 = _loc_1 + ("File " + this.url + " :\n");
            var _loc_3:uint = 0;
            while (_loc_3 < styleNames.length)
            {
                
                _loc_2 = getStyle(styleNames[_loc_3]);
                _loc_1 = _loc_1 + (" [" + styleNames[_loc_3] + "]\n");
                for (_loc_4 in _loc_2)
                {
                    
                    _loc_1 = _loc_1 + ("  " + _loc_4 + " : " + _loc_2[_loc_4] + "\n");
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_1;
        }// end function

        private function makeMerge(param1:String) : void
        {
            this.merge(CssManager.getInstance().getCss(param1));
            var _loc_2:String = this;
            var _loc_3:* = this._inherited + 1;
            _loc_2._inherited = _loc_3;
            if (this.ready)
            {
                dispatchEvent(new CssEvent(CssEvent.CSS_PARSED, false, false, this));
            }
            return;
        }// end function

    }
}
