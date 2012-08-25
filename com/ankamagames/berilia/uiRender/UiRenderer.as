package com.ankamagames.berilia.uiRender
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.api.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.pools.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.listener.*;
    import com.ankamagames.berilia.types.uiDefinition.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class UiRenderer extends EventDispatcher
    {
        protected var _scUi:UiRootContainer;
        private var _sName:String;
        private var _xpParser:PoolableXmlParsor;
        private var _uiDef:UiDefinition;
        private var _xmlClassDef:XML;
        private var _oProperties:Object;
        protected var _nTimeStamp:uint;
        private var _scriptClass:Class;
        private var _isXmlRender:Boolean;
        private var _aFilnalizedLater:Array;
        public var fromCache:Boolean = false;
        public var parsingTime:uint = 0;
        public var buildTime:uint = 0;
        public var scriptTime:uint = 0;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        public static var MEMORY_LOG_2:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UiRenderer));
        public static var componentsPools:Array = new Array();

        public function UiRenderer()
        {
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function get uiDefinition() : UiDefinition
        {
            return this._uiDef;
        }// end function

        public function set script(param1:Class) : void
        {
            this._scriptClass = param1;
            return;
        }// end function

        public function get script() : Class
        {
            return this._scriptClass;
        }// end function

        public function fileRender(param1:String, param2:String, param3:UiRootContainer, param4 = null) : void
        {
            this._nTimeStamp = getTimer();
            this._oProperties = param4;
            this._sName = param2;
            this._scUi = param3;
            this._isXmlRender = true;
            this._xpParser = PoolsManager.getInstance().getXmlParsorPool().checkOut() as PoolableXmlParsor;
            this._xpParser.rootPath = this._scUi.uiModule.rootPath;
            this._xpParser.addEventListener(Event.COMPLETE, this.onParseComplete);
            this._xpParser.processFile(param1);
            return;
        }// end function

        public function xmlRender(param1:String, param2:String, param3:UiRootContainer, param4 = null) : void
        {
            this._nTimeStamp = getTimer();
            this._oProperties = param4;
            this._sName = param2;
            this._scUi = param3;
            this._isXmlRender = true;
            this._xpParser = PoolsManager.getInstance().getXmlParsorPool().checkOut() as PoolableXmlParsor;
            this._xpParser.rootPath = this._scUi.uiModule.rootPath;
            this._xpParser.addEventListener(Event.COMPLETE, this.onParseComplete);
            this._xpParser.processXml(param1);
            return;
        }// end function

        public function uiRender(param1:UiDefinition, param2:String, param3:UiRootContainer, param4 = null) : void
        {
            MEMORY_LOG_2[param4] = 1;
            if (!this._nTimeStamp)
            {
                this._nTimeStamp = getTimer();
            }
            if (param3.parent)
            {
                param3.tempHolder = new Sprite();
                param3.parent.addChildAt(param3.tempHolder, param3.parent.getChildIndex(param3));
                param3.parent.removeChild(param3);
            }
            if (!param1)
            {
                _log.error("Cannot render " + param2 + " : no UI definition");
                dispatchEvent(new UiRenderEvent(Event.COMPLETE, false, false, this._scUi, this));
                return;
            }
            this._oProperties = param4;
            this._sName = param2;
            this._scUi = param3;
            this._uiDef = param1;
            this._uiDef.name = param2;
            this._aFilnalizedLater = new Array();
            if (this._uiDef.scalable)
            {
                param3.scaleX = Berilia.getInstance().scale;
                param3.scaleY = Berilia.getInstance().scale;
            }
            this._scUi.scalable = this._uiDef.scalable;
            this._scUi.constants = this._uiDef.constants;
            this._scUi.disableRender = true;
            this.makeScript();
            if (this._uiDef.modal)
            {
                this.makeModalContainer();
            }
            param3.giveFocus = this._uiDef.giveFocus;
            param3.transmitFocus = this._uiDef.transmitFocus;
            this.makeChilds(param1.graphicTree, param3);
            this.makeShortcuts();
            this.fillUiScriptVar();
            if (this._scUi.uiClass)
            {
                this._scUi.properties = this._oProperties;
            }
            this._scUi.disableRender = false;
            param3.render();
            if (param3.strata == StrataEnum.STRATA_MEDIUM && param3.giveFocus)
            {
                Berilia.getInstance().giveFocus(param3);
            }
            this.finalizeContainer();
            this.buildTime = getTimer() - this._nTimeStamp;
            this.scriptTime = getTimer();
            this.scriptTime = getTimer() - this.scriptTime;
            param3.iAmFinalized(null);
            if (!this._isXmlRender)
            {
                this.parsingTime = 0;
            }
            dispatchEvent(new UiRenderEvent(Event.COMPLETE, false, false, this._scUi, this));
            this._oProperties = null;
            this._sName = null;
            this._scUi = null;
            this._uiDef = null;
            return;
        }// end function

        private function makeChilds(param1:Array, param2:GraphicContainer) : void
        {
            var ie:InstanceEvent;
            var ge:GraphicElement;
            var gc:GraphicContainer;
            var be:BasicElement;
            var aa:Array;
            var j:int;
            var lastChild:String;
            var i:int;
            var anchorsList:Array;
            var stateContainer:StateContainerElement;
            var gridElem:ContainerElement;
            var container:ContainerElement;
            var component:ComponentElement;
            var num:int;
            var anc:GraphicLocation;
            var aChild:* = param1;
            var gcContainer:* = param2;
            var aChildLength:* = aChild.length;
            i;
            while (i < aChildLength)
            {
                
                try
                {
                    be = aChild[i];
                }
                catch (e:Error)
                {
                    _log.error("Render error in " + _sName + " with " + (gcContainer ? (gcContainer.name) : ("Unknow")) + ", elem " + (aChild[i] ? (aChild[i].name) : ("Unknow")));
                    ;
                }
                if (be is StateContainerElement || be is ButtonElement)
                {
                    if (be is ButtonElement)
                    {
                        stateContainer = ButtonElement(be);
                    }
                    else
                    {
                        stateContainer = StateContainerElement(be);
                    }
                    gc = gcContainer.getStrata(stateContainer.strata).addChild(this.makeContainer(stateContainer)) as StateContainer;
                    StateContainer(gc).changingStateData = stateContainer.stateChangingProperties;
                    this.makeChilds(stateContainer.childs, gc);
                }
                else if (be is GridElement)
                {
                    gridElem = ContainerElement(be);
                    gc = gcContainer.getStrata(gridElem.strata).addChild(this.makeContainer(gridElem)) as GraphicContainer;
                }
                else if (be is ContainerElement)
                {
                    container = ContainerElement(be);
                    gc = gcContainer.getStrata(container.strata).addChild(this.makeContainer(container)) as GraphicContainer;
                    if (container.name == "__modalContainer")
                    {
                        this._scUi.modalContainer = gc;
                    }
                    this.makeChilds(container.childs, gc);
                }
                else if (be is ComponentElement)
                {
                    component = ComponentElement(be);
                    gc = gcContainer.getStrata(component.strata).addChild(this.makeComponent(component)) as GraphicContainer;
                }
                aa;
                anchorsList = be.anchors;
                if (anchorsList)
                {
                    aa = new Array();
                    num = anchorsList.length;
                    j;
                    while (j < num)
                    {
                        
                        aa.push(LocationELement(anchorsList[j]).toGraphicLocation());
                        j = (j + 1);
                    }
                }
                ge = new GraphicElement(gc, aa, be.name);
                if (!be.name)
                {
                    be.name = "elem_" + Math.floor(Math.random() * 10000000);
                }
                ge.name = be.name;
                this._scUi.registerId(be.name, ge);
                if (be.anchors)
                {
                    var _loc_4:int = 0;
                    var _loc_5:* = ge.locations;
                    while (_loc_5 in _loc_4)
                    {
                        
                        anc = _loc_5[_loc_4];
                        if (anc.getRelativeTo() == GraphicLocation.REF_LAST)
                        {
                            if (lastChild)
                            {
                                anc.setRelativeTo(lastChild);
                                continue;
                            }
                            anc.setRelativeTo(GraphicLocation.REF_PARENT);
                            anc.setRelativePoint("TOPLEFT");
                        }
                    }
                    this._scUi.addDynamicElement(ge);
                }
                else
                {
                    gc.x = 0;
                    gc.y = 0;
                }
                lastChild = be.name;
                if (be.size)
                {
                    if (be.size.xUnit == GraphicSize.SIZE_PRC && !isNaN(be.size.x) || be.size.yUnit == GraphicSize.SIZE_PRC && !isNaN(be.size.y))
                    {
                        ge.size = be.size.toGraphicSize();
                        this._scUi.addDynamicSizeElement(ge);
                    }
                    if (be.size.xUnit == GraphicSize.SIZE_PIXEL && !isNaN(be.size.x))
                    {
                        gc.width = be.size.x;
                    }
                    if (be.size.yUnit == GraphicSize.SIZE_PIXEL && !isNaN(be.size.y))
                    {
                        gc.height = be.size.y;
                    }
                }
                if (be.minSize)
                {
                    gc.minSize = be.minSize.toGraphicSize();
                }
                if (be.maxSize)
                {
                    gc.maxSize = be.maxSize.toGraphicSize();
                }
                if (be.event.length)
                {
                    SecureCenter.secure(gc, this._scUi.uiModule.trusted);
                    ie = new InstanceEvent(gc, this._scUi.uiClass);
                    j;
                    while (j < be.event.length)
                    {
                        
                        ie.events[be.event[j]] = be.event[j];
                        j = (j + 1);
                    }
                    UIEventManager.getInstance().registerInstance(ie);
                }
                if (be.properties["bgColor"] != null)
                {
                    gc.bgColor = be.properties["bgColor"];
                }
                else if (this._uiDef.debug)
                {
                    gc.bgColor = Math.round(Math.random() * 16777215);
                }
                if (gc is Grid || gc is ComboBox)
                {
                    this.makeChilds(Object(gc).renderModificator(Object(be).childs, SecureCenter.ACCESS_KEY), gc);
                }
                if (gc is FinalizableUIComponent)
                {
                    this._scUi.addFinalizeElement(gc as FinalizableUIComponent);
                    if (be.size && (be.size.xUnit == GraphicSize.SIZE_PRC || be.size.yUnit == GraphicSize.SIZE_PRC) || be.anchors && be.anchors.length == 2)
                    {
                        this._aFilnalizedLater.push(gc);
                    }
                    else
                    {
                        var _loc_4:* = gc;
                        _loc_4.gc["finalize"]();
                    }
                }
                i = (i + 1);
            }
            return;
        }// end function

        private function makeContainer(param1:ContainerElement) : Sprite
        {
            var _loc_2:GraphicContainer = null;
            var _loc_3:String = null;
            switch(true)
            {
                case param1 is ButtonElement:
                {
                    _loc_2 = new ButtonContainer();
                    break;
                }
                case param1 is StateContainerElement:
                {
                    _loc_2 = new StateContainer();
                    break;
                }
                case param1 is ScrollContainerElement:
                {
                    _loc_2 = new ScrollContainer();
                    this._scUi.addPostFinalizeComponent(_loc_2 as FinalizableUIComponent);
                    break;
                }
                case param1 is GridElement:
                {
                    _loc_2 = new (getDefinitionByName(param1.className) as Class)();
                    break;
                }
                case param1 is ContainerElement:
                {
                    _loc_2 = new GraphicContainer();
                    break;
                }
                default:
                {
                    break;
                }
            }
            for (_loc_3 in param1.properties)
            {
                
                _loc_2[_loc_3] = param1.properties[_loc_3];
            }
            return _loc_2 as Sprite;
        }// end function

        private function makeComponent(param1:ComponentElement) : Sprite
        {
            var _loc_3:UIComponent = null;
            var _loc_4:String = null;
            var _loc_2:* = getDefinitionByName(param1.className) as Class;
            _loc_3 = new _loc_2 as UIComponent;
            for (_loc_4 in param1.properties)
            {
                
                _loc_3[_loc_4] = param1.properties[_loc_4];
            }
            return _loc_3 as Sprite;
        }// end function

        private function makeScript() : void
        {
            if (this._scriptClass)
            {
                this._scUi.uiClass = new this._scriptClass;
                ApiBinder.addApiData("currentUi", this._scUi);
                ApiBinder.initApi(this._scUi.uiClass, this._scUi.uiModule, UiModuleManager.getInstance().sharedDefinition);
                this._xmlClassDef = DescribeTypeCache.typeDescription(this._scUi.uiClass);
            }
            else
            {
                _log.warn("[Warning] " + this._scriptClass + " wasn\'t found for " + this._scUi.name);
            }
            return;
        }// end function

        private function fillUiScriptVar() : void
        {
            var sVariable:String;
            var xmlVar:XMLList;
            var variable:XML;
            var i:String;
            var st:String;
            if (!this._xmlClassDef)
            {
                return;
            }
            this._xmlClassDef = DescribeTypeCache.typeDescription(this._scUi.uiClass);
            var variables:* = new Array();
            var _loc_2:int = 0;
            var _loc_3:* = this._xmlClassDef..variable;
            while (_loc_3 in _loc_2)
            {
                
                variable = _loc_3[_loc_2];
                variables[variable.@name.toString()] = true;
            }
            var _loc_2:int = 0;
            var _loc_3:* = this._scUi.getElements();
            do
            {
                
                i = _loc_3[_loc_2];
                sVariable = this._scUi.getElements()[i].name;
                if (variables[sVariable])
                {
                    try
                    {
                        this._scUi.uiClass[sVariable] = SecureCenter.secure(this._scUi.getElements()[i], this._scUi.uiModule.trusted);
                    }
                    catch (e:Error)
                    {
                        if (e.getStackTrace())
                        {
                            st = e.getStackTrace();
                        }
                        else
                        {
                            st;
                        }
                        _log.error(sVariable + "in " + _scUi.name + " cannot be set (wrong type) " + st);
                    }
                }
            }while (_loc_3 in _loc_2)
            return;
        }// end function

        private function makeShortcuts() : void
        {
            var _loc_1:String = null;
            var _loc_2:GenericListener = null;
            return;
            return;
        }// end function

        private function finalizeContainer() : void
        {
            var _loc_1:uint = 0;
            while (_loc_1 < this._aFilnalizedLater.length)
            {
                
                this._aFilnalizedLater[_loc_1].finalize();
                _loc_1 = _loc_1 + 1;
            }
            this._aFilnalizedLater = new Array();
            return;
        }// end function

        private function makeModalContainer() : void
        {
            var fct:Function;
            var listener:GenericListener;
            if (this._scUi.uiClass != null)
            {
                if (this._scUi.uiClass.hasOwnProperty("onShortcut"))
                {
                    fct = this._scUi.uiClass["onShortcut"];
                }
                else
                {
                    fct = function (... args) : Boolean
            {
                return true;
            }// end function
            ;
                }
                listener = new GenericListener("ALL", this._scUi.name, fct, this._scUi.depth, GenericListener.LISTENER_TYPE_UI, new WeakReference(this._scUi));
                BindsManager.getInstance().registerEvent(listener);
            }
            this._scUi.modal = true;
            if (this._uiDef.graphicTree && this._uiDef.graphicTree[0].name == "__modalContainer")
            {
                return;
            }
            var modalContainer:* = new ContainerElement();
            var size:* = new GraphicSize();
            size.setX(1, GraphicSize.SIZE_PRC);
            size.setY(1, GraphicSize.SIZE_PRC);
            modalContainer.name = "__modalContainer";
            modalContainer.size = size.toSizeElement();
            modalContainer.properties["alpha"] = 0.3;
            modalContainer.properties["bgColor"] = 0;
            modalContainer.properties["mouseEnabled"] = true;
            modalContainer.strata = StrataEnum.STRATA_LOW;
            this._uiDef.graphicTree.unshift(modalContainer);
            return;
        }// end function

        private function onParseComplete(event:ParsorEvent) : void
        {
            this.parsingTime = getTimer() - this._nTimeStamp;
            this._nTimeStamp = this.parsingTime + this._nTimeStamp;
            this._xpParser.removeEventListener(Event.COMPLETE, this.onParseComplete);
            PoolsManager.getInstance().getXmlParsorPool().checkIn(this._xpParser);
            this.uiRender(event.uiDefinition, this._sName, this._scUi, this._oProperties);
            this._isXmlRender = false;
            return;
        }// end function

    }
}
