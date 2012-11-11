package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class UiRootContainer extends GraphicContainer
    {
        private var _aNamedElements:Array;
        private var _bUsedCustomSize:Boolean = false;
        private var _stage:Stage;
        private var _root:Sprite;
        private var _aGraphicLocationStack:Array;
        private var _aSizeStack:Array;
        private var _aGraphicElementIndex:Array;
        private var _aPositionnedElement:Array;
        private var _linkedUi:Array;
        private var _aPostFinalizeElement:Array;
        private var _aFinalizeElements:Array;
        private var _uiDefinitionUpdateTimer:Timer;
        private var _rendering:Boolean = false;
        private var _ready:Boolean;
        private var _waitingFctCall:Array;
        private var _properties:Object;
        private var _wasVisible:Boolean;
        private var _lock:Boolean = true;
        private var _renderAsk:Boolean = false;
        private var _isNotFinalized:Boolean = true;
        private var _tempVisible:Boolean = true;
        private var _uiData:UiData;
        public var uiClass:Object;
        public var uiModule:UiModule;
        public var strata:int;
        public var depth:int;
        public var scalable:Boolean = true;
        public var modal:Boolean = false;
        private var _modalContainer:GraphicContainer;
        public var giveFocus:Boolean = true;
        public var modalIndex:uint = 0;
        public var radioGroup:Array;
        public var cached:Boolean = false;
        public var hideAfterLoading:Boolean = false;
        public var transmitFocus:Boolean = true;
        public var constants:Array;
        public var tempHolder:DisplayObjectContainer;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UiRootContainer));

        public function UiRootContainer(param1:Stage, param2:UiData, param3:Sprite = null)
        {
            this._stage = param1;
            this._root = param3;
            this._aNamedElements = new Array();
            this._aSizeStack = new Array();
            this._linkedUi = new Array();
            this._uiData = param2;
            this._aGraphicLocationStack = new Array();
            this._aGraphicElementIndex = new Array();
            this._aPostFinalizeElement = new Array();
            this._aFinalizeElements = new Array();
            this._waitingFctCall = new Array();
            this.radioGroup = new Array();
            super.visible = false;
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function set properties(param1) : void
        {
            if (!this._properties)
            {
                this._properties = param1;
            }
            return;
        }// end function

        override public function get customUnicName() : String
        {
            return name;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            if (this._isNotFinalized)
            {
                this._tempVisible = param1;
            }
            else
            {
                super.visible = param1;
            }
            return;
        }// end function

        override public function get width() : Number
        {
            if (this._bUsedCustomSize)
            {
                return __width;
            }
            return super.width;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._bUsedCustomSize = true;
            __width = param1;
            return;
        }// end function

        override public function get height() : Number
        {
            if (this._bUsedCustomSize)
            {
                return __height;
            }
            return super.height;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._bUsedCustomSize = true;
            __height = param1;
            return;
        }// end function

        public function set useCustomSize(param1:Boolean) : void
        {
            this._bUsedCustomSize = param1;
            return;
        }// end function

        public function get useCustomSize() : Boolean
        {
            return this._bUsedCustomSize;
        }// end function

        public function set disableRender(param1:Boolean) : void
        {
            this._rendering = param1;
            return;
        }// end function

        public function get disableRender() : Boolean
        {
            return this._rendering;
        }// end function

        public function get ready() : Boolean
        {
            return this._ready;
        }// end function

        public function set modalContainer(param1:GraphicContainer) : void
        {
            this._modalContainer = param1;
            return;
        }// end function

        public function set showModalContainer(param1:Boolean) : void
        {
            if (this.modal && this._modalContainer != null)
            {
                this._modalContainer.visible = param1;
            }
            return;
        }// end function

        public function get uiData() : UiData
        {
            return this._uiData;
        }// end function

        public function addElement(param1:String, param2:Object) : void
        {
            this._aNamedElements[param1] = param2;
            return;
        }// end function

        public function removeElement(param1:String) : void
        {
            delete this._aNamedElements[param1];
            return;
        }// end function

        public function getElement(param1:String) : GraphicContainer
        {
            return this._aNamedElements[param1];
        }// end function

        public function getElements() : Array
        {
            return this._aNamedElements;
        }// end function

        public function getConstant(param1:String)
        {
            return this.constants[param1];
        }// end function

        public function iAmFinalized(param1:FinalizableUIComponent) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (!this._lock || this._rendering)
            {
                return;
            }
            for each (_loc_2 in this._aFinalizeElements)
            {
                
                if (!_loc_2.finalized)
                {
                    return;
                }
            }
            this._lock = false;
            this.render();
            this._ready = true;
            if (this.tempHolder)
            {
                if (!this.hideAfterLoading)
                {
                    this.tempHolder.parent.addChildAt(this, this.tempHolder.parent.getChildIndex(this.tempHolder));
                }
                this.tempHolder.parent.removeChild(this.tempHolder);
                this.tempHolder = null;
            }
            this._isNotFinalized = false;
            var _loc_3:* = false;
            if (this.uiClass && this.uiClass.hasOwnProperty("main"))
            {
                this._rendering = true;
                _loc_4 = getTimer();
                FpsManager.getInstance().startTracking("hook", 7108545);
                ErrorManager.tryFunction(this.uiClass["main"], [this._properties], "Une erreur est survenue lors de l\'exécution de la fonction main de l\'interface " + name + " (" + getQualifiedClassName(this.uiClass) + ")");
                _log.info("Exec main from " + this.uiClass + "::" + this._uiData.module.id + " : " + (getTimer() - _loc_4) + " ms");
                FpsManager.getInstance().stopTracking("hook");
                this._rendering = false;
                if (ErrorManager.lastTryFunctionHasException)
                {
                    _loc_3 = true;
                }
                else if (this._renderAsk)
                {
                    this.render();
                }
                this._ready = true;
                for each (_loc_5 in this._waitingFctCall)
                {
                    
                    _loc_5.exec();
                }
                this._waitingFctCall = null;
            }
            dispatchEvent(new UiRenderEvent(UiRenderEvent.UIRenderComplete, false, false, this));
            this.visible = this._tempVisible;
            if (_loc_3)
            {
                Berilia.getInstance().unloadUi(name);
            }
            return;
        }// end function

        public function render() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._renderAsk = true;
            var _loc_1:* = this._ready;
            this._ready = false;
            if (this._rendering || this._lock)
            {
                return;
            }
            var _loc_2:* = getTimer();
            this._rendering = true;
            this._aPositionnedElement = new Array();
            this.zSort(this._aSizeStack);
            this.processSize();
            _loc_3 = 0;
            while (_loc_3 < this._aGraphicLocationStack.length)
            {
                
                if (this._aGraphicLocationStack[_loc_3] != null)
                {
                    this._aGraphicLocationStack[_loc_3].render = false;
                }
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < this._aGraphicLocationStack.length)
            {
                
                if (this._aGraphicLocationStack[_loc_3] == null)
                {
                }
                else if (!this._aGraphicLocationStack[_loc_3].render)
                {
                    _loc_4 = this._aGraphicLocationStack[_loc_3];
                    if (!_loc_4.sprite.dynamicPosition)
                    {
                        this.processLocation(this._aGraphicLocationStack[_loc_3]);
                    }
                }
                _loc_3++;
            }
            this.updateLinkedUi();
            for each (_loc_5 in this._aPostFinalizeElement)
            {
                
                _loc_5.finalize();
            }
            this._aPositionnedElement = new Array();
            this._rendering = false;
            this._ready = _loc_1;
            return;
        }// end function

        public function registerId(param1:String, param2:GraphicElement) : void
        {
            if (this._aGraphicElementIndex[param1] != null && this._aGraphicElementIndex[param1] != undefined)
            {
                throw new BeriliaError(param1 + " name is already used");
            }
            this._aGraphicElementIndex[param1] = param2;
            this.addElement(param1, param2.sprite);
            return;
        }// end function

        public function deleteId(param1:String) : void
        {
            if (this._aGraphicElementIndex[param1] == null)
            {
                return;
            }
            delete this._aGraphicElementIndex[param1];
            this.removeElement(param1);
            return;
        }// end function

        public function getElementById(param1:String) : GraphicElement
        {
            return this._aGraphicElementIndex[param1];
        }// end function

        public function removeFromRenderList(param1:String) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            _loc_2 = 0;
            while (_loc_2 < this._aGraphicLocationStack.length)
            {
                
                _loc_3 = this._aGraphicLocationStack[_loc_2];
                if (_loc_3 != null && _loc_3.sprite.name == param1)
                {
                    delete this._aGraphicLocationStack[_loc_2];
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_2 = 0;
            while (_loc_2 < this._aSizeStack.length)
            {
                
                if (this._aSizeStack[_loc_2] != null && this._aSizeStack[_loc_2].name == param1)
                {
                    delete this._aSizeStack[_loc_2];
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function addDynamicSizeElement(param1:GraphicElement) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aSizeStack.length)
            {
                
                if (this._aSizeStack[_loc_2] == param1)
                {
                    return;
                }
                _loc_2 = _loc_2 + 1;
            }
            this._aSizeStack.push(param1);
            return;
        }// end function

        public function addDynamicElement(param1:GraphicElement) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aGraphicLocationStack.length)
            {
                
                if (this._aGraphicLocationStack[_loc_2] != null && this._aGraphicLocationStack[_loc_2].sprite.name == param1.sprite.name)
                {
                    return;
                }
                _loc_2 = _loc_2 + 1;
            }
            this._aGraphicLocationStack.push(param1);
            return;
        }// end function

        public function addPostFinalizeComponent(param1:FinalizableUIComponent) : void
        {
            this._aPostFinalizeElement.push(param1);
            return;
        }// end function

        public function addFinalizeElement(param1:FinalizableUIComponent) : void
        {
            this._aFinalizeElements.push(param1);
            return;
        }// end function

        public function addRadioGroup(param1:String) : RadioGroup
        {
            if (!this.radioGroup[param1])
            {
                this.radioGroup[param1] = new RadioGroup(param1);
            }
            return this.radioGroup[param1];
        }// end function

        public function getRadioGroup(param1:String) : RadioGroup
        {
            return this.radioGroup[param1];
        }// end function

        public function addLinkedUi(param1:String) : void
        {
            if (param1 != name)
            {
                this._linkedUi[param1] = param1;
            }
            else
            {
                _log.error("Cannot add link to yourself in " + name);
            }
            return;
        }// end function

        public function removeLinkedUi(param1:String) : void
        {
            delete this._linkedUi[param1];
            return;
        }// end function

        public function updateLinkedUi() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._linkedUi)
            {
                
                if (Berilia.getInstance().getUi(this._linkedUi[_loc_1]))
                {
                    Berilia.getInstance().getUi(this._linkedUi[_loc_1]).render();
                }
            }
            return;
        }// end function

        public function call(param1:Function, param2:Array, param3:Object) : void
        {
            if (param3 !== SecureCenter.ACCESS_KEY)
            {
                throw new IllegalOperationError();
            }
            if (this._ready)
            {
                CallWithParameters.call(param1, param2);
            }
            else
            {
                this._waitingFctCall.push(CallWithParameters.callConstructor(Callback, [param1].concat(param2)));
            }
            return;
        }// end function

        public function destroyUi(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1 !== SecureCenter.ACCESS_KEY)
            {
                throw new IllegalOperationError();
            }
            for each (_loc_2 in this.radioGroup)
            {
                
                RadioGroup(_loc_2).destroy();
            }
            this.radioGroup = null;
            this._stage = null;
            this._root = null;
            this._aNamedElements = new Array();
            this._aSizeStack = new Array();
            this._linkedUi = new Array();
            this._aGraphicLocationStack = new Array();
            this._aGraphicElementIndex = new Array();
            this._aPostFinalizeElement = new Array();
            if (this._aFinalizeElements)
            {
                _loc_3 = this._aFinalizeElements.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = this._aFinalizeElements[_loc_4];
                    _loc_5.remove();
                    _loc_4++;
                }
            }
            this._aFinalizeElements = null;
            return;
        }// end function

        private function isRegisteredId(param1:String) : Boolean
        {
            return this._aGraphicElementIndex[param1] != null;
        }// end function

        private function processSize() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aSizeStack.length)
            {
                
                _loc_1 = this._aSizeStack[_loc_2];
                if (_loc_1 == null)
                {
                }
                else
                {
                    if (!isNaN(_loc_1.size.x) && _loc_1.size.xUnit == GraphicSize.SIZE_PRC)
                    {
                        if (_loc_1.sprite && _loc_1.sprite.parent && _loc_1.sprite.parent.parent is UiRootContainer)
                        {
                            _loc_1.sprite.width = int(_loc_1.size.x * StageShareManager.startWidth);
                        }
                        else if (GraphicContainer(_loc_1.sprite).getParent())
                        {
                            _loc_1.sprite.width = int(_loc_1.size.x * GraphicContainer(_loc_1.sprite).getParent().width);
                        }
                    }
                    if (!isNaN(_loc_1.size.y) && _loc_1.size.yUnit == GraphicSize.SIZE_PRC)
                    {
                        if (_loc_1.sprite && _loc_1.sprite.parent && _loc_1.sprite.parent.parent is UiRootContainer)
                        {
                            _loc_1.sprite.height = int(_loc_1.size.y * StageShareManager.startHeight);
                        }
                        else if (GraphicContainer(_loc_1.sprite).getParent())
                        {
                            _loc_1.sprite.height = int(_loc_1.size.y * GraphicContainer(_loc_1.sprite).getParent().height);
                        }
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function processLocation(param1:GraphicElement) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = param1.sprite.x;
            var _loc_3:* = param1.sprite.y;
            param1.sprite.x = 0;
            param1.sprite.y = 0;
            if (param1.locations.length > 1)
            {
                param1.sprite.width = 0;
                param1.sprite.height = 0;
                _loc_5 = this.getLocation(new Point(param1.sprite.x, param1.sprite.y), param1.locations[0], param1.sprite);
                _loc_6 = this.getLocation(new Point(param1.sprite.x, param1.sprite.y), param1.locations[1], param1.sprite);
                if (_loc_5 && _loc_6)
                {
                    param1.sprite.width = Math.floor(Math.abs(_loc_6.x - _loc_5.x));
                    param1.sprite.height = Math.floor(Math.abs(_loc_6.y - _loc_5.y));
                }
                else
                {
                    _log.error("Erreur de positionement dans " + name + " avec " + param1.name);
                }
            }
            var _loc_4:* = this.getLocation(new Point(param1.sprite.x, param1.sprite.y), param1.location, param1.sprite);
            if (param1.sprite && _loc_4)
            {
                param1.sprite.x = _loc_4.x;
                param1.sprite.y = _loc_4.y;
            }
            else
            {
                param1.sprite.x = _loc_2;
                param1.sprite.y = _loc_3;
                _log.error("Erreur dans " + name + " avec " + param1.name);
            }
            return;
        }// end function

        private function getLocation(param1:Point, param2:GraphicLocation, param3:DisplayObject) : Point
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_4:* = new Point();
            var _loc_5:* = new Point();
            var _loc_6:* = new Point();
            if (param2.offsetXType == LocationTypeEnum.LOCATION_TYPE_RELATIVE || param2.offsetYType == LocationTypeEnum.LOCATION_TYPE_RELATIVE)
            {
                _loc_5 = param3.localToGlobal(new Point(param3.x, param3.y));
                switch(param2.getRelativeTo())
                {
                    case GraphicLocation.REF_PARENT:
                    {
                        _loc_4.x = Math.floor(GraphicContainer(param3).getParent().width * param2.getOffsetX());
                        _loc_4.y = Math.floor(GraphicContainer(param3).getParent().height * param2.getOffsetY());
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (param2.offsetXType == LocationTypeEnum.LOCATION_TYPE_RELATIVE)
                {
                    param1.x = param1.x + _loc_4.x;
                }
                if (param2.offsetYType == LocationTypeEnum.LOCATION_TYPE_RELATIVE)
                {
                    param1.y = param1.y + _loc_4.y;
                }
            }
            if (param2.offsetXType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE || param2.offsetYType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
            {
                _loc_4.x = 0;
                _loc_4.y = 0;
                _loc_5 = param3.localToGlobal(new Point(param3.x, param3.y));
                switch(param2.getRelativeTo())
                {
                    case GraphicLocation.REF_PARENT:
                    {
                        _loc_4.x = param2.getOffsetX();
                        _loc_4.y = param2.getOffsetY();
                        break;
                    }
                    case GraphicLocation.REF_SCREEN:
                    {
                        _loc_6 = param3.localToGlobal(new Point(param3.x, param3.y));
                        _loc_4.x = param2.getOffsetX() - _loc_6.x;
                        _loc_4.y = param2.getOffsetY() - _loc_6.y;
                        break;
                    }
                    case GraphicLocation.REF_TOP:
                    {
                        _loc_6 = new Point(x, y);
                        _loc_4.x = param2.getOffsetX() + (_loc_6.x - _loc_5.x);
                        _loc_4.y = param2.getOffsetY() + (_loc_6.y - _loc_5.y);
                        break;
                    }
                    default:
                    {
                        if (this.isRegisteredId(param2.getRelativeTo()))
                        {
                            _loc_8 = this._aGraphicElementIndex[param2.getRelativeTo()].sprite;
                        }
                        else if (Berilia.getInstance().getUi(param2.getRelativeTo()))
                        {
                            _loc_8 = Berilia.getInstance().getUi(param2.getRelativeTo());
                            UiRootContainer(_loc_8).addLinkedUi(name);
                            param3 = _loc_8;
                        }
                        else if (param2.getRelativeTo().indexOf(".") != -1)
                        {
                            _loc_9 = param2.getRelativeTo().split(".");
                            _loc_10 = Berilia.getInstance().getUi(_loc_9[0]);
                            if (!_loc_10)
                            {
                                _log.warn("[Warning] UI " + _loc_9[0] + " does not exist (found " + param2.getRelativeTo() + " in " + name + ")");
                                return null;
                            }
                            if (!_loc_10.getElementById(_loc_9[1]))
                            {
                                _log.warn("[Warning] UI " + _loc_9[0] + " does not contain element [" + _loc_9[1] + "] (found " + param2.getRelativeTo() + " in " + name + ")");
                                return null;
                            }
                            _loc_8 = _loc_10.getElementById(_loc_9[1]).sprite;
                            _loc_5 = param3.localToGlobal(new Point(param3.x, param3.y));
                            GraphicContainer(_loc_8).getUi().addLinkedUi(name);
                        }
                        else
                        {
                            _log.warn("[Warning] " + param2.getRelativeTo() + " is unknow graphic element reference");
                            return null;
                        }
                        _loc_6 = param3.localToGlobal(new Point(_loc_8.x, _loc_8.y));
                        _loc_4.x = param2.getOffsetX() + (_loc_6.x - _loc_5.x);
                        _loc_4.y = param2.getOffsetY() + (_loc_6.y - _loc_5.y);
                        break;
                        break;
                    }
                }
                if (param2.offsetXType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
                {
                    param1.x = param1.x + _loc_4.x;
                }
                if (param2.offsetYType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
                {
                    param1.y = param1.y + _loc_4.y;
                }
            }
            _loc_4 = this.getOffsetModificator(param2.getPoint(), param3);
            param1.x = param1.x - _loc_4.x;
            param1.y = param1.y - _loc_4.y;
            switch(param2.getRelativeTo())
            {
                case GraphicLocation.REF_PARENT:
                {
                    if (param3.parent && param3.parent.parent)
                    {
                        _loc_7 = param3.parent.parent;
                    }
                    break;
                }
                case GraphicLocation.REF_SCREEN:
                {
                    _loc_7 = this._root;
                    break;
                }
                case GraphicLocation.REF_TOP:
                {
                    _loc_7 = this;
                    break;
                }
                default:
                {
                    _loc_7 = _loc_8;
                    if (_loc_7 == param3)
                    {
                        _log.warn("[Warning] Wrong relative position : " + _loc_7.name + " refer to himself");
                    }
                    break;
                    break;
                }
            }
            _loc_4 = this.getOffsetModificator(param2.getRelativePoint(), _loc_7);
            param1.x = param1.x + _loc_4.x;
            param1.y = param1.y + _loc_4.y;
            return param1;
        }// end function

        private function getOffsetModificator(param1:uint, param2:DisplayObject) : Point
        {
            var _loc_3:* = param2 == null || param2 is UiRootContainer ? (StageShareManager.startWidth) : (param2.width);
            var _loc_4:* = param2 == null || param2 is UiRootContainer ? (StageShareManager.startHeight) : (param2.height);
            var _loc_5:* = new Point(0, 0);
            switch(param1)
            {
                case LocationEnum.POINT_TOPLEFT:
                {
                    break;
                }
                case LocationEnum.POINT_TOP:
                {
                    _loc_5.x = _loc_3 / 2;
                    break;
                }
                case LocationEnum.POINT_TOPRIGHT:
                {
                    _loc_5.x = _loc_3;
                    break;
                }
                case LocationEnum.POINT_LEFT:
                {
                    _loc_5.y = _loc_3 / 2;
                    break;
                }
                case LocationEnum.POINT_CENTER:
                {
                    _loc_5.x = _loc_3 / 2;
                    _loc_5.y = _loc_4 / 2;
                    break;
                }
                case LocationEnum.POINT_RIGHT:
                {
                    _loc_5.x = _loc_3;
                    _loc_5.y = _loc_4 / 2;
                    break;
                }
                case LocationEnum.POINT_BOTTOMLEFT:
                {
                    _loc_5.y = _loc_4;
                    break;
                }
                case LocationEnum.POINT_BOTTOM:
                {
                    _loc_5.x = _loc_3 / 2;
                    _loc_5.y = _loc_4;
                    break;
                }
                case LocationEnum.POINT_BOTTOMRIGHT:
                {
                    _loc_5.x = _loc_3;
                    _loc_5.y = _loc_4;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_5;
        }// end function

        private function zSort(param1:Array) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_4:* = true;
            var _loc_5:* = false;
            while (_loc_4)
            {
                
                _loc_4 = false;
                _loc_6 = 0;
                while (_loc_6 < param1.length)
                {
                    
                    _loc_2 = param1[_loc_6];
                    if (_loc_2 == null)
                    {
                    }
                    else
                    {
                        _loc_7 = 0;
                        while (_loc_7 < _loc_2.locations.length)
                        {
                            
                            _loc_8 = _loc_6 + 1;
                            while (_loc_8 < param1.length)
                            {
                                
                                _loc_3 = _loc_2.locations[_loc_7];
                                if (param1[_loc_8] == null)
                                {
                                }
                                else if (_loc_3.getRelativeTo().charAt(0) != "$" && _loc_3.getRelativeTo() == param1[_loc_8].sprite.name || _loc_3.getRelativeTo() == GraphicLocation.REF_PARENT && param1[_loc_8].sprite == _loc_2.sprite.getParent())
                                {
                                    _loc_5 = true;
                                    _loc_4 = true;
                                    param1[_loc_6] = param1[_loc_8];
                                    param1[_loc_8] = _loc_2;
                                    break;
                                }
                                _loc_8 = _loc_8 + 1;
                            }
                            _loc_7 = _loc_7 + 1;
                        }
                    }
                    _loc_6 = _loc_6 + 1;
                }
            }
            return _loc_5;
        }// end function

        private function onDefinitionUpdateTimer(event:TimerEvent) : void
        {
            UiRenderManager.getInstance().updateCachedUiDefinition();
            this._uiDefinitionUpdateTimer.removeEventListener(TimerEvent.TIMER, this.onDefinitionUpdateTimer);
            this._uiDefinitionUpdateTimer = null;
            return;
        }// end function

    }
}
