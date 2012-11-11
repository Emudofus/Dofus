package com.ankamagames.berilia.uiRender
{
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.template.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.xml.*;

    public class XmlPreProcessor extends EventDispatcher
    {
        private var _xDoc:XMLDocument;
        private var _bMustBeRendered:Boolean = true;
        private var _aImportFile:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(XmlPreProcessor));

        public function XmlPreProcessor(param1:XMLDocument)
        {
            this._xDoc = param1;
            return;
        }// end function

        public function get importedFiles() : int
        {
            return this._aImportFile.length;
        }// end function

        public function processTemplate() : void
        {
            this._aImportFile = new Array();
            TemplateManager.getInstance().addEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED, this.onTemplateLoaded);
            this.matchImport(this._xDoc.firstChild);
            if (!this._aImportFile.length)
            {
                dispatchEvent(new PreProcessEndEvent(this));
                TemplateManager.getInstance().removeEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED, this.onTemplateLoaded);
                return;
            }
            var _loc_1:* = 0;
            while (_loc_1 < this._aImportFile.length)
            {
                
                TemplateManager.getInstance().register(this._aImportFile[_loc_1]);
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function matchImport(param1:XMLNode) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < param1.childNodes.length)
            {
                
                _loc_2 = param1.childNodes[_loc_3];
                if (_loc_2.nodeName == XmlTagsEnum.TAG_IMPORT)
                {
                    if (_loc_2.attributes[XmlAttributesEnum.ATTRIBUTE_URL] == null)
                    {
                        _log.warn("Attribute \'" + XmlAttributesEnum.ATTRIBUTE_URL + "\' is missing in " + XmlTagsEnum.TAG_IMPORT + " tag.");
                    }
                    else
                    {
                        this._aImportFile.push(LangManager.getInstance().replaceKey(_loc_2.attributes[XmlAttributesEnum.ATTRIBUTE_URL]));
                    }
                    _loc_2.removeNode();
                    _loc_3 = _loc_3 - 1;
                }
                else if (_loc_2 != null)
                {
                    this.matchImport(_loc_2);
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function replaceTemplateCall(param1:XMLNode) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_14:* = false;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_6:* = false;
            var _loc_13:* = 0;
            while (_loc_13 < param1.childNodes.length)
            {
                
                _loc_2 = param1.childNodes[_loc_13];
                _loc_14 = false;
                _loc_7 = 0;
                while (_loc_7 < this._aImportFile.length)
                {
                    
                    _loc_10 = this._aImportFile[_loc_7].split("/");
                    _loc_11 = this._aImportFile[_loc_7].split("/")[(_loc_10.length - 1)];
                    if (_loc_11.toUpperCase() == (_loc_2.nodeName + ".xml").toUpperCase())
                    {
                        _loc_12 = new Array();
                        for (_loc_8 in _loc_2.attributes)
                        {
                            
                            _loc_12[_loc_8] = new TemplateParam(_loc_8, _loc_2.attributes[_loc_8]);
                        }
                        _loc_9 = 0;
                        while (_loc_9 < _loc_2.childNodes.length)
                        {
                            
                            _loc_3 = _loc_2.childNodes[_loc_9];
                            _loc_15 = "";
                            for each (_loc_16 in _loc_3.childNodes)
                            {
                                
                                _loc_15 = _loc_15 + _loc_16;
                            }
                            _loc_12[_loc_3.nodeName] = new TemplateParam(_loc_3.nodeName, _loc_15);
                            _loc_9 = _loc_9 + 1;
                        }
                        _loc_4 = TemplateManager.getInstance().getTemplate(_loc_11).makeTemplate(_loc_12);
                        _loc_9 = 0;
                        while (_loc_9 < _loc_4.firstChild.childNodes.length)
                        {
                            
                            _loc_5 = _loc_4.firstChild.childNodes[_loc_9].cloneNode(true);
                            _loc_2.parentNode.insertBefore(_loc_5, _loc_2);
                            _loc_9 = _loc_9 + 1;
                        }
                        _loc_2.removeNode();
                        var _loc_17:* = true;
                        _loc_14 = true;
                        _loc_6 = _loc_17;
                    }
                    _loc_7 = _loc_7 + 1;
                }
                if (!_loc_14)
                {
                    _loc_6 = this.replaceTemplateCall(_loc_2) || _loc_6;
                }
                _loc_13 = _loc_13 + 1;
            }
            return _loc_6;
        }// end function

        private function onTemplateLoaded(event:TemplateLoadedEvent) : void
        {
            if (TemplateManager.getInstance().areLoaded(this._aImportFile) && this._bMustBeRendered)
            {
                this._bMustBeRendered = this.replaceTemplateCall(this._xDoc.firstChild);
                if (this._bMustBeRendered)
                {
                    this.processTemplate();
                }
                else
                {
                    dispatchEvent(new PreProcessEndEvent(this));
                    TemplateManager.getInstance().removeEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED, this.onTemplateLoaded);
                }
            }
            return;
        }// end function

    }
}
