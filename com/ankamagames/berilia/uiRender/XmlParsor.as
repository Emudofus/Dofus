package com.ankamagames.berilia.uiRender
{
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.uiDefinition.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import flash.xml.*;

    public class XmlParsor extends EventDispatcher
    {
        protected const _componentList:ComponentList = null;
        protected const _GridItemList:GridItemList = null;
        protected const _log:Logger;
        private var _xmlDoc:XMLDocument;
        private var _sUrl:String;
        protected var _aName:Array;
        private var _loader:IResourceLoader;
        private var _describeType:Function;
        public var rootPath:String;
        private static var _classDescCache:Object = new Object();

        public function XmlParsor()
        {
            this._log = Log.getLogger(getQualifiedClassName(XmlParsor));
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._describeType = DescribeTypeCache.typeDescription;
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onXmlLoadComplete);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onXmlLoadError);
            return;
        }// end function

        public function get url() : String
        {
            return this._sUrl;
        }// end function

        public function get xmlDocString() : String
        {
            return this._xmlDoc ? (this._xmlDoc.toString()) : (null);
        }// end function

        public function processFile(param1:String) : void
        {
            this._sUrl = param1;
            this._loader.load(new Uri(this._sUrl));
            return;
        }// end function

        public function processXml(param1:String) : void
        {
            var errorLog:String;
            var i:uint;
            var regOpenTagAdv:RegExp;
            var regOpenTag:RegExp;
            var tmp:Array;
            var openTag:Array;
            var tag:String;
            var regCloseTag:RegExp;
            var closeTag:Array;
            var sXml:* = param1;
            this._xmlDoc = new XMLDocument();
            this._xmlDoc.ignoreWhite = true;
            try
            {
                this._xmlDoc.parseXML(sXml.toString());
            }
            catch (e:Error)
            {
                if (sXml)
                {
                    regOpenTagAdv = /<\w+[^>]*""<\w+[^>]*/g;
                    regOpenTag = /<\w+""<\w+/g;
                    tmp = sXml.match(regOpenTagAdv);
                    openTag = new Array();
                    i;
                    while (i < tmp.length)
                    {
                        
                        if (tmp[i].substr((tmp[i].length - 1)) == "/")
                        {
                        }
                        else
                        {
                            tag = tmp[i].match(regOpenTag)[0];
                            if (!openTag[tag])
                            {
                                openTag[tag] = 0;
                            }
                            var _loc_4:* = openTag;
                            var _loc_5:* = tag;
                            var _loc_6:* = openTag[tag] + 1;
                            _loc_4[_loc_5] = _loc_6;
                        }
                        i = (i + 1);
                    }
                    regCloseTag = /<\/\w+""<\/\w+/g;
                    tmp = sXml.match(regCloseTag);
                    closeTag = new Array();
                    i;
                    while (i < tmp.length)
                    {
                        
                        tag = "<" + tmp[i].substr(2);
                        if (!closeTag[tag])
                        {
                            closeTag[tag] = 0;
                        }
                        var _loc_4:* = closeTag;
                        var _loc_5:* = tag;
                        var _loc_6:* = closeTag[tag] + 1;
                        _loc_4[_loc_5] = _loc_6;
                        i = (i + 1);
                    }
                }
                errorLog;
                var _loc_4:* = 0;
                var _loc_5:* = openTag;
                while (_loc_5 in _loc_4)
                {
                    
                    tag = _loc_5[_loc_4];
                    if (!closeTag[tag] || closeTag[tag] != openTag[tag])
                    {
                        errorLog = errorLog + ("\n - " + tag + " have no closing tag");
                    }
                }
                var _loc_4:* = 0;
                var _loc_5:* = closeTag;
                while (_loc_5 in _loc_4)
                {
                    
                    tag = _loc_5[_loc_4];
                    if (!openTag[tag] || openTag[tag] != closeTag[tag])
                    {
                        errorLog = errorLog + ("\n - </" + tag.substr(1) + "> is lonely closing tag");
                    }
                }
                _log.error("Error when parsing " + _sUrl + ", misformatted xml" + (errorLog.length ? (" : " + errorLog) : ("")));
                dispatchEvent(new ParsorEvent(Event.COMPLETE, false, false, null));
            }
            this._aName = new Array();
            this.preProccessXml();
            return;
        }// end function

        private function preProccessXml() : void
        {
            var _loc_1:* = new XmlPreProcessor(this._xmlDoc);
            _loc_1.addEventListener(PreProcessEndEvent.PRE_PROCESS_END, this.onPreProcessCompleted);
            _loc_1.processTemplate();
            return;
        }// end function

        private function mainProcess() : void
        {
            dispatchEvent(new ParsorEvent(Event.COMPLETE, false, false, this.parseMainNode(this._xmlDoc.firstChild)));
            return;
        }// end function

        protected function parseMainNode(param1:XMLNode) : UiDefinition
        {
            var _loc_12:* = null;
            var _loc_14:* = 0;
            var _loc_2:* = new UiDefinition();
            var _loc_3:* = param1.childNodes;
            if (!_loc_3.length)
            {
                return null;
            }
            var _loc_4:* = param1.attributes;
            var _loc_5:* = param1.attributes[XmlAttributesEnum.ATTRIBUTE_DEBUG];
            var _loc_6:* = _loc_4[XmlAttributesEnum.ATTRIBUTE_USECACHE];
            var _loc_7:* = _loc_4[XmlAttributesEnum.ATTRIBUTE_USEPROPERTIESCACHE];
            var _loc_8:* = _loc_4[XmlAttributesEnum.ATTRIBUTE_MODAL];
            var _loc_9:* = _loc_4[XmlAttributesEnum.ATTRIBUTE_SCALABLE];
            var _loc_10:* = _loc_4[XmlAttributesEnum.ATTRIBUTE_FOCUS];
            var _loc_11:* = _loc_4[XmlAttributesEnum.ATTRIBUTE_TRANSMITFOCUS];
            if (_loc_5)
            {
                _loc_2.debug = _loc_5 == "true";
            }
            if (_loc_6)
            {
                _loc_2.useCache = _loc_6 == "true";
            }
            if (_loc_7)
            {
                _loc_2.usePropertiesCache = _loc_7 == "true";
            }
            if (_loc_8)
            {
                _loc_2.modal = _loc_8 == "true";
            }
            if (_loc_9)
            {
                _loc_2.scalable = _loc_9 == "true";
            }
            if (_loc_10)
            {
                _loc_2.giveFocus = _loc_10 == "true";
            }
            if (_loc_11)
            {
                _loc_2.transmitFocus = _loc_11 == "true";
            }
            var _loc_13:* = _loc_3.length;
            _loc_14 = 0;
            while (_loc_14 < _loc_13)
            {
                
                _loc_12 = _loc_3[_loc_14];
                switch(_loc_12.nodeName)
                {
                    case XmlTagsEnum.TAG_CONSTANTS:
                    {
                        this.parseConstants(_loc_12, _loc_2.constants);
                        break;
                    }
                    case XmlTagsEnum.TAG_CONTAINER:
                    case XmlTagsEnum.TAG_SCROLLCONTAINER:
                    case XmlTagsEnum.TAG_STATECONTAINER:
                    case XmlTagsEnum.TAG_BUTTON:
                    {
                        _loc_2.graphicTree.push(this.parseGraphicElement(_loc_12));
                        break;
                    }
                    case XmlTagsEnum.TAG_SHORTCUTS:
                    {
                        _loc_2.shortcutsEvents = this.parseShortcutsEvent(_loc_12);
                        break;
                    }
                    default:
                    {
                        this._log.warn("[" + this._sUrl + "] " + _loc_12.nodeName + " is not allow or unknow. " + this.suggest(_loc_12.nodeName, [XmlTagsEnum.TAG_CONTAINER, XmlTagsEnum.TAG_STATECONTAINER, XmlTagsEnum.TAG_BUTTON, XmlTagsEnum.TAG_SHORTCUTS]));
                        break;
                        break;
                    }
                }
                _loc_14 = _loc_14 + 1;
            }
            this.cleanLocalConstants(_loc_2.constants);
            return _loc_2;
        }// end function

        private function cleanLocalConstants(param1:Array) : void
        {
            var _loc_2:* = null;
            for (_loc_2 in param1)
            {
                
                LangManager.getInstance().deleteEntry("local." + _loc_2);
            }
            return;
        }// end function

        protected function parseConstants(param1:XMLNode, param2:Array) : void
        {
            var _loc_3:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_4:* = param1.childNodes;
            var _loc_5:* = param1.childNodes.length;
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_3 = _loc_4[_loc_6];
                _loc_8 = _loc_3.nodeName;
                if (_loc_8 != XmlTagsEnum.TAG_CONSTANT)
                {
                    this._log.error(_loc_8 + " found, wrong node name, waiting for " + XmlTagsEnum.TAG_CONSTANT + " in " + this._sUrl);
                }
                else
                {
                    _loc_9 = _loc_3.attributes["name"];
                    if (!_loc_9)
                    {
                        this._log.error("Constant name\'s not found in " + this._sUrl);
                    }
                    else
                    {
                        _loc_7 = LangManager.getInstance().replaceKey(_loc_3.attributes["value"]);
                        _loc_10 = _loc_3.attributes["type"];
                        if (_loc_10)
                        {
                            _loc_10 = _loc_10.toUpperCase();
                            if (_loc_10 == "STRING")
                            {
                                param2[_loc_9] = _loc_7;
                            }
                            else if (_loc_10 == "NUMBER")
                            {
                                param2[_loc_9] = Number(_loc_7);
                            }
                            else if (_loc_10 == "UINT" || _loc_10 == "INT")
                            {
                                param2[_loc_9] = int(_loc_7);
                            }
                            else if (_loc_10 == "BOOLEAN")
                            {
                                param2[_loc_9] = _loc_7 == "true";
                            }
                            else if (_loc_10 == "ARRAY")
                            {
                                param2[_loc_9] = _loc_7.split(",");
                            }
                        }
                        else
                        {
                            param2[_loc_9] = _loc_7;
                        }
                        LangManager.getInstance().setEntry("local." + _loc_9, _loc_7);
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            return;
        }// end function

        protected function parseGraphicElement(param1:XMLNode, param2:XMLNode = null, param3:BasicElement = null) : BasicElement
        {
            var _loc_4:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_5:* = param1.childNodes;
            var _loc_6:* = param1.childNodes.length;
            if (!param2)
            {
                param2 = param1;
            }
            if (!param3)
            {
                switch(param2.nodeName)
                {
                    case XmlTagsEnum.TAG_CONTAINER:
                    {
                        param3 = new ContainerElement();
                        param3.className = getQualifiedClassName(GraphicContainer);
                        break;
                    }
                    case XmlTagsEnum.TAG_SCROLLCONTAINER:
                    {
                        param3 = new ScrollContainerElement();
                        param3.className = getQualifiedClassName(ScrollContainer);
                        break;
                    }
                    case XmlTagsEnum.TAG_GRID:
                    {
                        param3 = new GridElement();
                        param3.className = getQualifiedClassName(Grid);
                        break;
                    }
                    case XmlTagsEnum.TAG_COMBOBOX:
                    {
                        param3 = new GridElement();
                        param3.className = getQualifiedClassName(ComboBox);
                        break;
                    }
                    case XmlTagsEnum.TAG_TREE:
                    {
                        param3 = new GridElement();
                        param3.className = getQualifiedClassName(Tree);
                        break;
                    }
                    case XmlTagsEnum.TAG_STATECONTAINER:
                    {
                        param3 = new StateContainerElement();
                        param3.className = getQualifiedClassName(StateContainer);
                        break;
                    }
                    case XmlTagsEnum.TAG_BUTTON:
                    {
                        param3 = new ButtonElement();
                        param3.className = getQualifiedClassName(ButtonContainer);
                        break;
                    }
                    default:
                    {
                        param3 = new ComponentElement();
                        ComponentElement(param3).className = "com.ankamagames.berilia.components." + param2.nodeName;
                        break;
                        break;
                    }
                }
            }
            for (_loc_8 in param2.attributes)
            {
                
                switch(_loc_8)
                {
                    case XmlAttributesEnum.ATTRIBUTE_NAME:
                    {
                        param3.setName(param2.attributes[_loc_8]);
                        this._aName[param2.attributes[_loc_8]] = param3;
                        break;
                    }
                    case XmlAttributesEnum.ATTRIBUTE_VISIBLE:
                    {
                        param3.properties["visible"] = Boolean(param2.attributes[_loc_8]);
                        break;
                    }
                    case XmlAttributesEnum.ATTRIBUTE_STRATA:
                    {
                        param3.strata = this.getStrataNum(param2.attributes[_loc_8]);
                        break;
                    }
                    default:
                    {
                        this._log.warn("[" + this._sUrl + "] Unknow attribute \'" + _loc_8 + "\' in " + XmlTagsEnum.TAG_CONTAINER + " tag");
                        break;
                        break;
                    }
                }
            }
            _loc_7 = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_4 = _loc_5[_loc_7];
                switch(_loc_4.nodeName)
                {
                    case XmlTagsEnum.TAG_ANCHORS:
                    {
                        param3.anchors = this.parseAnchors(_loc_4);
                        break;
                    }
                    case XmlTagsEnum.TAG_SIZE:
                    {
                        param3.size = this.parseSize(_loc_4, true).toSizeElement();
                        break;
                    }
                    case XmlTagsEnum.TAG_EVENTS:
                    {
                        param3.event = this.parseEvent(_loc_4);
                        break;
                    }
                    case XmlTagsEnum.TAG_MINIMALSIZE:
                    {
                        param3.minSize = this.parseSize(_loc_4, false).toSizeElement();
                        break;
                    }
                    case XmlTagsEnum.TAG_MAXIMALSIZE:
                    {
                        param3.maxSize = this.parseSize(_loc_4, false).toSizeElement();
                        break;
                    }
                    case XmlTagsEnum.TAG_SCROLLCONTAINER:
                    case XmlTagsEnum.TAG_CONTAINER:
                    case XmlTagsEnum.TAG_GRID:
                    case XmlTagsEnum.TAG_COMBOBOX:
                    case XmlTagsEnum.TAG_TREE:
                    {
                        switch(param2.nodeName)
                        {
                            case XmlTagsEnum.TAG_CONTAINER:
                            case XmlTagsEnum.TAG_BUTTON:
                            case XmlTagsEnum.TAG_STATECONTAINER:
                            case XmlTagsEnum.TAG_SCROLLCONTAINER:
                            case XmlTagsEnum.TAG_COMBOBOX:
                            case XmlTagsEnum.TAG_TREE:
                            case XmlTagsEnum.TAG_GRID:
                            {
                                ContainerElement(param3).childs.push(this.parseGraphicElement(_loc_4));
                                break;
                            }
                            default:
                            {
                                this._log.warn("[" + this._sUrl + "] " + param2.nodeName + " cannot contains " + _loc_4.nodeName);
                                break;
                            }
                        }
                        break;
                    }
                    case XmlTagsEnum.TAG_STATECONTAINER:
                    case XmlTagsEnum.TAG_BUTTON:
                    {
                        switch(param2.nodeName)
                        {
                            case XmlTagsEnum.TAG_CONTAINER:
                            case XmlTagsEnum.TAG_STATECONTAINER:
                            case XmlTagsEnum.TAG_SCROLLCONTAINER:
                            case XmlTagsEnum.TAG_GRID:
                            case XmlTagsEnum.TAG_COMBOBOX:
                            case XmlTagsEnum.TAG_TREE:
                            {
                                ContainerElement(param3).childs.push(this.parseStateContainer(_loc_4, _loc_4.nodeName));
                                break;
                            }
                            default:
                            {
                                this._log.warn("[" + this._sUrl + "] " + param2.nodeName + " cannot contains Button");
                                break;
                            }
                        }
                        break;
                    }
                    default:
                    {
                        switch(param2.nodeName)
                        {
                            case XmlTagsEnum.TAG_CONTAINER:
                            {
                                _loc_9 = GraphicContainer;
                                break;
                            }
                            case XmlTagsEnum.TAG_BUTTON:
                            {
                                _loc_9 = ButtonContainer;
                                break;
                            }
                            case XmlTagsEnum.TAG_STATECONTAINER:
                            {
                                _loc_9 = StateContainer;
                                break;
                            }
                            case XmlTagsEnum.TAG_SCROLLCONTAINER:
                            {
                                _loc_9 = ScrollContainer;
                                break;
                            }
                            case XmlTagsEnum.TAG_GRID:
                            {
                                _loc_9 = Grid;
                                break;
                            }
                            case XmlTagsEnum.TAG_COMBOBOX:
                            {
                                _loc_9 = ComboBox;
                                break;
                            }
                            case XmlTagsEnum.TAG_TREE:
                            {
                                _loc_9 = Tree;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        _loc_11 = this.getClassDesc(_loc_9);
                        if (_loc_11[_loc_4.nodeName])
                        {
                            if (_loc_4.firstChild)
                            {
                                _loc_12 = _loc_4.toString();
                                _loc_13 = _loc_12.substr(_loc_4.nodeName.length + 2, _loc_12.length - _loc_4.nodeName.length * 2 - 5);
                                _loc_10 = LangManager.getInstance().replaceKey(_loc_13);
                                switch(_loc_11[_loc_4.nodeName])
                                {
                                    case "Boolean":
                                    {
                                        _loc_10 = _loc_10 != "false";
                                        break;
                                    }
                                    default:
                                    {
                                        if (_loc_10.charAt(0) == "[" && _loc_10.charAt((_loc_10.length - 1)) == "]")
                                        {
                                            break;
                                        }
                                        _loc_14 = getDefinitionByName(_loc_11[_loc_4.nodeName]) as Class;
                                        _loc_10 = new _loc_14(_loc_10);
                                        break;
                                    }
                                }
                                ContainerElement(param3).properties[_loc_4.nodeName] = _loc_10;
                            }
                        }
                        else
                        {
                            switch(param2.nodeName)
                            {
                                case XmlTagsEnum.TAG_CONTAINER:
                                case XmlTagsEnum.TAG_BUTTON:
                                case XmlTagsEnum.TAG_STATECONTAINER:
                                case XmlTagsEnum.TAG_SCROLLCONTAINER:
                                case XmlTagsEnum.TAG_GRID:
                                case XmlTagsEnum.TAG_COMBOBOX:
                                case XmlTagsEnum.TAG_TREE:
                                {
                                    if (ApplicationDomain.currentDomain.hasDefinition("com.ankamagames.berilia.components." + _loc_4.nodeName))
                                    {
                                        ContainerElement(param3).childs.push(this.parseGraphicElement(_loc_4));
                                    }
                                    else
                                    {
                                        this._log.warn("[" + this._sUrl + "] " + _loc_4.nodeName + " is unknown component / property on " + param2.nodeName);
                                    }
                                    break;
                                }
                                default:
                                {
                                    if (_loc_4.firstChild != null)
                                    {
                                        _loc_15 = _loc_4.toString();
                                        param3.properties[_loc_4.nodeName] = _loc_15.substr(_loc_4.nodeName.length + 2, _loc_15.length - _loc_4.nodeName.length * 2 - 5);
                                    }
                                    break;
                                    break;
                                }
                            }
                        }
                        break;
                        break;
                    }
                }
                _loc_7 = _loc_7 + 1;
            }
            if (param3 is ComponentElement)
            {
                this.cleanComponentProperty(ComponentElement(param3));
            }
            return param3;
        }// end function

        protected function parseStateContainer(param1:XMLNode, param2:String)
        {
            var _loc_3:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_4:* = param1.childNodes;
            var _loc_5:* = param1.childNodes.length;
            if (param2 == XmlTagsEnum.TAG_BUTTON)
            {
                _loc_7 = new ButtonElement();
            }
            if (param2 == XmlTagsEnum.TAG_STATECONTAINER)
            {
                _loc_7 = new StateContainerElement();
            }
            _loc_7.className = getQualifiedClassName(ButtonContainer);
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_3 = _loc_4[_loc_6];
                switch(_loc_3.nodeName)
                {
                    case XmlTagsEnum.TAG_COMMON:
                    {
                        this.parseGraphicElement(_loc_3, param1, _loc_7);
                        break;
                    }
                    case XmlTagsEnum.TAG_STATE:
                    {
                        _loc_9 = _loc_3.attributes[XmlAttributesEnum.ATTRIBUTE_TYPE];
                        if (_loc_9)
                        {
                            if (param2 == XmlTagsEnum.TAG_STATECONTAINER)
                            {
                                _loc_8 = _loc_9;
                            }
                            else
                            {
                                _loc_8 = 9999;
                                switch(_loc_9)
                                {
                                    case StatesEnum.STATE_CLICKED_STRING:
                                    {
                                        _loc_8 = StatesEnum.STATE_CLICKED;
                                        break;
                                    }
                                    case StatesEnum.STATE_OVER_STRING:
                                    {
                                        _loc_8 = StatesEnum.STATE_OVER;
                                        break;
                                    }
                                    case StatesEnum.STATE_DISABLED_STRING:
                                    {
                                        _loc_8 = StatesEnum.STATE_DISABLED;
                                        break;
                                    }
                                    case StatesEnum.STATE_SELECTED_STRING:
                                    {
                                        _loc_8 = StatesEnum.STATE_SELECTED;
                                        break;
                                    }
                                    case StatesEnum.STATE_SELECTED_OVER_STRING:
                                    {
                                        _loc_8 = StatesEnum.STATE_SELECTED_OVER;
                                        break;
                                    }
                                    case StatesEnum.STATE_SELECTED_CLICKED_STRING:
                                    {
                                        _loc_8 = StatesEnum.STATE_SELECTED_CLICKED;
                                        break;
                                    }
                                    default:
                                    {
                                        _loc_10 = new Array(StatesEnum.STATE_CLICKED_STRING, StatesEnum.STATE_OVER_STRING, StatesEnum.STATE_SELECTED_STRING, StatesEnum.STATE_SELECTED_OVER_STRING, StatesEnum.STATE_SELECTED_CLICKED_STRING, StatesEnum.STATE_DISABLED_STRING);
                                        this._log.warn(_loc_9 + " is not a valid state" + this.suggest(_loc_9, _loc_10));
                                        break;
                                        break;
                                    }
                                }
                            }
                            if (_loc_8 != 9999)
                            {
                                if (!_loc_7.stateChangingProperties[_loc_8])
                                {
                                    _loc_7.stateChangingProperties[_loc_8] = new Array();
                                }
                                this.parseSetProperties(_loc_3, _loc_7.stateChangingProperties[_loc_8]);
                            }
                        }
                        else
                        {
                            this._log.warn(XmlTagsEnum.TAG_STATE + " must have attribute [" + XmlAttributesEnum.ATTRIBUTE_TYPE + "]");
                        }
                        break;
                    }
                    default:
                    {
                        this._log.warn(param2 + " does not allow " + _loc_3.nodeName + this.suggest(_loc_3.nodeName, [XmlTagsEnum.TAG_COMMON, XmlTagsEnum.TAG_STATE]));
                        break;
                        break;
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            return _loc_7;
        }// end function

        protected function parseSetProperties(param1:XMLNode, param2:Object) : void
        {
            var _loc_3:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_4:* = param1.childNodes;
            var _loc_5:* = param1.childNodes.length;
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_3 = _loc_4[_loc_6];
                if (_loc_3.nodeName == XmlTagsEnum.TAG_SETPROPERTY)
                {
                    _loc_7 = _loc_3.attributes[XmlAttributesEnum.ATTRIBUTE_TARGET];
                    if (_loc_7)
                    {
                        if (this._aName[_loc_7])
                        {
                            if (!param2[_loc_7])
                            {
                                param2[_loc_7] = new Array();
                            }
                            _loc_8 = param2[_loc_7];
                            _loc_10 = _loc_3.childNodes;
                            _loc_11 = _loc_10.length;
                            _loc_12 = 0;
                            while (_loc_12 < _loc_11)
                            {
                                
                                _loc_9 = _loc_10[_loc_12];
                                _loc_8[_loc_9.nodeName] = LangManager.getInstance().replaceKey(_loc_9.firstChild.toString());
                                _loc_12 = _loc_12 + 1;
                            }
                            this.cleanComponentProperty(this._aName[_loc_7], _loc_8);
                        }
                        else
                        {
                            this._log.warn("Unknow reference to \"" + _loc_7 + "\" in " + XmlTagsEnum.TAG_SETPROPERTY);
                        }
                    }
                    else
                    {
                        this._log.warn("Cannot set button properties, not yet implemented");
                    }
                }
                else
                {
                    this._log.warn("Only " + XmlTagsEnum.TAG_SETPROPERTY + " tags are authorized in " + XmlTagsEnum.TAG_STATE + " tags (found " + _loc_3.nodeName + ")");
                }
                _loc_6 = _loc_6 + 1;
            }
            return;
        }// end function

        private function cleanComponentProperty(param1:BasicElement, param2:Array = null) : Boolean
        {
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (!param2)
            {
                param2 = param1.properties;
            }
            var _loc_3:* = getDefinitionByName(param1.className) as Class;
            var _loc_4:* = this.getClassDesc(_loc_3);
            var _loc_5:* = new Array();
            for (_loc_8 in param2)
            {
                
                if (_loc_4[_loc_8])
                {
                    _loc_6 = LangManager.getInstance().replaceKey(param2[_loc_8]);
                    switch(_loc_4[_loc_8])
                    {
                        case "Boolean":
                        {
                            _loc_6 = _loc_6 != "false";
                            break;
                        }
                        case getQualifiedClassName(Uri):
                        {
                            _loc_7 = getDefinitionByName(_loc_4[_loc_8]) as Class;
                            _loc_6 = new _loc_7(_loc_6);
                            break;
                        }
                        case "*":
                        {
                            break;
                        }
                        default:
                        {
                            if (_loc_6.charAt(0) == "[" && _loc_6.charAt((_loc_6.length - 1)) == "]")
                            {
                                break;
                            }
                            _loc_7 = getDefinitionByName(_loc_4[_loc_8]) as Class;
                            _loc_6 = new _loc_7(_loc_6);
                            break;
                        }
                    }
                    _loc_5[_loc_8] = _loc_6;
                    continue;
                }
                _loc_10 = new Array();
                for (_loc_11 in _loc_4)
                {
                    
                    _loc_10.push(_loc_11);
                }
                this._log.warn("[" + this._sUrl + "]" + _loc_8 + " is unknow for " + param1.className + " component" + this.suggest(_loc_8, _loc_10));
            }
            for (_loc_9 in _loc_5)
            {
                
                param2[_loc_9] = _loc_5[_loc_9];
            }
            return true;
        }// end function

        protected function getClassDesc(param1:Object) : Object
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = getQualifiedClassName(param1);
            if (_classDescCache[_loc_2])
            {
                return _classDescCache[_loc_2];
            }
            var _loc_3:* = this._describeType(param1);
            var _loc_4:* = new Object();
            for each (_loc_5 in _loc_3..accessor)
            {
                
                _loc_4[_loc_5.@name.toString()] = _loc_5.@type.toString();
            }
            for each (_loc_6 in _loc_3..variable)
            {
                
                _loc_4[_loc_6.@name.toString()] = _loc_6.@type.toString();
            }
            return _loc_4;
        }// end function

        protected function parseSize(param1:XMLNode, param2:Boolean) : GraphicSize
        {
            var _loc_3:* = null;
            var _loc_6:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (param1.attributes.length)
            {
                this._log.warn("[" + this._sUrl + "]" + param1.nodeName + " cannot have attribut");
            }
            var _loc_4:* = param1.childNodes;
            var _loc_5:* = param1.childNodes.length;
            var _loc_7:* = new GraphicSize();
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_3 = _loc_4[_loc_6];
                if (_loc_3.nodeName == XmlTagsEnum.TAG_RELDIMENSION)
                {
                    if (!param2)
                    {
                        this._log.warn("[" + this._sUrl + "]" + param1.nodeName + " does not allow relative size");
                    }
                    else
                    {
                        _loc_8 = _loc_3.attributes["x"];
                        if (_loc_8)
                        {
                            _loc_7.setX(Number(LangManager.getInstance().replaceKey(_loc_8)), GraphicSize.SIZE_PRC);
                        }
                        _loc_9 = _loc_3.attributes["y"];
                        if (_loc_9)
                        {
                            _loc_7.setY(Number(LangManager.getInstance().replaceKey(_loc_9)), GraphicSize.SIZE_PRC);
                        }
                    }
                }
                if (_loc_3.nodeName == XmlTagsEnum.TAG_ABSDIMENSION)
                {
                    _loc_8 = _loc_3.attributes["x"];
                    if (_loc_8)
                    {
                        _loc_7.setX(int(LangManager.getInstance().replaceKey(_loc_8)), GraphicSize.SIZE_PIXEL);
                    }
                    _loc_9 = _loc_3.attributes["y"];
                    if (_loc_9)
                    {
                        _loc_7.setY(int(LangManager.getInstance().replaceKey(_loc_9)), GraphicSize.SIZE_PIXEL);
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            return _loc_7;
        }// end function

        protected function parseAnchors(param1:XMLNode) : Array
        {
            var _loc_2:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            if (param1.attributes.length)
            {
                this._log.warn("[" + this._sUrl + "]" + param1.nodeName + " cannot have attribut");
            }
            var _loc_3:* = param1.childNodes;
            var _loc_4:* = _loc_3.length;
            var _loc_8:* = new Array();
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_9 = new GraphicLocation();
                _loc_2 = _loc_3[_loc_5];
                if (_loc_2.nodeName == XmlTagsEnum.TAG_ANCHOR)
                {
                    for (_loc_10 in _loc_2.attributes)
                    {
                        
                        switch(_loc_10)
                        {
                            case XmlAttributesEnum.ATTRIBUTE_POINT:
                            {
                                if (_loc_8.length != 0)
                                {
                                    this._log.error("[" + this._sUrl + "] When using double anchors, you cannot define attribute POINT");
                                }
                                else
                                {
                                    _loc_9.setPoint(_loc_2.attributes[_loc_10]);
                                }
                                break;
                            }
                            case XmlAttributesEnum.ATTRIBUTE_RELATIVEPOINT:
                            {
                                _loc_9.setRelativePoint(_loc_2.attributes[_loc_10]);
                                break;
                            }
                            case XmlAttributesEnum.ATTRIBUTE_RELATIVETO:
                            {
                                _loc_9.setRelativeTo(_loc_2.attributes[_loc_10]);
                                break;
                            }
                            default:
                            {
                                this._log.warn("[" + this._sUrl + "]" + param1.nodeName + " cannot have " + _loc_10 + " attribut");
                                break;
                            }
                        }
                    }
                    _loc_11 = _loc_2.childNodes;
                    _loc_12 = _loc_11.length;
                    _loc_6 = 0;
                    while (_loc_6 < _loc_12)
                    {
                        
                        _loc_7 = _loc_11[_loc_6];
                        switch(_loc_7.nodeName)
                        {
                            case XmlTagsEnum.TAG_OFFSET:
                            {
                                _loc_7 = _loc_7.firstChild;
                                break;
                            }
                            case XmlTagsEnum.TAG_RELDIMENSION:
                            {
                                if (_loc_7.attributes["x"] != null)
                                {
                                    _loc_9.offsetXType = LocationTypeEnum.LOCATION_TYPE_RELATIVE;
                                    _loc_9.setOffsetX(_loc_7.attributes["x"]);
                                }
                                if (_loc_7.attributes["y"] != null)
                                {
                                    _loc_9.offsetYType = LocationTypeEnum.LOCATION_TYPE_RELATIVE;
                                    _loc_9.setOffsetY(_loc_7.attributes["y"]);
                                }
                                break;
                            }
                            case XmlTagsEnum.TAG_ABSDIMENSION:
                            {
                                if (_loc_7.attributes["x"] != null)
                                {
                                    _loc_9.offsetXType = LocationTypeEnum.LOCATION_TYPE_ABSOLUTE;
                                    _loc_9.setOffsetX(_loc_7.attributes["x"]);
                                }
                                if (_loc_7.attributes["y"] != null)
                                {
                                    _loc_9.offsetYType = LocationTypeEnum.LOCATION_TYPE_ABSOLUTE;
                                    _loc_9.setOffsetY(_loc_7.attributes["y"]);
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                    _loc_8.push(_loc_9.toLocationElement());
                }
                else
                {
                    this._log.warn("[" + this._sUrl + "] " + param1.nodeName + " does not allow " + _loc_2.nodeName + " tag");
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_8.length ? (_loc_8) : (null);
        }// end function

        protected function parseShortcutsEvent(param1:XMLNode) : Array
        {
            var _loc_2:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_3:* = param1.childNodes;
            var _loc_4:* = _loc_3.length;
            var _loc_7:* = new Array();
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_2 = _loc_3[_loc_5];
                _loc_6 = _loc_2.nodeName;
                if (!BindsManager.getInstance().isRegisteredName(_loc_6))
                {
                    this._log.info("[" + this._sUrl + "] Shortcut " + _loc_6 + " is not defined.");
                }
                _loc_7.push(_loc_6);
                _loc_5 = _loc_5 + 1;
            }
            return _loc_7;
        }// end function

        private function parseEvent(param1:XMLNode) : Array
        {
            var _loc_2:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_8:* = null;
            var _loc_3:* = param1.childNodes;
            var _loc_4:* = _loc_3.length;
            var _loc_7:* = new Array();
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_2 = _loc_3[_loc_5];
                _loc_6 = "";
                switch(_loc_2.nodeName)
                {
                    case EventEnums.EVENT_ONPRESS:
                    {
                        _loc_6 = EventEnums.EVENT_ONPRESS_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONRELEASE:
                    {
                        _loc_6 = EventEnums.EVENT_ONRELEASE_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONROLLOUT:
                    {
                        _loc_6 = EventEnums.EVENT_ONROLLOUT_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONROLLOVER:
                    {
                        _loc_6 = EventEnums.EVENT_ONROLLOVER_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONRELEASEOUTSIDE:
                    {
                        _loc_6 = EventEnums.EVENT_ONRELEASEOUTSIDE_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONRIGHTCLICK:
                    {
                        _loc_6 = EventEnums.EVENT_ONRIGHTCLICK_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONDOUBLECLICK:
                    {
                        _loc_6 = EventEnums.EVENT_ONDOUBLECLICK_MSG;
                        break;
                    }
                    case EventEnums.EVENT_MIDDLECLICK:
                    {
                        _loc_6 = EventEnums.EVENT_MIDDLECLICK_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONCOLORCHANGE:
                    {
                        _loc_6 = EventEnums.EVENT_ONCOLORCHANGE_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONENTITYREADY:
                    {
                        _loc_6 = EventEnums.EVENT_ONENTITYREADY_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONSELECTITEM:
                    {
                        _loc_6 = EventEnums.EVENT_ONSELECTITEM_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONSELECTEMPTYITEM:
                    {
                        _loc_6 = EventEnums.EVENT_ONSELECTEMPTYITEM_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONDROP:
                    {
                        _loc_6 = EventEnums.EVENT_ONDROP_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONCREATETAB:
                    {
                        _loc_6 = EventEnums.EVENT_ONCREATETAB_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONDELETETAB:
                    {
                        _loc_6 = EventEnums.EVENT_ONDELETETAB_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONRENAMETAB:
                    {
                        _loc_6 = EventEnums.EVENT_ONRENAMETAB_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONITEMROLLOVER:
                    {
                        _loc_6 = EventEnums.EVENT_ONITEMROLLOVER_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONITEMROLLOUT:
                    {
                        _loc_6 = EventEnums.EVENT_ONITEMROLLOUT_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONITEMRIGHTCLICK:
                    {
                        _loc_6 = EventEnums.EVENT_ONITEMRIGHTCLICK_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONWHEEL:
                    {
                        _loc_6 = EventEnums.EVENT_ONWHEEL_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONMOUSEUP:
                    {
                        _loc_6 = EventEnums.EVENT_ONMOUSEUP_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONMAPELEMENTROLLOUT:
                    {
                        _loc_6 = EventEnums.EVENT_ONMAPELEMENTROLLOUT_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONMAPELEMENTROLLOVER:
                    {
                        _loc_6 = EventEnums.EVENT_ONMAPELEMENTROLLOVER_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK:
                    {
                        _loc_6 = EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONMAPMOVE:
                    {
                        _loc_6 = EventEnums.EVENT_ONMAPMOVE_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONMAPROLLOVER:
                    {
                        _loc_6 = EventEnums.EVENT_ONMAPROLLOVER_MSG;
                        break;
                    }
                    case EventEnums.EVENT_ONCOMPONENTREADY:
                    {
                        _loc_6 = EventEnums.EVENT_ONCOMPONENTREADY_MSG;
                        break;
                    }
                    default:
                    {
                        _loc_8 = [EventEnums.EVENT_ONPRESS, EventEnums.EVENT_ONRELEASE, EventEnums.EVENT_ONROLLOUT, EventEnums.EVENT_ONROLLOVER, EventEnums.EVENT_ONRIGHTCLICK, EventEnums.EVENT_ONRELEASEOUTSIDE, EventEnums.EVENT_ONDOUBLECLICK, EventEnums.EVENT_ONCOLORCHANGE, EventEnums.EVENT_ONENTITYREADY, EventEnums.EVENT_ONSELECTITEM, EventEnums.EVENT_ONSELECTEMPTYITEM, EventEnums.EVENT_ONITEMROLLOVER, EventEnums.EVENT_ONITEMROLLOUT, EventEnums.EVENT_ONDROP, EventEnums.EVENT_ONWHEEL, EventEnums.EVENT_ONMOUSEUP, EventEnums.EVENT_ONCREATETAB, EventEnums.EVENT_ONDELETETAB, EventEnums.EVENT_MIDDLECLICK];
                        this._log.warn("[" + this._sUrl + "] " + _loc_2.nodeName + " is an unknow event name" + this.suggest(_loc_2.nodeName, _loc_8));
                        break;
                    }
                }
                if (!_loc_6.length)
                {
                }
                else
                {
                    _loc_7.push(_loc_6);
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_7;
        }// end function

        private function getStrataNum(param1:String) : uint
        {
            var _loc_2:* = null;
            if (param1 == StrataEnum.STRATA_NAME_LOW)
            {
                return StrataEnum.STRATA_LOW;
            }
            if (param1 == StrataEnum.STRATA_NAME_MEDIUM)
            {
                return StrataEnum.STRATA_MEDIUM;
            }
            if (param1 == StrataEnum.STRATA_NAME_HIGH)
            {
                return StrataEnum.STRATA_HIGH;
            }
            if (param1 == StrataEnum.STRATA_NAME_TOP)
            {
                return StrataEnum.STRATA_TOP;
            }
            if (param1 == StrataEnum.STRATA_NAME_TOOLTIP)
            {
                return StrataEnum.STRATA_TOOLTIP;
            }
            _loc_2 = [StrataEnum.STRATA_NAME_LOW, StrataEnum.STRATA_NAME_MEDIUM, StrataEnum.STRATA_NAME_HIGH, StrataEnum.STRATA_NAME_TOP, StrataEnum.STRATA_NAME_TOOLTIP];
            this._log.warn("[" + this._sUrl + "] " + param1 + " is an unknow strata name" + this.suggest(param1, _loc_2));
            return StrataEnum.STRATA_MEDIUM;
        }// end function

        private function suggest(param1:String, param2:Array, param3:uint = 5, param4:uint = 3) : String
        {
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_5:* = "";
            var _loc_6:* = new Array();
            _loc_8 = 0;
            while (_loc_8 < param2.length)
            {
                
                _loc_7 = Levenshtein.distance(param1.toUpperCase(), param2[_loc_8].toUpperCase());
                if (_loc_7 <= param3)
                {
                    _loc_6.push({dist:_loc_7, word:param2[_loc_8]});
                }
                _loc_8++;
            }
            if (_loc_6.length)
            {
                _loc_5 = " (did you mean ";
                _loc_6.sortOn("dist", Array.NUMERIC);
                _loc_8 = 0;
                while (_loc_8 < (_loc_6.length - 1) && _loc_8 < (param4 - 1))
                {
                    
                    _loc_5 = _loc_5 + ("\"" + _loc_6[_loc_8].word + "\"" + (_loc_8 < (_loc_6.length - 1) ? (", ") : ("")));
                    _loc_8++;
                }
                if (_loc_6[_loc_8])
                {
                    _loc_5 = _loc_5 + ((_loc_8 ? ("or ") : ("")) + "\"" + _loc_6[_loc_8].word);
                }
                _loc_5 = _loc_5 + "\" ?)";
            }
            return _loc_5;
        }// end function

        private function onPreProcessCompleted(event:Event) : void
        {
            this.mainProcess();
            return;
        }// end function

        private function onXmlLoadComplete(event:ResourceLoadedEvent) : void
        {
            this.processXml(event.resource);
            return;
        }// end function

        private function onXmlLoadError(event:ResourceErrorEvent) : void
        {
            dispatchEvent(new ParsingErrorEvent(event.uri.toString(), event.errorMsg));
            return;
        }// end function

    }
}
