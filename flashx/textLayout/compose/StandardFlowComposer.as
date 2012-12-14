package flashx.textLayout.compose
{
    import flash.display.*;
    import flash.system.*;
    import flashx.textLayout.accessibility.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;

    public class StandardFlowComposer extends FlowComposerBase implements IFlowComposer
    {
        var _rootElement:ContainerFormattedElement;
        private var _controllerList:Array;
        private var _composing:Boolean;
        private var lastBPDirectionScrollPosition:Number = -1.#INF;

        public function StandardFlowComposer()
        {
            this._controllerList = new Array();
            this._composing = false;
            return;
        }// end function

        public function get composing() : Boolean
        {
            return this._composing;
        }// end function

        public function getAbsoluteStart(param1:ContainerController) : int
        {
            var _loc_2:* = this.getControllerIndex(param1);
            var _loc_3:* = this._rootElement.getAbsoluteStart();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = _loc_3 + this._controllerList[_loc_4].textLength;
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function get rootElement() : ContainerFormattedElement
        {
            return this._rootElement;
        }// end function

        public function setRootElement(param1:ContainerFormattedElement) : void
        {
            if (this._rootElement != param1)
            {
                if (param1 is TextFlow && (param1 as TextFlow).flowComposer != this)
                {
                    (param1 as TextFlow).flowComposer = this;
                }
                else
                {
                    this.clearCompositionResults();
                    this.detachAllContainers();
                    this._rootElement = param1;
                    _textFlow = this._rootElement ? (this._rootElement.getTextFlow()) : (null);
                    this.attachAllContainers();
                }
            }
            return;
        }// end function

        function detachAllContainers() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._controllerList.length > 0 && _textFlow)
            {
                _loc_2 = this.getControllerAt(0);
                _loc_3 = _loc_2.container;
                if (_loc_3)
                {
                    clearContainerAccessibilityImplementation(_loc_3);
                }
            }
            for each (_loc_1 in this._controllerList)
            {
                
                _loc_1.clearSelectionShapes();
                _loc_1.setRootElement(null);
            }
            return;
        }// end function

        function attachAllContainers() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            for each (_loc_1 in this._controllerList)
            {
                
                ContainerController(_loc_1).setRootElement(this._rootElement);
            }
            if (this._controllerList.length > 0 && _textFlow)
            {
                if (textFlow.configuration.enableAccessibility && Capabilities.hasAccessibility)
                {
                    _loc_4 = this.getControllerAt(0).container;
                    if (_loc_4)
                    {
                        clearContainerAccessibilityImplementation(_loc_4);
                        _loc_4.accessibilityImplementation = new TextAccImpl(_loc_4, _textFlow);
                    }
                }
                _loc_3 = 0;
                while (_loc_3 < this._controllerList.length)
                {
                    
                    _loc_2 = this.getControllerAt(_loc_3).container;
                    if (_loc_2)
                    {
                        _loc_2.focusRect = false;
                    }
                    _loc_3++;
                }
            }
            this.clearCompositionResults();
            return;
        }// end function

        public function get numControllers() : int
        {
            return this._controllerList ? (this._controllerList.length) : (0);
        }// end function

        public function addController(param1:ContainerController) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            this._controllerList.push(ContainerController(param1));
            if (this.numControllers == 1)
            {
                this.attachAllContainers();
            }
            else
            {
                param1.setRootElement(this._rootElement);
                _loc_2 = param1.container;
                if (_loc_2)
                {
                    _loc_2.focusRect = false;
                }
                if (textFlow)
                {
                    param1 = this.getControllerAt(this.numControllers - 2);
                    _loc_3 = param1.absoluteStart;
                    _loc_4 = param1.textLength;
                    if (_loc_4 == 0)
                    {
                        if (_loc_3 != textFlow.textLength)
                        {
                            _loc_4++;
                        }
                        else if (_loc_3 != 0)
                        {
                            _loc_3 = _loc_3 - 1;
                            _loc_4++;
                        }
                    }
                    if (_loc_4)
                    {
                        textFlow.damage(_loc_3, _loc_4, FlowDamageType.GEOMETRY, false);
                    }
                }
            }
            return;
        }// end function

        public function addControllerAt(param1:ContainerController, param2:int) : void
        {
            this.detachAllContainers();
            this._controllerList.splice(param2, 0, ContainerController(param1));
            this.attachAllContainers();
            return;
        }// end function

        private function fastRemoveController(param1:int) : Boolean
        {
            var _loc_3:* = null;
            if (param1 == -1)
            {
                return true;
            }
            var _loc_2:* = this._controllerList[param1];
            if (!_loc_2)
            {
                return true;
            }
            if (!_textFlow || _loc_2.absoluteStart == _textFlow.textLength)
            {
                if (param1 == 0)
                {
                    _loc_3 = _loc_2.container;
                    if (_loc_3)
                    {
                        clearContainerAccessibilityImplementation(_loc_3);
                    }
                }
                _loc_2.setRootElement(null);
                this._controllerList.splice(param1, 1);
                return true;
            }
            return false;
        }// end function

        public function removeController(param1:ContainerController) : void
        {
            var _loc_2:* = this.getControllerIndex(param1);
            if (!this.fastRemoveController(_loc_2))
            {
                this.detachAllContainers();
                this._controllerList.splice(_loc_2, 1);
                this.attachAllContainers();
            }
            return;
        }// end function

        public function removeControllerAt(param1:int) : void
        {
            if (!this.fastRemoveController(param1))
            {
                this.detachAllContainers();
                this._controllerList.splice(param1, 1);
                this.attachAllContainers();
            }
            return;
        }// end function

        public function removeAllControllers() : void
        {
            this.detachAllContainers();
            this._controllerList.splice(0, this._controllerList.length);
            return;
        }// end function

        public function getControllerAt(param1:int) : ContainerController
        {
            return this._controllerList[param1];
        }// end function

        public function getControllerIndex(param1:ContainerController) : int
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._controllerList.length)
            {
                
                if (this._controllerList[_loc_2] == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function findControllerIndexAtPosition(param1:int, param2:Boolean = false) : int
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = this._controllerList.length - 1;
            while (_loc_3 <= _loc_4)
            {
                
                _loc_5 = (_loc_3 + _loc_4) / 2;
                _loc_6 = this._controllerList[_loc_5];
                if (_loc_6.absoluteStart <= param1)
                {
                    if (param2)
                    {
                        if (_loc_6.absoluteStart + _loc_6.textLength >= param1)
                        {
                            while (_loc_5 != 0 && _loc_6.absoluteStart == param1)
                            {
                                
                                _loc_5 = _loc_5 - 1;
                                _loc_6 = this._controllerList[_loc_5];
                            }
                            return _loc_5;
                        }
                    }
                    else
                    {
                        if (_loc_6.absoluteStart == param1 && _loc_6.textLength != 0)
                        {
                            while (_loc_5 != 0)
                            {
                                
                                _loc_6 = this._controllerList[(_loc_5 - 1)];
                                if (_loc_6.textLength != 0)
                                {
                                    break;
                                }
                                _loc_5 = _loc_5 - 1;
                            }
                            return _loc_5;
                        }
                        if (_loc_6.absoluteStart + _loc_6.textLength > param1)
                        {
                            return _loc_5;
                        }
                    }
                    _loc_3 = _loc_5 + 1;
                    continue;
                }
                _loc_4 = _loc_5 - 1;
            }
            return -1;
        }// end function

        function clearCompositionResults() : void
        {
            var _loc_1:* = null;
            initializeLines();
            for each (_loc_1 in this._controllerList)
            {
                
                _loc_1.clearCompositionResults();
            }
            return;
        }// end function

        public function updateAllControllers() : Boolean
        {
            return this.updateToController();
        }// end function

        public function updateToController(param1:int = 2.14748e+009) : Boolean
        {
            if (this._composing)
            {
                return false;
            }
            var _loc_2:* = textFlow.interactionManager;
            if (_loc_2)
            {
                _loc_2.flushPendingOperations();
            }
            this.internalCompose(-1, param1);
            var _loc_3:* = this.areShapesDamaged();
            if (_loc_3)
            {
                this.updateCompositionShapes();
            }
            if (_loc_2)
            {
                _loc_2.refreshSelection();
            }
            return _loc_3;
        }// end function

        public function setFocus(param1:int, param2:Boolean = false) : void
        {
            var _loc_3:* = this.findControllerIndexAtPosition(param1, param2);
            if (_loc_3 == -1)
            {
                _loc_3 = this.numControllers - 1;
            }
            if (_loc_3 != -1)
            {
                this._controllerList[_loc_3].setFocus();
            }
            return;
        }// end function

        public function interactionManagerChanged(param1:ISelectionManager) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._controllerList)
            {
                
                _loc_2.interactionManagerChanged(param1);
            }
            return;
        }// end function

        private function updateCompositionShapes() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._controllerList)
            {
                
                _loc_1.updateCompositionShapes();
            }
            return;
        }// end function

        override public function isDamaged(param1:int) : Boolean
        {
            var _loc_2:* = null;
            if (!super.isDamaged(param1))
            {
                if (param1 == _textFlow.textLength)
                {
                    _loc_2 = this.getControllerAt((this.numControllers - 1));
                    if (_loc_2 && (_loc_2.verticalScrollPolicy != ScrollPolicy.OFF || _loc_2.horizontalScrollPolicy != ScrollPolicy.OFF))
                    {
                        return true;
                    }
                }
                return false;
            }
            return true;
        }// end function

        protected function preCompose() : Boolean
        {
            this.rootElement.preCompose();
            if (numLines == 0)
            {
                initializeLines();
            }
            return this.isDamaged(this.rootElement.getAbsoluteStart() + this.rootElement.textLength);
        }// end function

        function getComposeState() : ComposeState
        {
            return ComposeState.getComposeState();
        }// end function

        function releaseComposeState(param1:ComposeState) : void
        {
            ComposeState.releaseComposeState(param1);
            return;
        }// end function

        function callTheComposer(param1:int, param2:int) : ContainerController
        {
            if (_damageAbsoluteStart == this.rootElement.getAbsoluteStart() + this.rootElement.textLength)
            {
                return this.getControllerAt((this.numControllers - 1));
            }
            var _loc_3:* = this.getComposeState();
            var _loc_4:* = _loc_3.composeTextFlow(textFlow, param1, param2);
            if (_damageAbsoluteStart < _loc_4)
            {
                _damageAbsoluteStart = _loc_4;
            }
            finalizeLinesAfterCompose();
            var _loc_5:* = _loc_3.startController;
            this.releaseComposeState(_loc_3);
            if (textFlow.hasEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE))
            {
                textFlow.dispatchEvent(new CompositionCompleteEvent(CompositionCompleteEvent.COMPOSITION_COMPLETE, false, false, textFlow, 0, _loc_4));
            }
            return _loc_5;
        }// end function

        private function internalCompose(param1:int = -1, param2:int = -1) : ContainerController
        {
            var bp:String;
            var startController:ContainerController;
            var damageLimit:int;
            var controller:ContainerController;
            var lastVisibleLine:TextFlowLine;
            var idx:int;
            var composeToPosition:* = param1;
            var composeToControllerIndex:* = param2;
            var sm:* = textFlow.interactionManager;
            if (sm)
            {
                sm.flushPendingOperations();
            }
            this._composing = true;
            try
            {
                if (this.preCompose())
                {
                    if (textFlow && this.numControllers != 0)
                    {
                        damageLimit = _textFlow.textLength;
                        composeToControllerIndex = Math.min(composeToControllerIndex, (this.numControllers - 1));
                        if (composeToPosition != -1 || composeToControllerIndex != -1)
                        {
                            if (composeToControllerIndex < 0)
                            {
                                if (composeToPosition >= 0)
                                {
                                    damageLimit = composeToPosition;
                                }
                            }
                            else
                            {
                                controller = this.getControllerAt(composeToControllerIndex);
                                if (controller.textLength != 0)
                                {
                                    damageLimit = controller.absoluteStart + controller.textLength;
                                }
                                if (composeToControllerIndex == (this.numControllers - 1))
                                {
                                    bp = this.rootElement.computedFormat.blockProgression;
                                    lastVisibleLine = controller.getLastVisibleLine();
                                    if (lastVisibleLine && getBPDirectionScrollPosition(bp, controller) == this.lastBPDirectionScrollPosition)
                                    {
                                        damageLimit = lastVisibleLine.absoluteStart + lastVisibleLine.textLength;
                                    }
                                }
                            }
                        }
                        this.lastBPDirectionScrollPosition = Number.NEGATIVE_INFINITY;
                        if (_damageAbsoluteStart < damageLimit)
                        {
                            startController = this.callTheComposer(composeToPosition, composeToControllerIndex);
                            if (startController)
                            {
                                idx = this.getControllerIndex(startController);
                                while (idx < this.numControllers)
                                {
                                    
                                    idx = (idx + 1);
                                    this.getControllerAt(idx).shapesInvalid = true;
                                }
                            }
                        }
                    }
                }
            }
            catch (e:Error)
            {
                _composing = false;
                throw e;
            }
            this._composing = false;
            if (composeToControllerIndex == (this.numControllers - 1))
            {
                this.lastBPDirectionScrollPosition = getBPDirectionScrollPosition(bp, controller);
            }
            return startController;
        }// end function

        function areShapesDamaged() : Boolean
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._controllerList)
            {
                
                if (_loc_1.shapesInvalid)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function compose() : Boolean
        {
            return this._composing ? (false) : (this.internalCompose() != null);
        }// end function

        public function composeToPosition(param1:int = 2.14748e+009) : Boolean
        {
            return this._composing ? (false) : (this.internalCompose(param1, -1) != null);
        }// end function

        public function composeToController(param1:int = 2.14748e+009) : Boolean
        {
            return this._composing ? (false) : (this.internalCompose(-1, param1) != null);
        }// end function

        function createBackgroundManager() : BackgroundManager
        {
            return new BackgroundManager();
        }// end function

        private static function clearContainerAccessibilityImplementation(param1:Sprite) : void
        {
            if (param1.accessibilityImplementation)
            {
                if (param1.accessibilityImplementation is TextAccImpl)
                {
                    TextAccImpl(param1.accessibilityImplementation).detachListeners();
                }
                param1.accessibilityImplementation = null;
            }
            return;
        }// end function

        private static function getBPDirectionScrollPosition(param1:String, param2:ContainerController) : Number
        {
            return param1 == BlockProgression.TB ? (param2.verticalScrollPosition) : (param2.horizontalScrollPosition);
        }// end function

    }
}
