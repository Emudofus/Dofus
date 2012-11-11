package com.ankamagames.berilia.types.template
{
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.jerakine.eval.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;
    import flash.xml.*;

    public class XmlTemplate extends Object
    {
        private var _aTemplateParams:Array;
        private var _sXml:String;
        private var _xDoc:XMLDocument;
        private var _aVariablesStack:Array;
        private var _filename:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(XmlTemplate));

        public function XmlTemplate(param1:String = null, param2:String = null)
        {
            this._aVariablesStack = new Array();
            this._filename = param2;
            if (param1 != null)
            {
                this.xml = param1;
            }
            return;
        }// end function

        public function get xml() : String
        {
            return this._sXml;
        }// end function

        public function set xml(param1:String) : void
        {
            this._sXml = param1;
            this.parseTemplate();
            return;
        }// end function

        public function get filename() : String
        {
            return this._filename;
        }// end function

        public function set filename(param1:String) : void
        {
            this._filename = param1;
            return;
        }// end function

        public function get templateParams() : Array
        {
            return this._aTemplateParams;
        }// end function

        public function get variablesStack() : Array
        {
            return this._aVariablesStack;
        }// end function

        public function makeTemplate(param1:Array) : XMLNode
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_2:* = new Evaluator();
            var _loc_3:* = this._xDoc.toString();
            var _loc_5:* = [];
            for (_loc_4 in this._aTemplateParams)
            {
                
                _loc_5[_loc_4] = this._aTemplateParams[_loc_4];
            }
            for (_loc_4 in param1)
            {
                
                if (!this._aTemplateParams[_loc_4])
                {
                    _log.error("Template " + this._filename + ", param " + _loc_4 + " is not defined");
                    delete param1[_loc_4];
                    continue;
                }
                _loc_5[_loc_4] = param1[_loc_4];
            }
            _loc_3 = this.replaceParam(_loc_3, _loc_5, "#");
            _loc_6 = new Array();
            _loc_8 = 0;
            while (_loc_8 < this._aVariablesStack.length)
            {
                
                _loc_7 = this._aVariablesStack[_loc_8].clone();
                _loc_7.value = _loc_2.eval(this.replaceParam(this.replaceParam(_loc_7.value, _loc_5, "#"), _loc_6, "$"));
                _loc_6[_loc_7.name] = _loc_7;
                _loc_8 = _loc_8 + 1;
            }
            _loc_3 = this.replaceParam(_loc_3, _loc_6, "$");
            var _loc_9:* = new XMLDocument();
            new XMLDocument().parseXML(_loc_3);
            return _loc_9;
        }// end function

        private function parseTemplate() : void
        {
            this._xDoc = new XMLDocument();
            this._aTemplateParams = new Array();
            this._xDoc.ignoreWhite = true;
            this._xDoc.parseXML(this._sXml);
            if (this._xDoc.firstChild.nodeName + ".xml" != this._filename)
            {
                _log.error("Wrong root node name in " + this._filename + ", found " + this._xDoc.firstChild.nodeName + ", waiting for " + this._filename.replace(".xml", ""));
                return;
            }
            this.matchDynamicsParts(this._xDoc.firstChild);
            return;
        }// end function

        private function matchDynamicsParts(param1:XMLNode) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            while (_loc_5 < param1.childNodes.length)
            {
                
                _loc_2 = param1.childNodes[_loc_5];
                if (_loc_2.nodeName == XmlTagsEnum.TAG_VAR)
                {
                    if (_loc_2.attributes[XmlAttributesEnum.ATTRIBUTE_NAME])
                    {
                        _loc_3 = new TemplateVar(_loc_2.attributes[XmlAttributesEnum.ATTRIBUTE_NAME]);
                        _loc_3.value = _loc_2.firstChild.toString().replace(/&apos;""&apos;/g, "\'");
                        this._aVariablesStack.push(_loc_3);
                        _loc_2.removeNode();
                        _loc_5 = _loc_5 - 1;
                        ;
                    }
                    else
                    {
                        _log.warn(_loc_2.nodeName + " must have [" + XmlAttributesEnum.ATTRIBUTE_NAME + "] attribute");
                    }
                }
                if (_loc_2.nodeName == XmlTagsEnum.TAG_PARAM)
                {
                    if (_loc_2.attributes[XmlAttributesEnum.ATTRIBUTE_NAME])
                    {
                        _loc_4 = new TemplateParam(_loc_2.attributes[XmlAttributesEnum.ATTRIBUTE_NAME]);
                        this._aTemplateParams[_loc_4.name] = _loc_4;
                        if (_loc_2.hasChildNodes())
                        {
                            _loc_4.defaultValue = _loc_2.firstChild.toString();
                        }
                        else
                        {
                            _loc_4.defaultValue = "";
                        }
                        _loc_2.removeNode();
                        _loc_5 = _loc_5 - 1;
                    }
                    else
                    {
                        _log.warn(_loc_2.nodeName + " must have [" + XmlAttributesEnum.ATTRIBUTE_NAME + "] attribute");
                    }
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        private function replaceParam(param1:String, param2:Array, param3:String, param4:uint = 1) : String
        {
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            if (!param1)
            {
                return param1;
            }
            var _loc_6:* = new Array();
            for (_loc_7 in param2)
            {
                
                _loc_6.push(_loc_7);
            }
            _loc_6.sort(Array.DESCENDING);
            _loc_8 = 0;
            while (_loc_8 < _loc_6.length)
            {
                
                _loc_7 = _loc_6[_loc_8];
                if (param2[_loc_7] == null)
                {
                }
                else
                {
                    _loc_5 = param2[_loc_7].value;
                    if (!_loc_5 && param2[_loc_7] is TemplateParam)
                    {
                        _loc_5 = param2[_loc_7].defaultValue;
                    }
                    if (_loc_5 == null)
                    {
                        _log.warn("No value for " + param3 + _loc_7);
                    }
                    else
                    {
                        param1 = param1.split(param3 + _loc_7).join(_loc_5);
                    }
                }
                _loc_8 = _loc_8 + 1;
            }
            return param1;
        }// end function

    }
}
