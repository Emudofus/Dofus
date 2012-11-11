package flashx.textLayout.factory
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.engine.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;

    public class TextLineFactoryBase extends Object
    {
        private var _compositionBounds:Rectangle;
        private var _contentBounds:Rectangle;
        protected var _isTruncated:Boolean = false;
        private var _horizontalScrollPolicy:String;
        private var _verticalScrollPolicy:String;
        private var _truncationOptions:TruncationOptions;
        private var _containerController:ContainerController;
        private var _swfContext:ISWFContext;
        private static var _tc:Sprite = new Sprite();
        private static var _savedFactoryComposer:SimpleCompose;
        static var _factoryComposer:SimpleCompose;
        static var _truncationLineIndex:int;
        static var _pass0Lines:Array;

        public function TextLineFactoryBase()
        {
            this._containerController = new ContainerController(_tc);
            var _loc_1:* = String(ScrollPolicy.scrollPolicyPropertyDefinition.defaultValue);
            this._verticalScrollPolicy = String(ScrollPolicy.scrollPolicyPropertyDefinition.defaultValue);
            this._horizontalScrollPolicy = _loc_1;
            return;
        }// end function

        public function get compositionBounds() : Rectangle
        {
            return this._compositionBounds;
        }// end function

        public function set compositionBounds(param1:Rectangle) : void
        {
            this._compositionBounds = param1;
            return;
        }// end function

        public function getContentBounds() : Rectangle
        {
            return this._contentBounds;
        }// end function

        protected function setContentBounds(param1:Rectangle) : void
        {
            this._contentBounds = param1;
            this._contentBounds.offset(this.compositionBounds.left, this.compositionBounds.top);
            return;
        }// end function

        public function get swfContext() : ISWFContext
        {
            return this._swfContext;
        }// end function

        public function set swfContext(param1:ISWFContext) : void
        {
            this._swfContext = param1;
            return;
        }// end function

        public function get truncationOptions() : TruncationOptions
        {
            return this._truncationOptions;
        }// end function

        public function set truncationOptions(param1:TruncationOptions) : void
        {
            this._truncationOptions = param1;
            return;
        }// end function

        public function get isTruncated() : Boolean
        {
            return this._isTruncated;
        }// end function

        public function get horizontalScrollPolicy() : String
        {
            return this._horizontalScrollPolicy;
        }// end function

        public function set horizontalScrollPolicy(param1:String) : void
        {
            this._horizontalScrollPolicy = param1;
            return;
        }// end function

        public function get verticalScrollPolicy() : String
        {
            return this._verticalScrollPolicy;
        }// end function

        public function set verticalScrollPolicy(param1:String) : void
        {
            this._verticalScrollPolicy = param1;
            return;
        }// end function

        protected function get containerController() : ContainerController
        {
            return this._containerController;
        }// end function

        protected function callbackWithTextLines(param1:Function, param2:Number, param3:Number) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            for each (_loc_4 in _factoryComposer._lines)
            {
                
                _loc_5 = _loc_4.textBlock;
                if (_loc_5)
                {
                    _loc_5.releaseLines(_loc_5.firstLine, _loc_5.lastLine);
                }
                _loc_4.userData = null;
                _loc_4.x = _loc_4.x + param2;
                _loc_4.y = _loc_4.y + param3;
                _loc_4.validity = TextLineValidity.STATIC;
                this.param1(_loc_4);
            }
            return;
        }// end function

        protected function doesComposedTextFit(param1:int, param2:uint, param3:String) : Boolean
        {
            if (param1 != TruncationOptions.NO_LINE_COUNT_LIMIT && _factoryComposer._lines.length > param1)
            {
                return false;
            }
            var _loc_4:* = _factoryComposer._lines;
            if (!_factoryComposer._lines.length)
            {
                return param2 ? (false) : (true);
            }
            var _loc_5:* = _loc_4[(_loc_4.length - 1)] as TextLine;
            return (_loc_4[(_loc_4.length - 1)] as TextLine).userData + _loc_5.rawTextLength == param2;
        }// end function

        protected function getNextTruncationPosition(param1:int, param2:Boolean = false) : int
        {
            param1 = param1 - 1;
            var _loc_3:* = _pass0Lines[_truncationLineIndex] as TextLine;
            do
            {
                
                if (param1 >= _loc_3.userData && param1 < _loc_3.userData + _loc_3.rawTextLength)
                {
                    break;
                }
                if (param1 < _loc_3.userData)
                {
                    _loc_3 = _pass0Lines[--_truncationLineIndex] as TextLine;
                    continue;
                }
            }while (true)
            var _loc_4:* = param2 ? (_loc_3.userData - _loc_3.textBlockBeginIndex) : (0);
            var _loc_5:* = _loc_3.getAtomIndexAtCharIndex(param1 - _loc_4);
            var _loc_6:* = _loc_3.getAtomTextBlockBeginIndex(_loc_5) + _loc_4;
            _loc_3.flushAtomData();
            return _loc_6;
        }// end function

        function createFlowComposer() : IFlowComposer
        {
            return new FactoryDisplayComposer();
        }// end function

        function computeLastAllowedLineIndex(param1:int) : void
        {
            _truncationLineIndex = _factoryComposer._lines.length - 1;
            if (param1 != TruncationOptions.NO_LINE_COUNT_LIMIT && param1 <= _truncationLineIndex)
            {
                _truncationLineIndex = param1 - 1;
            }
            return;
        }// end function

        function processBackgroundColors(param1:TextFlow, param2:Function, param3:Number, param4:Number, param5:Number, param6:Number)
        {
            var _loc_7:* = new Shape();
            param1.backgroundManager.drawAllRects(param1, _loc_7, param5, param6);
            _loc_7.x = param3;
            _loc_7.y = param4;
            this.param2(_loc_7);
            param1.clearBackgroundManager();
            return;
        }// end function

        static function peekFactoryCompose() : SimpleCompose
        {
            if (_savedFactoryComposer == null)
            {
                _savedFactoryComposer = new SimpleCompose();
            }
            return _savedFactoryComposer;
        }// end function

        static function beginFactoryCompose() : SimpleCompose
        {
            var _loc_1:* = _factoryComposer;
            _factoryComposer = peekFactoryCompose();
            _savedFactoryComposer = null;
            return _loc_1;
        }// end function

        static function endFactoryCompose(param1:SimpleCompose) : void
        {
            _savedFactoryComposer = _factoryComposer;
            _factoryComposer = param1;
            return;
        }// end function

        static function getDefaultFlowComposerClass() : Class
        {
            return FactoryDisplayComposer;
        }// end function

    }
}
