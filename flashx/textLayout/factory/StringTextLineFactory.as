package flashx.textLayout.factory
{
    import flash.geom.*;
    import flash.text.engine.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;

    public class StringTextLineFactory extends TextLineFactoryBase
    {
        private var _tf:TextFlow;
        private var _para:ParagraphElement;
        private var _span:SpanElement;
        private var _formatsChanged:Boolean;
        private var _configuration:IConfiguration;
        private var _truncatedText:String;
        private static var _defaultConfiguration:Configuration = null;
        private static var _measurementFactory:StringTextLineFactory = null;
        private static var _measurementLines:Array = null;

        public function StringTextLineFactory(param1:IConfiguration = null)
        {
            this.initialize(param1);
            return;
        }// end function

        public function get configuration() : IConfiguration
        {
            return this._configuration;
        }// end function

        private function initialize(param1:IConfiguration) : void
        {
            this._configuration = Configuration(param1 ? (param1) : (defaultConfiguration)).getImmutableClone();
            this._tf = new TextFlow(this._configuration);
            this._para = new ParagraphElement();
            this._span = new SpanElement();
            this._para.replaceChildren(0, 0, this._span);
            this._tf.replaceChildren(0, 0, this._para);
            this._tf.flowComposer.addController(containerController);
            this._formatsChanged = true;
            return;
        }// end function

        public function get spanFormat() : ITextLayoutFormat
        {
            return this._span.format;
        }// end function

        public function set spanFormat(param1:ITextLayoutFormat) : void
        {
            this._span.format = param1;
            this._formatsChanged = true;
            return;
        }// end function

        public function get paragraphFormat() : ITextLayoutFormat
        {
            return this._para.format;
        }// end function

        public function set paragraphFormat(param1:ITextLayoutFormat) : void
        {
            this._para.format = param1;
            this._formatsChanged = true;
            return;
        }// end function

        public function get textFlowFormat() : ITextLayoutFormat
        {
            return this._tf.format;
        }// end function

        public function set textFlowFormat(param1:ITextLayoutFormat) : void
        {
            this._tf.format = param1;
            this._formatsChanged = true;
            return;
        }// end function

        public function get text() : String
        {
            return this._span.text;
        }// end function

        public function set text(param1:String) : void
        {
            this._span.text = param1;
            return;
        }// end function

        public function createTextLines(param1:Function) : void
        {
            var callback:* = param1;
            var saved:* = TextLineFactoryBase.beginFactoryCompose();
            this.createTextLinesInternal(callback);
            finally
            {
                var _loc_3:* = new catch0;
                throw null;
            }
            finally
            {
                _factoryComposer._lines.splice(0);
                if (_pass0Lines)
                {
                    _pass0Lines.splice(0);
                }
                TextLineFactoryBase.endFactoryCompose(saved);
            }
            return;
        }// end function

        private function createTextLinesInternal(param1:Function) : void
        {
            var _loc_2:* = !compositionBounds || isNaN(compositionBounds.width);
            var _loc_3:* = !compositionBounds || isNaN(compositionBounds.height);
            var _loc_4:* = this._tf.computedFormat.blockProgression;
            containerController.setCompositionSize(compositionBounds.width, compositionBounds.height);
            containerController.verticalScrollPolicy = truncationOptions ? (ScrollPolicy.OFF) : (verticalScrollPolicy);
            containerController.horizontalScrollPolicy = truncationOptions ? (ScrollPolicy.OFF) : (horizontalScrollPolicy);
            _isTruncated = false;
            this._truncatedText = this.text;
            if (!this._formatsChanged && FlowComposerBase.computeBaseSWFContext(this._tf.flowComposer.swfContext) != FlowComposerBase.computeBaseSWFContext(swfContext))
            {
                this._formatsChanged = true;
            }
            this._tf.flowComposer.swfContext = swfContext;
            if (this._formatsChanged)
            {
                this._tf.normalize();
                this._formatsChanged = false;
            }
            this._tf.flowComposer.compose();
            if (truncationOptions)
            {
                this.doTruncation(_loc_4, _loc_2, _loc_3);
            }
            var _loc_5:* = compositionBounds.x;
            var _loc_6:* = containerController.getContentBounds();
            if (_loc_4 == BlockProgression.RL)
            {
                _loc_5 = _loc_5 + (_loc_2 ? (_loc_6.width) : (compositionBounds.width));
            }
            _loc_6.left = _loc_6.left + _loc_5;
            _loc_6.right = _loc_6.right + _loc_5;
            _loc_6.top = _loc_6.top + compositionBounds.y;
            _loc_6.bottom = _loc_6.bottom + compositionBounds.y;
            if (this._tf.backgroundManager)
            {
                processBackgroundColors(this._tf, param1, _loc_5, compositionBounds.y, containerController.compositionWidth, containerController.compositionHeight);
            }
            callbackWithTextLines(param1, _loc_5, compositionBounds.y);
            setContentBounds(_loc_6);
            containerController.clearCompositionResults();
            return;
        }// end function

        function doTruncation(param1:String, param2:Boolean, param3:Boolean) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = 0;
            param1 = this._tf.computedFormat.blockProgression;
            if (!doesComposedTextFit(truncationOptions.lineCountLimit, this._tf.textLength, param1))
            {
                _isTruncated = true;
                _loc_4 = false;
                _loc_5 = this._span.text;
                computeLastAllowedLineIndex(truncationOptions.lineCountLimit);
                if (_truncationLineIndex >= 0)
                {
                    this.measureTruncationIndicator(compositionBounds, truncationOptions.truncationIndicator);
                    _truncationLineIndex = _truncationLineIndex - (_measurementLines.length - 1);
                    if (_truncationLineIndex >= 0)
                    {
                        if (this._tf.computedFormat.lineBreak == LineBreak.EXPLICIT || (param1 == BlockProgression.TB ? (param2) : (param3)))
                        {
                            _loc_7 = _factoryComposer._lines[_truncationLineIndex] as TextLine;
                            _loc_6 = _loc_7.userData + _loc_7.rawTextLength;
                        }
                        else
                        {
                            _loc_8 = param1 == BlockProgression.TB ? (compositionBounds.width) : (compositionBounds.height);
                            if (this.paragraphFormat)
                            {
                                _loc_8 = _loc_8 - (Number(this.paragraphFormat.paragraphSpaceAfter) + Number(this.paragraphFormat.paragraphSpaceBefore));
                                if (_truncationLineIndex == 0)
                                {
                                    _loc_8 = _loc_8 - this.paragraphFormat.textIndent;
                                }
                            }
                            _loc_9 = _loc_8 - (_measurementLines[(_measurementLines.length - 1)] as TextLine).unjustifiedTextWidth;
                            _loc_6 = this.getTruncationPosition(_factoryComposer._lines[_truncationLineIndex], _loc_9);
                        }
                        if (!_pass0Lines)
                        {
                            _pass0Lines = new Array();
                        }
                        _pass0Lines = _factoryComposer.swapLines(_pass0Lines);
                        this._para = this._para.deepCopy() as ParagraphElement;
                        this._span = this._para.getChildAt(0) as SpanElement;
                        this._tf.replaceChildren(0, 1, this._para);
                        this._tf.normalize();
                        this._span.replaceText(_loc_6, this._span.textLength, truncationOptions.truncationIndicator);
                        do
                        {
                            
                            this._tf.flowComposer.compose();
                            if (doesComposedTextFit(truncationOptions.lineCountLimit, this._tf.textLength, param1))
                            {
                                _loc_4 = true;
                                break;
                            }
                            if (_loc_6 == 0)
                            {
                                break;
                            }
                            _loc_10 = getNextTruncationPosition(_loc_6);
                            this._span.replaceText(_loc_10, _loc_6, null);
                            _loc_6 = _loc_10;
                        }while (true)
                    }
                    _measurementLines.splice(0);
                }
                if (_loc_4)
                {
                    this._truncatedText = this._span.text;
                }
                else
                {
                    this._truncatedText = "";
                    _factoryComposer._lines.splice(0);
                }
                this._span.text = _loc_5;
            }
            return;
        }// end function

        function get truncatedText() : String
        {
            return this._truncatedText;
        }// end function

        private function measureTruncationIndicator(param1:Rectangle, param2:String) : void
        {
            var _loc_3:* = _factoryComposer.swapLines(measurementLines());
            var _loc_4:* = measurementFactory();
            measurementFactory().compositionBounds = param1;
            _loc_4.text = param2;
            _loc_4.spanFormat = this.spanFormat;
            _loc_4.paragraphFormat = this.paragraphFormat;
            _loc_4.textFlowFormat = this.textFlowFormat;
            _loc_4.truncationOptions = null;
            _loc_4.createTextLinesInternal(noopfunction);
            _factoryComposer.swapLines(_loc_3);
            return;
        }// end function

        private function getTruncationPosition(param1:TextLine, param2:Number) : uint
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = param1.userData;
            while (_loc_4 < param1.userData + param1.rawTextLength)
            {
                
                _loc_5 = param1.getAtomIndexAtCharIndex(_loc_4);
                _loc_6 = param1.getAtomBounds(_loc_5);
                _loc_3 = _loc_3 + _loc_6.width;
                if (_loc_3 > param2)
                {
                    break;
                }
                _loc_4 = param1.getAtomTextBlockEndIndex(_loc_5);
            }
            return _loc_4;
        }// end function

        public static function get defaultConfiguration() : IConfiguration
        {
            if (!_defaultConfiguration)
            {
                _defaultConfiguration = TextFlow.defaultConfiguration.clone();
                _defaultConfiguration.flowComposerClass = getDefaultFlowComposerClass();
                _defaultConfiguration.textFlowInitialFormat = null;
            }
            return _defaultConfiguration;
        }// end function

        private static function measurementFactory() : StringTextLineFactory
        {
            if (_measurementFactory == null)
            {
                _measurementFactory = new StringTextLineFactory;
            }
            return _measurementFactory;
        }// end function

        private static function measurementLines() : Array
        {
            if (_measurementLines == null)
            {
                _measurementLines = new Array();
            }
            return _measurementLines;
        }// end function

        private static function noopfunction(param1:Object) : void
        {
            return;
        }// end function

    }
}
