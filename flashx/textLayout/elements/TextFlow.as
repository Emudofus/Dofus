package flashx.textLayout.elements
{
    import flash.events.*;
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;

    public class TextFlow extends ContainerFormattedElement implements IEventDispatcher
    {
        private var _flowComposer:IFlowComposer;
        private var _interactionManager:ISelectionManager;
        private var _configuration:IConfiguration;
        private var _backgroundManager:BackgroundManager;
        private var normalizeStart:int = 0;
        private var normalizeLen:int = 0;
        private var _eventDispatcher:EventDispatcher;
        private var _generation:uint;
        private var _formatResolver:IFormatResolver;
        private var _interactiveObjectCount:int;
        private var _graphicObjectCount:int;
        private var _elemsToUpdate:Dictionary;
        private var _hostFormatHelper:HostFormatHelper;
        public static var defaultConfiguration:Configuration = new Configuration();
        private static var _nextGeneration:uint = 1;

        public function TextFlow(param1:IConfiguration = null)
        {
            this.initializeForConstructor(param1);
            return;
        }// end function

        private function initializeForConstructor(param1:IConfiguration) : void
        {
            if (param1 == null)
            {
                param1 = defaultConfiguration;
            }
            this._configuration = Configuration(param1).getImmutableClone();
            format = this._configuration.textFlowInitialFormat;
            if (this._configuration.flowComposerClass)
            {
                this.flowComposer = new this._configuration.flowComposerClass();
            }
            this._generation = _nextGeneration + 1;
            this._interactiveObjectCount = 0;
            this._graphicObjectCount = 0;
            return;
        }// end function

        override public function shallowCopy(param1:int = 0, param2:int = -1) : FlowElement
        {
            var _loc_3:* = super.shallowCopy(param1, param2) as TextFlow;
            _loc_3._configuration = this._configuration;
            _loc_3._generation = _nextGeneration + 1;
            if (this.formatResolver)
            {
                _loc_3.formatResolver = this.formatResolver.getResolverForNewFlow(this, _loc_3);
            }
            if (_loc_3.flowComposer && this.flowComposer)
            {
                _loc_3.flowComposer.swfContext = this.flowComposer.swfContext;
            }
            return _loc_3;
        }// end function

        function get interactiveObjectCount() : int
        {
            return this._interactiveObjectCount;
        }// end function

        function incInteractiveObjectCount() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._interactiveObjectCount + 1;
            _loc_1._interactiveObjectCount = _loc_2;
            return;
        }// end function

        function decInteractiveObjectCount() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._interactiveObjectCount - 1;
            _loc_1._interactiveObjectCount = _loc_2;
            return;
        }// end function

        function get graphicObjectCount() : int
        {
            return this._graphicObjectCount;
        }// end function

        function incGraphicObjectCount() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._graphicObjectCount + 1;
            _loc_1._graphicObjectCount = _loc_2;
            return;
        }// end function

        function decGraphicObjectCount() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._graphicObjectCount - 1;
            _loc_1._graphicObjectCount = _loc_2;
            return;
        }// end function

        public function get configuration() : IConfiguration
        {
            return this._configuration;
        }// end function

        public function get interactionManager() : ISelectionManager
        {
            return this._interactionManager;
        }// end function

        public function set interactionManager(param1:ISelectionManager) : void
        {
            if (this._interactionManager != param1)
            {
                if (this._interactionManager)
                {
                    this._interactionManager.textFlow = null;
                }
                this._interactionManager = param1;
                if (this._interactionManager)
                {
                    this._interactionManager.textFlow = this;
                    this.normalize();
                }
                if (this.flowComposer)
                {
                    this.flowComposer.interactionManagerChanged(param1);
                }
            }
            return;
        }// end function

        override public function get flowComposer() : IFlowComposer
        {
            return this._flowComposer;
        }// end function

        public function set flowComposer(param1:IFlowComposer) : void
        {
            this.changeFlowComposer(param1, true);
            return;
        }// end function

        function changeFlowComposer(param1:IFlowComposer, param2:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_3:* = this._flowComposer;
            if (this._flowComposer != param1)
            {
                _loc_4 = FlowComposerBase.computeBaseSWFContext(this._flowComposer ? (this._flowComposer.swfContext) : (null));
                _loc_5 = FlowComposerBase.computeBaseSWFContext(param1 ? (param1.swfContext) : (null));
                if (this._flowComposer)
                {
                    _loc_6 = 0;
                    while (_loc_6 < this._flowComposer.numControllers)
                    {
                        
                        this._flowComposer.getControllerAt(_loc_6++).clearSelectionShapes();
                    }
                    this._flowComposer.setRootElement(null);
                }
                this._flowComposer = param1;
                if (this._flowComposer)
                {
                    this._flowComposer.setRootElement(this);
                }
                if (textLength)
                {
                    this.damage(getAbsoluteStart(), textLength, TextLineValidity.INVALID, false);
                }
                if (_loc_4 != _loc_5)
                {
                    this.invalidateAllFormats();
                }
                if (this._flowComposer == null)
                {
                    if (param2)
                    {
                        this.unloadGraphics();
                    }
                }
                else if (_loc_3 == null)
                {
                    this.prepareGraphicsForLoad();
                }
            }
            return;
        }// end function

        function unloadGraphics() : void
        {
            if (this._graphicObjectCount)
            {
                applyFunctionToElements(function (param1:FlowElement) : Boolean
            {
                if (param1 is InlineGraphicElement)
                {
                    (param1 as InlineGraphicElement).stop(true);
                }
                return false;
            }// end function
            );
            }
            return;
        }// end function

        function prepareGraphicsForLoad() : void
        {
            if (this._graphicObjectCount)
            {
                appendElementsForDelayedUpdate(this, null);
            }
            return;
        }// end function

        public function getElementByID(param1:String) : FlowElement
        {
            var rslt:FlowElement;
            var idName:* = param1;
            applyFunctionToElements(function (param1:FlowElement) : Boolean
            {
                if (param1.id == idName)
                {
                    rslt = param1;
                    return true;
                }
                return false;
            }// end function
            );
            return rslt;
        }// end function

        public function getElementsByStyleName(param1:String) : Array
        {
            var a:Array;
            var styleNameValue:* = param1;
            a = new Array();
            applyFunctionToElements(function (param1:FlowElement) : Boolean
            {
                if (param1.styleName == styleNameValue)
                {
                    a.push(param1);
                }
                return false;
            }// end function
            );
            return a;
        }// end function

        public function getElementsByTypeName(param1:String) : Array
        {
            var a:Array;
            var typeNameValue:* = param1;
            a = new Array();
            applyFunctionToElements(function (param1:FlowElement) : Boolean
            {
                if (param1.typeName == typeNameValue)
                {
                    a.push(param1);
                }
                return false;
            }// end function
            );
            return a;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "TextFlow";
        }// end function

        override function updateLengths(param1:int, param2:int, param3:Boolean) : void
        {
            var _loc_4:* = 0;
            if (this.normalizeStart != -1)
            {
                _loc_4 = param1 < this.normalizeStart ? (param1) : (this.normalizeStart);
                if (_loc_4 < this.normalizeStart)
                {
                    this.normalizeLen = this.normalizeLen + (this.normalizeStart - _loc_4);
                }
                this.normalizeLen = this.normalizeLen + param2;
                this.normalizeStart = _loc_4;
            }
            else
            {
                this.normalizeStart = param1;
                this.normalizeLen = param2;
            }
            if (this.normalizeLen < 0)
            {
                this.normalizeLen = 0;
            }
            if (param3 && this._flowComposer)
            {
                this._flowComposer.updateLengths(param1, param2);
                super.updateLengths(param1, param2, false);
            }
            else
            {
                super.updateLengths(param1, param2, param3);
            }
            return;
        }// end function

        override public function set mxmlChildren(param1:Array) : void
        {
            super.mxmlChildren = param1;
            this.normalize();
            applyWhiteSpaceCollapse(null);
            return;
        }// end function

        function applyUpdateElements(param1:Boolean) : Boolean
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            if (this._elemsToUpdate)
            {
                _loc_2 = this.flowComposer && this.flowComposer.numControllers != 0;
                for (_loc_3 in this._elemsToUpdate)
                {
                    
                    (_loc_3 as FlowElement).applyDelayedElementUpdate(this, param1, _loc_2);
                }
                if (_loc_2)
                {
                    this._elemsToUpdate = null;
                    return true;
                }
            }
            return false;
        }// end function

        override function preCompose() : void
        {
            do
            {
                
                this.normalize();
            }while (this.applyUpdateElements(true))
            return;
        }// end function

        function damage(param1:int, param2:int, param3:String, param4:Boolean = true) : void
        {
            var _loc_5:* = 0;
            if (param4)
            {
                if (this.normalizeStart == -1)
                {
                    this.normalizeStart = param1;
                    this.normalizeLen = param2;
                }
                else if (param1 < this.normalizeStart)
                {
                    _loc_5 = this.normalizeLen;
                    _loc_5 = this.normalizeStart + this.normalizeLen - param1;
                    if (param2 > _loc_5)
                    {
                        _loc_5 = param2;
                    }
                    this.normalizeStart = param1;
                    this.normalizeLen = _loc_5;
                }
                else if (this.normalizeStart + this.normalizeLen > param1)
                {
                    if (param1 + param2 > this.normalizeStart + this.normalizeLen)
                    {
                        this.normalizeLen = param1 + param2 - this.normalizeStart;
                    }
                }
                else
                {
                    this.normalizeLen = param1 + param2 - this.normalizeStart;
                }
                if (this.normalizeStart + this.normalizeLen > textLength)
                {
                    this.normalizeLen = textLength - this.normalizeStart;
                }
            }
            if (this._flowComposer)
            {
                this._flowComposer.damage(param1, param2, param3);
            }
            if (this.hasEventListener(DamageEvent.DAMAGE))
            {
                this.dispatchEvent(new DamageEvent(DamageEvent.DAMAGE, false, false, this, param1, param2));
            }
            return;
        }// end function

        function findAbsoluteParagraph(param1:int) : ParagraphElement
        {
            var _loc_2:* = findLeaf(param1);
            return _loc_2 ? (_loc_2.getParagraph()) : (null);
        }// end function

        function findAbsoluteFlowGroupElement(param1:int) : FlowGroupElement
        {
            var _loc_2:* = findLeaf(param1);
            return _loc_2.parent;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            if (!this._eventDispatcher)
            {
                this._eventDispatcher = new EventDispatcher(this);
            }
            this._eventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            if (!this._eventDispatcher)
            {
                return true;
            }
            return this._eventDispatcher.dispatchEvent(event);
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            if (!this._eventDispatcher)
            {
                return false;
            }
            return this._eventDispatcher.hasEventListener(param1);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            if (!this._eventDispatcher)
            {
                return;
            }
            this._eventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            if (!this._eventDispatcher)
            {
                return false;
            }
            return this._eventDispatcher.willTrigger(param1);
        }// end function

        function appendOneElementForUpdate(param1:FlowElement) : void
        {
            if (this._elemsToUpdate == null)
            {
                this._elemsToUpdate = new Dictionary();
            }
            this._elemsToUpdate[param1] = null;
            return;
        }// end function

        function mustUseComposer() : Boolean
        {
            var _loc_2:* = null;
            if (this._interactiveObjectCount != 0)
            {
                return true;
            }
            if (this._elemsToUpdate == null || this._elemsToUpdate.length == 0)
            {
                return false;
            }
            this.normalize();
            var _loc_1:* = false;
            for (_loc_2 in this._elemsToUpdate)
            {
                
                if ((_loc_2 as FlowElement).updateForMustUseComposer(this))
                {
                    _loc_1 = true;
                }
            }
            return _loc_1;
        }// end function

        function processModelChanged(param1:String, param2:Object, param3:int, param4:int, param5:Boolean, param6:Boolean) : void
        {
            if (param2 is FlowElement)
            {
                (param2 as FlowElement).appendElementsForDelayedUpdate(this, param1);
            }
            if (param6)
            {
                this._generation = _nextGeneration + 1;
            }
            if (param4 > 0 || param1 == ModelChange.ELEMENT_ADDED)
            {
                this.damage(param3, param4, TextLineValidity.INVALID, param5);
            }
            if (this.formatResolver)
            {
                switch(param1)
                {
                    case ModelChange.ELEMENT_REMOVAL:
                    case ModelChange.ELEMENT_ADDED:
                    case ModelChange.STYLE_SELECTOR_CHANGED:
                    {
                        this.formatResolver.invalidate(param2);
                        param2.formatChanged(false);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get generation() : uint
        {
            return this._generation;
        }// end function

        function setGeneration(param1:uint) : void
        {
            this._generation = param1;
            return;
        }// end function

        function processAutoSizeImageLoaded(param1:InlineGraphicElement) : void
        {
            if (this.flowComposer)
            {
                param1.appendElementsForDelayedUpdate(this, null);
            }
            return;
        }// end function

        function normalize() : void
        {
            var _loc_1:* = 0;
            if (this.normalizeStart != -1)
            {
                _loc_1 = this.normalizeStart + (this.normalizeLen == 0 ? (1) : (this.normalizeLen));
                normalizeRange(this.normalizeStart == 0 ? (this.normalizeStart) : ((this.normalizeStart - 1)), _loc_1);
                this.normalizeStart = -1;
                this.normalizeLen = 0;
            }
            return;
        }// end function

        public function get hostFormat() : ITextLayoutFormat
        {
            return this._hostFormatHelper ? (this._hostFormatHelper.format) : (null);
        }// end function

        public function set hostFormat(param1:ITextLayoutFormat) : void
        {
            if (param1 == null)
            {
                this._hostFormatHelper = null;
            }
            else
            {
                if (this._hostFormatHelper == null)
                {
                    this._hostFormatHelper = new HostFormatHelper();
                }
                this._hostFormatHelper.format = param1;
            }
            formatChanged();
            return;
        }// end function

        override function doComputeTextLayoutFormat() : TextLayoutFormat
        {
            var _loc_1:* = this._hostFormatHelper ? (this._hostFormatHelper.getComputedPrototypeFormat()) : (null);
            return FlowElement.createTextLayoutFormatPrototype(formatForCascade, _loc_1);
        }// end function

        function getTextLayoutFormatStyle(param1:Object) : TextLayoutFormat
        {
            if (this._formatResolver == null)
            {
                return null;
            }
            var _loc_2:* = this._formatResolver.resolveFormat(param1);
            if (_loc_2 == null)
            {
                return null;
            }
            var _loc_3:* = _loc_2 as TextLayoutFormat;
            return _loc_3 ? (_loc_3) : (new TextLayoutFormat(_loc_2));
        }// end function

        function get backgroundManager() : BackgroundManager
        {
            return this._backgroundManager;
        }// end function

        function clearBackgroundManager() : void
        {
            this._backgroundManager = null;
            return;
        }// end function

        function getBackgroundManager() : BackgroundManager
        {
            if (!this._backgroundManager && this.flowComposer is StandardFlowComposer)
            {
                this._backgroundManager = (this.flowComposer as StandardFlowComposer).createBackgroundManager();
            }
            return this._backgroundManager;
        }// end function

        public function get formatResolver() : IFormatResolver
        {
            return this._formatResolver;
        }// end function

        public function set formatResolver(param1:IFormatResolver) : void
        {
            if (this._formatResolver != param1)
            {
                if (this._formatResolver)
                {
                    this._formatResolver.invalidateAll(this);
                }
                this._formatResolver = param1;
                if (this._formatResolver)
                {
                    this._formatResolver.invalidateAll(this);
                }
                formatChanged(true);
            }
            return;
        }// end function

        public function invalidateAllFormats() : void
        {
            if (this._formatResolver)
            {
                this._formatResolver.invalidateAll(this);
            }
            formatChanged(true);
            return;
        }// end function

    }
}

import flash.events.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.compose.*;

import flashx.textLayout.edit.*;

import flashx.textLayout.events.*;

import flashx.textLayout.formats.*;

class HostFormatHelper extends Object
{
    private var _format:ITextLayoutFormat;
    private var _computedPrototypeFormat:TextLayoutFormat;

    function HostFormatHelper()
    {
        return;
    }// end function

    public function get format() : ITextLayoutFormat
    {
        return this._format;
    }// end function

    public function set format(param1:ITextLayoutFormat) : void
    {
        this._format = param1;
        this._computedPrototypeFormat = null;
        return;
    }// end function

    public function getComputedPrototypeFormat() : TextLayoutFormat
    {
        var _loc_1:* = null;
        if (this._computedPrototypeFormat == null)
        {
            if (this._format is TextLayoutFormat || this._format is TextLayoutFormat)
            {
                _loc_1 = this._format;
            }
            else
            {
                _loc_1 = new TextLayoutFormat(this._format);
            }
            this._computedPrototypeFormat = FlowElement.createTextLayoutFormatPrototype(_loc_1, null);
        }
        return this._computedPrototypeFormat;
    }// end function

}

