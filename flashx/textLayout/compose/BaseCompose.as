package flashx.textLayout.compose
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.utils.*;

    public class BaseCompose extends Object
    {
        protected var _parcelList:ParcelList;
        protected var _curElement:FlowLeafElement;
        protected var _curElementStart:int;
        protected var _curElementOffset:int;
        protected var _curParaElement:ParagraphElement;
        protected var _curParaFormat:ITextLayoutFormat;
        protected var _curParaStart:int;
        private var _curLineLeadingModel:String = "";
        private var _curLineLeading:Number;
        protected var _lastLineLeadingModel:String = "";
        protected var _lastLineLeading:Number;
        protected var _lastLineDescent:Number;
        protected var _paragraphSpaceCarried:Number;
        protected var _verticalSpaceCarried:Number;
        protected var _blockProgression:String;
        protected var _atColumnStart:Boolean;
        protected var _textIndent:Number;
        private var _controllerLeft:Number;
        private var _controllerTop:Number;
        private var _controllerRight:Number;
        private var _controllerBottom:Number;
        protected var _contentLogicalExtent:Number;
        protected var _contentCommittedExtent:Number;
        protected var _contentCommittedHeight:Number;
        protected var _workingContentLogicalExtent:Number;
        protected var _workingContentExtent:Number;
        protected var _workingContentHeight:Number;
        protected var _workingTotalDepth:Number;
        protected var _workingParcelIndex:int;
        protected var _workingParcelLogicalTop:Number;
        protected var _accumulatedMinimumStart:Number;
        protected var _parcelLogicalTop:Number;
        protected var _parcelLeft:Number;
        protected var _parcelTop:Number;
        protected var _parcelRight:Number;
        protected var _parcelBottom:Number;
        protected var _textFlow:TextFlow;
        private var _releaseLineCreationData:Boolean;
        protected var _flowComposer:IFlowComposer;
        protected var _rootElement:ContainerFormattedElement;
        protected var _stopComposePos:int;
        protected var _startController:ContainerController;
        protected var _startComposePosition:int;
        protected var _controllerVisibleBoundsXTW:int;
        protected var _controllerVisibleBoundsYTW:int;
        protected var _controllerVisibleBoundsWidthTW:int;
        protected var _controllerVisibleBoundsHeightTW:int;
        protected var _forceILGs:Boolean;
        protected var _lastGoodStart:int;
        protected var _linePass:int;
        protected var _paragraphContainsVisibleLines:Boolean;
        protected var _lineSlug:Slug;
        protected var _pushInFloats:Array;
        private var _alignLines:Array;
        protected var _curParcel:Parcel;
        protected var _curParcelStart:int;
        protected var _curInteractiveObjects:Dictionary = null;
        protected var _measuring:Boolean;
        protected var _curLine:TextFlowLine;
        protected var _previousLine:TextLine;
        protected var _listItemElement:ListItemElement;
        private static var _savedAlignData:AlignData;
        static var _savedLineSlug:Slug;
        static var _floatSlug:Slug;

        public function BaseCompose()
        {
            this._lineSlug = new Slug();
            return;
        }// end function

        public function get parcelList() : ParcelList
        {
            return this._parcelList;
        }// end function

        protected function createParcelList() : ParcelList
        {
            return null;
        }// end function

        protected function releaseParcelList(param1:ParcelList) : void
        {
            return;
        }// end function

        public function get startController() : ContainerController
        {
            return this._startController;
        }// end function

        function releaseAnyReferences() : void
        {
            this._curElement = null;
            this._curParaElement = null;
            this._curParaFormat = null;
            this._flowComposer = null;
            this._parcelList = null;
            this._rootElement = null;
            this._startController = null;
            this._textFlow = null;
            this._previousLine = null;
            this._curLine = null;
            return;
        }// end function

        protected function initializeForComposer(param1:IFlowComposer, param2:int, param3:int, param4:int) : void
        {
            if (!_savedLineSlug)
            {
                this._lineSlug = new Slug();
            }
            else
            {
                this._lineSlug = _savedLineSlug;
                _savedLineSlug = null;
            }
            this._parcelList = this.createParcelList();
            this._paragraphSpaceCarried = 0;
            this._blockProgression = param1.rootElement.computedFormat.blockProgression;
            this._stopComposePos = param2 >= 0 ? (Math.min(this._textFlow.textLength, param2)) : (this._textFlow.textLength);
            if (param3 < 0)
            {
                param3 = 0;
            }
            this._parcelList.beginCompose(param1, param3, param4, param2 > 0);
            this._contentLogicalExtent = 0;
            this._contentCommittedExtent = 0;
            this._contentCommittedHeight = 0;
            this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
            this._parcelLogicalTop = NaN;
            this._linePass = 0;
            this._lastGoodStart = -1;
            if (this._pushInFloats)
            {
                this._pushInFloats.length = 0;
            }
            this._listItemElement = null;
            return;
        }// end function

        private function composeBlockElement(param1:FlowGroupElement, param2:int) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            var _loc_15:* = null;
            var _loc_5:* = 0;
            if (param2 != this._curElementStart + this._curElementOffset)
            {
                _loc_5 = param1.findChildIndexAtPosition(this._curElementStart + this._curElementOffset - param2);
                _loc_3 = param1.getChildAt(_loc_5);
                param2 = param2 + _loc_3.parentRelativeStart;
            }
            var _loc_6:* = this._textFlow.findLeaf((this._startComposePosition - 1));
            if (this._textFlow.findLeaf((this._startComposePosition - 1)))
            {
                _loc_8 = _loc_6.getParagraph();
                if (_loc_8 && _loc_8 != this._curElement.getParagraph())
                {
                    if (_loc_8.paddingBottom != undefined)
                    {
                        this._parcelList.addTotalDepth(_loc_8.paddingBottom);
                    }
                }
            }
            var _loc_7:* = param2 == this._curElementStart + this._curElementOffset;
            while (_loc_5 < param1.numChildren && (param2 <= this._stopComposePos || !this.parcelList.atLast()))
            {
                
                _loc_3 = param1.getChildAt(_loc_5);
                if (_loc_3.computedFormat.clearFloats != ClearFloats.NONE)
                {
                    _loc_14 = this._curParcel.applyClear(_loc_3.computedFormat.clearFloats, this._parcelList.totalDepth, _loc_3.computedFormat.direction);
                    this._parcelList.addTotalDepth(_loc_14);
                    this._verticalSpaceCarried = 0;
                }
                if (this._blockProgression == BlockProgression.RL)
                {
                    _loc_9 = _loc_3.getEffectivePaddingTop();
                    _loc_10 = _loc_3.getEffectivePaddingBottom();
                    _loc_11 = _loc_3.getEffectivePaddingRight();
                    _loc_12 = _loc_3.getEffectivePaddingLeft();
                }
                else
                {
                    _loc_9 = _loc_3.getEffectivePaddingLeft();
                    _loc_10 = _loc_3.getEffectivePaddingRight();
                    _loc_11 = _loc_3.getEffectivePaddingTop();
                    _loc_12 = _loc_3.getEffectivePaddingBottom();
                }
                this._parcelList.pushLeftMargin(_loc_9);
                this._parcelList.pushRightMargin(_loc_10);
                if (_loc_7 && _loc_11 > this._verticalSpaceCarried)
                {
                    this._parcelList.addTotalDepth(_loc_11 - this._verticalSpaceCarried);
                }
                this._verticalSpaceCarried = Math.max(_loc_11, 0);
                _loc_13 = _loc_3 as ParagraphElement;
                if (_loc_13)
                {
                    if (!this._atColumnStart && _loc_13.computedFormat.columnBreakBefore == BreakStyle.ALWAYS)
                    {
                        this.advanceToNextParcel();
                    }
                    if (!(this._atColumnStart && this._parcelList.currentParcel != null && this._parcelList.currentParcel.columnIndex == 0) && _loc_13.computedFormat.containerBreakBefore == BreakStyle.ALWAYS)
                    {
                        this.advanceToNextContainer();
                    }
                    if (!this.composeParagraphElement(_loc_13, param2))
                    {
                        return false;
                    }
                    if (!(this._atColumnStart && this._parcelList.currentParcel != null && this._parcelList.currentParcel.columnIndex == 0) && _loc_13.computedFormat.containerBreakAfter == BreakStyle.ALWAYS)
                    {
                        this.advanceToNextContainer();
                    }
                    if (!this._atColumnStart && _loc_13.computedFormat.columnBreakAfter == BreakStyle.ALWAYS)
                    {
                        this.advanceToNextParcel();
                    }
                }
                else if (_loc_3 is ListElement)
                {
                    _loc_4 = this.composeBlockElement(FlowGroupElement(_loc_3), param2);
                    if (!_loc_4)
                    {
                        return false;
                    }
                }
                else if (_loc_3 is ListItemElement)
                {
                    _loc_15 = this._listItemElement;
                    this._listItemElement = _loc_3 as ListItemElement;
                    _loc_4 = this.composeBlockElement(FlowGroupElement(_loc_3), param2);
                    this._listItemElement = _loc_15;
                    if (!_loc_4)
                    {
                        return false;
                    }
                }
                else if (!this.composeBlockElement(FlowGroupElement(_loc_3), param2))
                {
                    return false;
                }
                if (_loc_12 > this._verticalSpaceCarried)
                {
                    this._parcelList.addTotalDepth(_loc_12 - this._verticalSpaceCarried);
                }
                this._verticalSpaceCarried = Math.max(_loc_12, 0);
                this._parcelList.popLeftMargin(_loc_9);
                this._parcelList.popRightMargin(_loc_10);
                param2 = param2 + _loc_3.textLength;
                _loc_7 = true;
                _loc_5++;
            }
            return true;
        }// end function

        public function composeTextFlow(param1:TextFlow, param2:int, param3:int) : int
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            this._textFlow = param1;
            this._releaseLineCreationData = param1.configuration.releaseLineCreationData && Configuration.playerEnablesArgoFeatures;
            this._flowComposer = this._textFlow.flowComposer;
            this._rootElement = param1;
            this._curElementOffset = 0;
            this._curElement = this._rootElement.getFirstLeaf();
            this._curElementStart = 0;
            this._curParcel = null;
            this.initializeForComposer(this._flowComposer, param2, -1, param3);
            this.resetControllerBounds();
            this._curElement = this._textFlow.findLeaf(this._startComposePosition);
            this._curElementStart = this._curElement.getAbsoluteStart();
            this._curElementOffset = this._startComposePosition - this._curElementStart;
            var _loc_4:* = this._startController.interactiveObjects;
            var _loc_5:* = this._startController.oldInteractiveObjects;
            this._startController.oldInteractiveObjects.splice(0);
            for each (_loc_6 in _loc_4)
            {
                
                if (_loc_6 && (_loc_6 as FlowElement).getAbsoluteStart() >= this._startComposePosition)
                {
                    _loc_5.push(_loc_4[_loc_6]);
                    delete _loc_4[_loc_6];
                }
            }
            _loc_7 = this._flowComposer.getControllerIndex(this._startController) + 1;
            while (_loc_7 <= param3)
            {
                
                _loc_4 = this._flowComposer.getControllerAt(_loc_7).interactiveObjects;
                for each (_loc_6 in _loc_4)
                {
                    
                    if (_loc_6)
                    {
                        delete _loc_4[_loc_6];
                    }
                }
                _loc_7++;
            }
            if (this._startComposePosition <= this._startController.absoluteStart || !this.advanceToComposeStartPosition())
            {
                if (this._startComposePosition > this._startController.absoluteStart)
                {
                    this._startComposePosition = this._startController.absoluteStart;
                    this._curElement = this._textFlow.findLeaf(this._startComposePosition);
                    this._curElementStart = this._curElement.getAbsoluteStart();
                    this._curElementOffset = this._startComposePosition - this._curElementStart;
                }
                if (this._startComposePosition == this._curElement.getParagraph().getAbsoluteStart())
                {
                    this._previousLine = null;
                }
                else
                {
                    _loc_8 = this._flowComposer.findLineIndexAtPosition((this._startComposePosition - 1));
                    _loc_9 = this._flowComposer.getLineAt(_loc_8);
                    this._previousLine = _loc_9.getTextLine(true);
                }
                this.advanceToNextParcel();
                if (this._curParcel)
                {
                    this._curParcel.controller.clearFloatsAt(0);
                }
            }
            this._startController.clearComposedLines(this._curElementStart + this._curElementOffset);
            this._curParcelStart = this._startController.absoluteStart;
            this.composeInternal(this._rootElement, 0);
            while (true)
            {
                
                if (this.parcelList.atEnd())
                {
                    this.parcelHasChanged(null);
                    break;
                }
                this.advanceToNextParcel();
            }
            this.releaseParcelList(this._parcelList);
            this._parcelList = null;
            _savedLineSlug = this._lineSlug;
            return this._curElementStart + this._curElementOffset;
        }// end function

        private function advanceToComposeStartPosition() : Boolean
        {
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_1:* = this._flowComposer.findLineIndexAtPosition((this._startComposePosition - 1));
            var _loc_2:* = this._flowComposer.getLineAt(_loc_1);
            if (_loc_2.controller.numFloats)
            {
                if (this._measuring)
                {
                    return false;
                }
            }
            this._curLine = _loc_2;
            var _loc_3:* = this._curElementOffset == 0 ? (this._curElement.getPreviousLeaf()) : (this._curElement);
            this._curLineLeadingModel = _loc_3.getParagraph().getEffectiveLeadingModel();
            var _loc_4:* = this._textFlow.findLeaf(this._curLine.absoluteStart);
            var _loc_5:* = this._textFlow.findLeaf(this._curLine.absoluteStart).getAbsoluteStart();
            this.calculateLeadingParameters(_loc_4, _loc_5, TextFlowLine.findNumberLine(this._curLine.getTextLine()));
            if (this._startComposePosition == this._curElement.getParagraph().getAbsoluteStart())
            {
                this._previousLine = null;
            }
            else
            {
                this._previousLine = this._curLine.getTextLine(true);
            }
            this._paragraphSpaceCarried = this._curLine.spaceAfter;
            this.commitLastLineState(this._curLine);
            var _loc_6:* = this._curLine.columnIndex == -1 ? (0) : (this._curLine.columnIndex);
            this._curParcel = this._parcelList.currentParcel;
            var _loc_7:* = 0;
            var _loc_8:* = -1;
            while (_loc_8 < _loc_6)
            {
                
                this.advanceToNextParcel();
                this._curParcelStart = this._curParcel.controller.absoluteStart;
                _loc_10 = this._curParcel.controller.numFloats;
                if (_loc_10)
                {
                    while (_loc_7 < _loc_10)
                    {
                        
                        _loc_11 = this._curParcel.controller.getFloatAt(_loc_7);
                        if (_loc_11.columnIndex > this._curParcel.columnIndex)
                        {
                            break;
                        }
                        if (_loc_11.floatType != Float.NONE && _loc_11.absolutePosition < this._startComposePosition)
                        {
                            _loc_12 = this._textFlow.findLeaf(_loc_11.absolutePosition) as InlineGraphicElement;
                            _loc_13 = this._blockProgression == BlockProgression.RL ? (_loc_12.elementWidthWithMarginsAndPadding()) : (_loc_12.elementHeightWithMarginsAndPadding());
                            this._curParcel.knockOut(_loc_11.knockOutWidth, _loc_11.depth - this._lastLineDescent, _loc_11.depth + _loc_13, _loc_11.floatType == Float.LEFT);
                        }
                        _loc_7++;
                    }
                }
                this._curParcel.controller.clearFloatsAt(this._startComposePosition);
                _loc_8++;
            }
            this._curParcelStart = this._curElementStart + this._curElementOffset;
            if (this._blockProgression == BlockProgression.TB)
            {
                this._parcelList.addTotalDepth(this._curLine.y + this._curLine.ascent - this._curParcel.y);
            }
            else
            {
                this._parcelList.addTotalDepth(this._curParcel.right - this._curLine.x);
            }
            this._atColumnStart = false;
            var _loc_9:* = this._flowComposer.findLineIndexAtPosition(this._startController.absoluteStart);
            this.initializeContentBounds(_loc_9, _loc_1);
            return true;
        }// end function

        private function initializeContentBounds(param1:int, param2:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = -1;
            this._parcelLogicalTop = this.computeTextFlowLineMinimumLogicalTop(this._flowComposer.getLineAt(param1), null);
            if (this._measuring)
            {
                while (param1 <= param2)
                {
                    
                    _loc_4 = this._flowComposer.getLineAt(param1);
                    if (_loc_4.columnIndex != _loc_3)
                    {
                        _loc_3 = _loc_4.columnIndex;
                        this._contentLogicalExtent = 0;
                        this._contentCommittedExtent = 0;
                        this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
                    }
                    _loc_5 = _loc_4.lineExtent;
                    this._contentLogicalExtent = Math.max(this._contentLogicalExtent, _loc_5);
                    if (_loc_4.alignment == TextAlign.LEFT && !_loc_4.hasNumberLine)
                    {
                        this._contentCommittedExtent = Math.max(this._contentCommittedExtent, _loc_5);
                    }
                    else
                    {
                        _loc_7 = createAlignData(_loc_4);
                        _loc_7.textLine = _loc_4.getTextLine(true);
                        _loc_7.textAlign = _loc_4.alignment;
                        _loc_8 = _loc_4.paragraph.computedFormat;
                        _loc_7.rightSideGap = this.getRightSideGap(_loc_4, _loc_4.alignment != TextAlign.LEFT);
                        _loc_7.leftSideGap = this.getLeftSideGap(_loc_4);
                        _loc_7.textIndent = _loc_8.textIndent;
                        _loc_7.lineWidth = _loc_5 - (_loc_7.rightSideGap + _loc_7.leftSideGap);
                        if (!this._alignLines)
                        {
                            this._alignLines = [];
                        }
                        this._alignLines.push(_loc_7);
                    }
                    param1++;
                }
            }
            else
            {
                _loc_4 = this._flowComposer.getLineAt(param2);
                var _loc_9:* = _loc_4.accumulatedLineExtent;
                this._contentCommittedExtent = _loc_4.accumulatedLineExtent;
                this._contentLogicalExtent = _loc_9;
                this._accumulatedMinimumStart = _loc_4.accumulatedMinimumStart;
                if (this._parcelList.currentParcelIndex > 0 && this._parcelList.currentParcel.columnIndex > 0)
                {
                    if (this._blockProgression == BlockProgression.TB)
                    {
                        this._controllerBottom = this._curParcel.controller.compositionHeight;
                    }
                    else
                    {
                        this._controllerLeft = -this._curParcel.controller.compositionWidth;
                    }
                    if (this._textFlow.computedFormat.direction == Direction.RTL)
                    {
                        this._controllerRight = this._curParcel.controller.compositionWidth;
                    }
                }
            }
            return;
        }// end function

        function computeTextFlowLineMinimumLogicalTop(param1:TextFlowLine, param2:TextLine) : Number
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            if (param1.hasGraphicElement)
            {
                _loc_3 = param1.absoluteStart;
                _loc_4 = this._textFlow.findLeaf(_loc_3);
                _loc_5 = param1.getLineTypographicAscent(_loc_4, _loc_4.getAbsoluteStart(), param2);
                _loc_6 = this._blockProgression == BlockProgression.RL ? (param1.x + _loc_5) : (param1.y + param1.ascent - _loc_5);
                _loc_7 = param1.controller;
                _loc_8 = _loc_3 + param1.textLength;
                if (_loc_7.numFloats > 0)
                {
                    while (_loc_3 < _loc_8)
                    {
                        
                        _loc_9 = _loc_7.getFloatAtPosition(_loc_3);
                        if (_loc_9)
                        {
                            _loc_6 = Math.min(_loc_6, _loc_9.depth);
                            _loc_3 = _loc_9.absolutePosition + 1;
                            continue;
                        }
                        break;
                    }
                }
                return _loc_6;
            }
            return NaN;
        }// end function

        private function resetControllerBounds() : void
        {
            this._controllerLeft = TextLine.MAX_LINE_WIDTH;
            this._controllerTop = TextLine.MAX_LINE_WIDTH;
            this._controllerRight = -TextLine.MAX_LINE_WIDTH;
            this._controllerBottom = -TextLine.MAX_LINE_WIDTH;
            return;
        }// end function

        protected function get releaseLineCreationData() : Boolean
        {
            return this._releaseLineCreationData;
        }// end function

        protected function composeInternal(param1:FlowGroupElement, param2:int) : void
        {
            this.composeBlockElement(param1, param2);
            return;
        }// end function

        protected function composeParagraphElement(param1:ParagraphElement, param2:int) : Boolean
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._curParaElement = param1;
            this._curParaStart = param2;
            this._curParaFormat = param1.computedFormat;
            this._paragraphContainsVisibleLines = this._curElementStart + this._curElementOffset != this._curParaStart;
            var _loc_3:* = this.composeParagraphElementIntoLines();
            var _loc_4:* = true;
            if (!this._paragraphContainsVisibleLines)
            {
                _loc_5 = param1.getTextBlock();
                _loc_6 = _loc_5.lastLine;
                while (_loc_6 && _loc_4)
                {
                    
                    if (_loc_6.parent)
                    {
                        _loc_4 = false;
                    }
                    _loc_6 = _loc_6.previousLine;
                }
                if (_loc_4)
                {
                    _loc_6 = _loc_5.lastLine;
                    while (_loc_6)
                    {
                        
                        _loc_5.releaseLines(_loc_6, _loc_6);
                        _loc_6.userData = null;
                        TextLineRecycler.addLineForReuse(_loc_6);
                        if (this._textFlow.backgroundManager)
                        {
                            this._textFlow.backgroundManager.removeLineFromCache(_loc_6);
                        }
                        _loc_6 = _loc_5.lastLine;
                    }
                    param1.releaseTextBlock();
                }
            }
            if (this.releaseLineCreationData && !_loc_4)
            {
                param1.releaseLineCreationData();
            }
            return _loc_3;
        }// end function

        protected function getFirstIndentCharPos(param1:ParagraphElement) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = param1.getFirstLeaf();
            while (_loc_3 && _loc_3 is InlineGraphicElement && InlineGraphicElement(_loc_3).effectiveFloat != Float.NONE)
            {
                
                _loc_2 = _loc_2 + _loc_3.textLength;
                _loc_3 = _loc_3.getNextLeaf();
            }
            return _loc_2;
        }// end function

        protected function composeParagraphElementIntoLines() : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = false;
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_1:* = true;
            var _loc_5:* = 0;
            if (this._curParaFormat.direction == Direction.LTR)
            {
                _loc_3 = this._curParaFormat.paragraphStartIndent;
                _loc_4 = this._curParaFormat.paragraphEndIndent;
            }
            else
            {
                _loc_3 = this._curParaFormat.paragraphEndIndent;
                _loc_4 = this._curParaFormat.paragraphStartIndent;
            }
            this._parcelList.pushLeftMargin(_loc_3);
            this._parcelList.pushRightMargin(_loc_4);
            var _loc_6:* = this._curParaStart;
            if (this.preProcessILGs(this._curElementStart - this._curParaStart))
            {
                _loc_6 = this.getFirstIndentCharPos(this._curParaElement) + this._curParaStart;
            }
            while (_loc_1)
            {
                
                if (this._parcelList.atEnd())
                {
                    _loc_1 = false;
                    break;
                }
                this.startLine();
                if (!this._forceILGs)
                {
                    this.processFloatsAtLineStart();
                }
                this._textIndent = this._curElementStart + this._curElementOffset <= _loc_6 ? (this._curParaFormat.textIndent) : (0);
                if (this._parcelList.atEnd())
                {
                    _loc_1 = false;
                    break;
                }
                _loc_2 = this.composeNextLine();
                if (_loc_2 == null)
                {
                    _loc_1 = false;
                    break;
                }
                _loc_7 = this._curParaFormat.textAlign;
                if (_loc_7 == TextAlign.JUSTIFY)
                {
                    _loc_13 = this._curLine.location;
                    if (_loc_13 == TextFlowLineLocation.LAST || _loc_13 == TextFlowLineLocation.ONLY)
                    {
                        _loc_7 = this._curParaFormat.textAlignLast;
                    }
                }
                switch(_loc_7)
                {
                    case TextAlign.START:
                    {
                        _loc_7 = this._curParaFormat.direction == Direction.LTR ? (TextAlign.LEFT) : (TextAlign.RIGHT);
                        break;
                    }
                    case TextAlign.END:
                    {
                        _loc_7 = this._curParaFormat.direction == Direction.LTR ? (TextAlign.RIGHT) : (TextAlign.LEFT);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_8 = TextFlowLine.findNumberLine(_loc_2);
                _loc_9 = _loc_8 && TextFlowLine.getNumberLineListStylePosition(_loc_8) == ListStylePosition.OUTSIDE || _loc_7 == TextAlign.CENTER || _loc_7 == TextAlign.RIGHT;
                if (Configuration.playerEnablesArgoFeatures)
                {
                    if (_loc_2["hasTabs"])
                    {
                        if (this._curParaFormat.direction == Direction.LTR)
                        {
                            if (!_loc_8 || TextFlowLine.getNumberLineListStylePosition(_loc_8) == ListStylePosition.INSIDE)
                            {
                                _loc_9 = false;
                            }
                            _loc_7 = TextAlign.LEFT;
                        }
                        else
                        {
                            _loc_9 = true;
                            _loc_7 = TextAlign.RIGHT;
                        }
                    }
                }
                if (_loc_9)
                {
                    _loc_10 = createAlignData(this._curLine);
                    _loc_10.textLine = _loc_2;
                    _loc_10.textAlign = _loc_7;
                }
                _loc_11 = this._atColumnStart && this._curParaFormat.leadingModel != LeadingModel.BOX ? (0) : (this._curLine.spaceBefore);
                _loc_12 = this._atColumnStart ? (0) : (this._paragraphSpaceCarried);
                if (_loc_11 != 0 || _loc_12 != 0)
                {
                    this._parcelList.addTotalDepth(Math.max(_loc_11, _loc_12));
                }
                this._paragraphSpaceCarried = 0;
                if (this._verticalSpaceCarried != 0)
                {
                    this._verticalSpaceCarried = 0;
                }
                this._parcelList.addTotalDepth(this._curLine.height);
                _loc_10 = this.calculateLineAlignmentAndBounds(_loc_2, _loc_8, _loc_10);
                if (_loc_10)
                {
                    if (!this._alignLines)
                    {
                        this._alignLines = [];
                    }
                    this._alignLines.push(_loc_10);
                    this._curLine.alignment = _loc_7;
                }
                if (_loc_5 != 0)
                {
                    if (this._curParaFormat.direction == Direction.LTR)
                    {
                        this._parcelList.popLeftMargin(_loc_5);
                    }
                    else
                    {
                        this._parcelList.popRightMargin(_loc_5);
                    }
                    _loc_5 = 0;
                }
                if (!this.processFloatsAtLineEnd(_loc_2) || !this._curLine)
                {
                    this.resetLine(_loc_2);
                    continue;
                }
                this.endLine(_loc_2);
                this._lastGoodStart = -1;
                if (this.isLineVisible(_loc_2))
                {
                    this._curParcel.controller.addComposedLine(_loc_2);
                    this._paragraphContainsVisibleLines = true;
                }
                if (this._parcelList.atEnd())
                {
                    _loc_1 = false;
                    break;
                }
                this._previousLine = _loc_2;
                this._curElementOffset = this._curElementOffset + this._curLine.textLength;
                if (this._curElementOffset >= this._curElement.textLength)
                {
                    do
                    {
                        
                        if (this._curParaElement.hasInteractiveChildren())
                        {
                            _loc_14 = this._curElement;
                            while (_loc_14 && _loc_14 != this._curParaElement)
                            {
                                
                                if (_loc_14 is LinkElement)
                                {
                                    this._curInteractiveObjects[_loc_14] = _loc_14;
                                }
                                else if (_loc_14.hasActiveEventMirror())
                                {
                                    this._curInteractiveObjects[_loc_14] = _loc_14;
                                }
                                _loc_14 = _loc_14.parent;
                            }
                        }
                        this._curElementOffset = this._curElementOffset - this._curElement.textLength;
                        this._curElementStart = this._curElementStart + this._curElement.textLength;
                        this._curElement = this._curElement.getNextLeaf();
                        if (this._curElementStart == this._curParaStart + this._curParaElement.textLength)
                        {
                            break;
                        }
                    }while (this._curElementOffset >= this._curElement.textLength || this._curElement.textLength == 0)
                }
                this._paragraphSpaceCarried = this._curLine.spaceAfter;
                if (this._curElementStart == this._curParaStart + this._curParaElement.textLength)
                {
                    break;
                }
            }
            this._parcelList.popLeftMargin(_loc_3);
            this._parcelList.popRightMargin(_loc_4);
            if (_loc_5 != 0)
            {
                if (this._curParaFormat.direction == Direction.LTR)
                {
                    this._parcelList.popLeftMargin(_loc_5);
                }
                else
                {
                    this._parcelList.popRightMargin(_loc_5);
                }
                _loc_5 = 0;
            }
            this._previousLine = null;
            return _loc_1;
        }// end function

        protected function createTextLine(param1:Number, param2:Boolean) : TextLine
        {
            var _loc_3:* = this._curParaFormat.direction == Direction.LTR ? (this._lineSlug.leftMargin) : (this._lineSlug.rightMargin);
            var _loc_4:* = null;
            _loc_4 = TextLineRecycler.getLineForReuse();
            var _loc_5:* = this._curParaElement.getTextBlock();
            if (_loc_4)
            {
                _loc_4 = this.swfContext.callInContext(_loc_5["recreateTextLine"], _loc_5, [_loc_4, this._previousLine, param1, _loc_3, true]);
            }
            else
            {
                _loc_4 = this.swfContext.callInContext(_loc_5.createTextLine, _loc_5, [this._previousLine, param1, _loc_3, true]);
            }
            if (!param2 && _loc_5.textLineCreationResult == TextLineCreationResult.EMERGENCY)
            {
                _loc_4 = null;
            }
            if (_loc_4 == null)
            {
                return null;
            }
            this._curLine.initialize(this._curParaElement, param1, _loc_3 - this._parcelList.insideListItemMargin, _loc_4.textBlockBeginIndex + this._curParaStart, _loc_4.rawTextLength, _loc_4);
            return _loc_4;
        }// end function

        protected function startLine() : void
        {
            this._workingContentExtent = 0;
            this._workingContentHeight = 0;
            this._workingContentLogicalExtent = 0;
            this._workingParcelIndex = this._parcelList.currentParcelIndex;
            this._workingTotalDepth = this.parcelList.totalDepth;
            this._workingParcelLogicalTop = NaN;
            return;
        }// end function

        protected function isLineVisible(param1:TextLine) : Boolean
        {
            return this._curParcel.controller.testLineVisible(this._blockProgression, this._controllerVisibleBoundsXTW, this._controllerVisibleBoundsYTW, this._controllerVisibleBoundsWidthTW, this._controllerVisibleBoundsHeightTW, this._curLine, param1) is TextLine;
        }// end function

        protected function endLine(param1:TextLine) : void
        {
            this._contentCommittedExtent = Math.max(this._contentCommittedExtent, this._workingContentExtent);
            this._contentCommittedHeight = Math.max(this._contentCommittedHeight, this._workingContentHeight);
            this._contentLogicalExtent = Math.max(this._contentLogicalExtent, this._workingContentLogicalExtent);
            if (!this._measuring)
            {
                this._contentLogicalExtent = this._contentCommittedExtent;
            }
            if (this._pushInFloats)
            {
                this._pushInFloats.length = 0;
            }
            this._atColumnStart = false;
            this._linePass = 0;
            if (!isNaN(this._workingParcelLogicalTop))
            {
                this._parcelLogicalTop = this._workingParcelLogicalTop;
            }
            return;
        }// end function

        protected function resetLine(param1:TextLine) : void
        {
            if (this._textFlow.backgroundManager)
            {
                this._textFlow.backgroundManager.removeLineFromCache(param1);
            }
            if (this._workingParcelIndex != this.parcelList.currentParcelIndex)
            {
                this._linePass = 0;
                if (this._pushInFloats)
                {
                    this._pushInFloats.length = 0;
                }
            }
            else
            {
                var _loc_2:* = this;
                var _loc_3:* = this._linePass + 1;
                _loc_2._linePass = _loc_3;
            }
            this.parcelList.addTotalDepth(this._workingTotalDepth - this._parcelList.totalDepth);
            this._workingTotalDepth = this.parcelList.totalDepth;
            return;
        }// end function

        protected function preProcessILGs(param1:int) : Boolean
        {
            var _loc_5:* = null;
            if (!this._curParcel)
            {
                return false;
            }
            var _loc_2:* = false;
            var _loc_3:* = this._blockProgression == BlockProgression.RL;
            this._forceILGs = this._parcelList.explicitLineBreaks || _loc_3 && this._curParcel.controller.measureHeight || !_loc_3 && this._curParcel.controller.measureWidth;
            var _loc_4:* = this._curParaElement.findLeaf(param1);
            while (_loc_4)
            {
                
                if (_loc_4 is InlineGraphicElement)
                {
                    _loc_5 = _loc_4 as InlineGraphicElement;
                    _loc_5.setEffectiveFloat(this._forceILGs ? (Float.NONE) : (_loc_5.computedFloat));
                    _loc_2 = true;
                }
                _loc_4 = _loc_4.getNextLeaf(this._curParaElement);
            }
            return _loc_2;
        }// end function

        protected function processFloatsAtLineStart() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this._forceILGs)
            {
                return;
            }
            if (this._pushInFloats && this._pushInFloats.length > 0)
            {
                _loc_1 = 0;
                while (_loc_1 < this._pushInFloats.length)
                {
                    
                    _loc_2 = this._pushInFloats[_loc_1];
                    _loc_3 = this._textFlow.findLeaf(_loc_2);
                    if (!this.composeFloat(_loc_3 as InlineGraphicElement, false))
                    {
                        this._pushInFloats.length = _loc_1;
                    }
                    _loc_1++;
                }
            }
            return;
        }// end function

        protected function processFloatsAtLineEnd(param1:TextLine) : Boolean
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = null;
            if (!param1.hasGraphicElement && this._linePass <= 0)
            {
                return true;
            }
            if (this._pushInFloats && this._pushInFloats.length > 0)
            {
                _loc_8 = this._pushInFloats[(this._pushInFloats.length - 1)];
                if (this._curLine.absoluteStart + this._curLine.textLength <= _loc_8)
                {
                    _loc_9 = this._pushInFloats.length - 1;
                    while (_loc_9 >= 0)
                    {
                        
                        _loc_8 = this._pushInFloats[_loc_9];
                        _loc_10 = this._textFlow.findLeaf(_loc_8) as InlineGraphicElement;
                        _loc_11 = this._blockProgression == BlockProgression.RL ? (_loc_10.elementWidth + _loc_10.getEffectivePaddingLeft() + _loc_10.getEffectivePaddingRight()) : (_loc_10.elementHeightWithMarginsAndPadding());
                        _loc_12 = this._curLine.controller.getFloatAtPosition(_loc_8);
                        if (_loc_12 && _loc_12.absolutePosition == _loc_8)
                        {
                            _loc_13 = isNaN(this._lastLineDescent) ? (0) : (this._lastLineDescent);
                            this._curParcel.removeKnockOut(_loc_12.knockOutWidth, _loc_12.depth - _loc_13, _loc_12.depth + _loc_11, _loc_12.floatType == Float.LEFT);
                        }
                        _loc_9 = _loc_9 - 1;
                    }
                    this._curLine.controller.clearFloatsAt(this._pushInFloats[0]);
                    var _loc_15:* = this._pushInFloats;
                    var _loc_16:* = this._pushInFloats.length - 1;
                    _loc_15.length = _loc_16;
                    return false;
                }
            }
            var _loc_2:* = this._curElementStart;
            var _loc_3:* = this._curElement;
            var _loc_4:* = this._curLine.absoluteStart + this._curLine.textLength;
            var _loc_5:* = 0;
            var _loc_6:* = false;
            while (_loc_2 < _loc_4)
            {
                
                if (_loc_3 is InlineGraphicElement)
                {
                    _loc_14 = InlineGraphicElement(_loc_3);
                    if (_loc_14.computedFloat == Float.NONE || this._forceILGs)
                    {
                        _loc_6 = true;
                    }
                    else if (this._linePass == 0)
                    {
                        if (!this._pushInFloats)
                        {
                            this._pushInFloats = [];
                        }
                        this._pushInFloats.push(_loc_2);
                    }
                    else if (this._pushInFloats.indexOf(_loc_2) >= 0)
                    {
                        _loc_5++;
                    }
                    else if (!this.composeFloat(_loc_14, true))
                    {
                        this.advanceToNextParcel();
                        return false;
                    }
                }
                _loc_2 = _loc_2 + _loc_3.textLength;
                _loc_3 = _loc_3.getNextLeaf();
            }
            var _loc_7:* = _loc_5 >= (this._pushInFloats ? (this._pushInFloats.length) : (0));
            if (_loc_5 >= (this._pushInFloats ? (this._pushInFloats.length) : (0)) && _loc_6)
            {
                this.processInlinesAtLineEnd(param1);
            }
            return _loc_7;
        }// end function

        protected function processInlinesAtLineEnd(param1:TextLine) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = this._curElementStart;
            var _loc_3:* = this._curElement;
            var _loc_4:* = this._curLine.absoluteStart + this._curLine.textLength;
            while (_loc_2 < _loc_4)
            {
                
                if (_loc_3 is InlineGraphicElement)
                {
                    _loc_5 = _loc_3 as InlineGraphicElement;
                    if (_loc_5.computedFloat == Float.NONE || this._forceILGs)
                    {
                        this.composeInlineGraphicElement(_loc_5, param1);
                    }
                }
                _loc_2 = _loc_2 + _loc_3.textLength;
                _loc_3 = _loc_3.getNextLeaf();
            }
            return;
        }// end function

        protected function composeInlineGraphicElement(param1:InlineGraphicElement, param2:TextLine) : Boolean
        {
            var _loc_6:* = null;
            var _loc_3:* = this._blockProgression == BlockProgression.RL ? (-param1.getEffectivePaddingRight()) : (param1.getEffectivePaddingLeft());
            var _loc_4:* = param1.getEffectivePaddingTop();
            var _loc_5:* = param1.placeholderGraphic.parent;
            this._curParcel.controller.addFloatAt(this._curParaStart + param1.getElementRelativeStart(this._curParaElement), param1.graphic, Float.NONE, _loc_3, _loc_4, _loc_5 ? (_loc_5.alpha) : (1), _loc_5 ? (_loc_5.transform.matrix) : (null), this._parcelList.totalDepth, 0, this._curParcel.columnIndex, param2);
            if (this._curParaElement.hasInteractiveChildren())
            {
                _loc_6 = param1;
                while (_loc_6 && _loc_6 != this._curParaElement)
                {
                    
                    if (_loc_6 is LinkElement)
                    {
                        this._curInteractiveObjects[_loc_6] = _loc_6;
                    }
                    else if (_loc_6.hasActiveEventMirror())
                    {
                        this._curInteractiveObjects[_loc_6] = _loc_6;
                    }
                    _loc_6 = _loc_6.parent;
                }
            }
            return true;
        }// end function

        protected function composeFloat(param1:InlineGraphicElement, param2:Boolean) : Boolean
        {
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            if (param1.elementHeight == 0 || param1.elementWidth == 0)
            {
                return true;
            }
            if (this._lastGoodStart == -1)
            {
                this._lastGoodStart = this._curElementStart + this._curElementOffset;
            }
            var _loc_3:* = this._blockProgression == BlockProgression.RL;
            var _loc_4:* = 0;
            if ((param2 || !this._atColumnStart) && !isNaN(this._lastLineDescent))
            {
                _loc_4 = this._lastLineDescent;
            }
            var _loc_5:* = 0;
            if (this._curLine && this._curParaElement != this._curLine.paragraph && !this._atColumnStart)
            {
                _loc_5 = Math.max(this._curParaElement.computedFormat.paragraphSpaceBefore, this._paragraphSpaceCarried);
            }
            var _loc_6:* = this._parcelList.totalDepth + _loc_5 + _loc_4;
            if (!_floatSlug)
            {
                _floatSlug = new Slug();
            }
            if (_loc_3)
            {
                _loc_7 = param1.elementHeight + param1.getEffectivePaddingTop() + param1.getEffectivePaddingBottom();
                _loc_8 = param1.elementWidth + param1.getEffectivePaddingLeft() + param1.getEffectivePaddingRight();
            }
            else
            {
                _loc_7 = param1.elementWidthWithMarginsAndPadding();
                _loc_8 = param1.elementHeightWithMarginsAndPadding();
            }
            var _loc_9:* = param1.getAbsoluteStart();
            var _loc_10:* = this._parcelList.fitFloat(_floatSlug, _loc_6, _loc_7, _loc_8);
            if (!this._parcelList.fitFloat(_floatSlug, _loc_6, _loc_7, _loc_8) && (this._curParcel.fitAny || this._curParcel.fitsInHeight(_loc_6, int(_loc_8))) && (!this._curLine || this._curLine.absoluteStart == _loc_9 || param2))
            {
                _loc_10 = true;
            }
            if (_loc_10)
            {
                _loc_11 = param1.computedFloat;
                if (_loc_11 == Float.START)
                {
                    _loc_11 = this._curParaFormat.direction == Direction.LTR ? (Float.LEFT) : (Float.RIGHT);
                }
                else if (_loc_11 == Float.END)
                {
                    _loc_11 = this._curParaFormat.direction == Direction.LTR ? (Float.RIGHT) : (Float.LEFT);
                }
                _loc_12 = this.calculateFloatBounds(param1, _loc_3, _loc_11);
                if (_loc_3)
                {
                    this._workingContentExtent = Math.max(this._workingContentExtent, _loc_12.bottom + param1.getEffectivePaddingLeft() + param1.getEffectivePaddingRight());
                    this._workingContentHeight = Math.max(this._workingContentHeight, _floatSlug.depth + _loc_12.width + param1.getEffectivePaddingTop() + param1.getEffectivePaddingBottom());
                    this._workingContentLogicalExtent = Math.max(this._workingContentLogicalExtent, _loc_12.bottom);
                    this._accumulatedMinimumStart = Math.min(this._accumulatedMinimumStart, _loc_12.y);
                }
                else
                {
                    this._workingContentExtent = Math.max(this._workingContentExtent, _loc_12.right + param1.getEffectivePaddingLeft() + param1.getEffectivePaddingRight());
                    this._workingContentHeight = Math.max(this._workingContentHeight, _floatSlug.depth + _loc_12.height + param1.getEffectivePaddingTop() + param1.getEffectivePaddingBottom());
                    this._workingContentLogicalExtent = Math.max(this._workingContentLogicalExtent, _loc_12.right);
                    this._accumulatedMinimumStart = Math.min(this._accumulatedMinimumStart, _loc_12.x);
                }
                if (_loc_9 == this._curParcelStart)
                {
                    this._workingParcelLogicalTop = _floatSlug.depth;
                }
                _loc_13 = (_loc_11 == Float.LEFT ? (_floatSlug.leftMargin) : (_floatSlug.rightMargin)) + _loc_7;
                _loc_14 = isNaN(this._lastLineDescent) ? (0) : (this._lastLineDescent);
                this._curParcel.knockOut(_loc_13, _floatSlug.depth - _loc_14, _floatSlug.depth + _loc_8, _loc_11 == Float.LEFT);
                this._curParcel.controller.addFloatAt(_loc_9, param1.graphic, _loc_11, _loc_12.x, _loc_12.y, param1.computedFormat.textAlpha, null, _floatSlug.depth, _loc_13, this._curParcel.columnIndex, this._curParcel.controller.container);
            }
            return _loc_10;
        }// end function

        private function calculateFloatBounds(param1:InlineGraphicElement, param2:Boolean, param3:String) : Rectangle
        {
            var _loc_4:* = new Rectangle();
            if (param2)
            {
                _loc_4.x = this._curParcel.right - _floatSlug.depth - param1.elementWidth - param1.getEffectivePaddingRight();
                _loc_4.y = param3 == Float.LEFT ? (this._curParcel.y + _floatSlug.leftMargin + param1.getEffectivePaddingTop()) : (this._curParcel.bottom - _floatSlug.rightMargin - param1.getEffectivePaddingBottom() - param1.elementHeight);
                _loc_4.width = param1.elementWidth;
                _loc_4.height = param1.elementHeight;
            }
            else
            {
                _loc_4.x = param3 == Float.LEFT ? (this._curParcel.x + _floatSlug.leftMargin + param1.getEffectivePaddingLeft()) : (this._curParcel.right - _floatSlug.rightMargin - param1.getEffectivePaddingRight() - param1.elementWidth);
                _loc_4.y = this._curParcel.y + _floatSlug.depth + param1.getEffectivePaddingTop();
                _loc_4.width = param1.elementWidth;
                _loc_4.height = param1.elementHeight;
            }
            return _loc_4;
        }// end function

        private function calculateLineWidthExplicit(param1:TextLine) : Number
        {
            var _loc_2:* = this._curParaElement.computedFormat.direction == Direction.RTL;
            var _loc_3:* = param1.atomCount - 1;
            var _loc_4:* = this._curLine.absoluteStart + this._curLine.textLength == this._curParaStart + this._curParaElement.textLength;
            if (this._curLine.absoluteStart + this._curLine.textLength == this._curParaStart + this._curParaElement.textLength && !_loc_2)
            {
                _loc_3 = _loc_3 - 1;
            }
            var _loc_5:* = param1.getAtomBounds(_loc_3 >= 0 ? (_loc_3) : (0));
            var _loc_6:* = this._blockProgression == BlockProgression.TB ? (_loc_3 >= 0 ? (_loc_5.right) : (_loc_5.left)) : (_loc_3 >= 0 ? (_loc_5.bottom) : (_loc_5.top));
            if (_loc_2)
            {
                _loc_5 = param1.getAtomBounds(_loc_3 != 0 && _loc_4 ? (1) : (0));
                _loc_6 = _loc_6 - (this._blockProgression == BlockProgression.TB ? (_loc_5.left) : (_loc_5.top));
            }
            param1.flushAtomData();
            return _loc_6;
        }// end function

        private function getRightSideGap(param1:TextFlowLine, param2:Boolean) : Number
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = param1.paragraph;
            var _loc_4:* = _loc_3.computedFormat;
            var _loc_5:* = _loc_3.computedFormat.direction == Direction.RTL ? (_loc_4.paragraphStartIndent) : (_loc_4.paragraphEndIndent);
            if (_loc_4.direction == Direction.RTL && param1.location & TextFlowLineLocation.FIRST)
            {
                _loc_5 = _loc_5 + _loc_4.textIndent;
                if (param1.hasNumberLine && _loc_3.getParentByType(ListItemElement).computedFormat.listStylePosition == ListStylePosition.INSIDE)
                {
                    _loc_6 = param1.getTextLine(true);
                    _loc_7 = TextFlowLine.findNumberLine(_loc_6);
                    _loc_5 = _loc_5 + TextFlowLine.getNumberLineInsideLineWidth(_loc_7);
                }
            }
            do
            {
                
                _loc_5 = _loc_5 + (this._blockProgression == BlockProgression.TB ? (_loc_3.getEffectivePaddingRight()) : (_loc_3.getEffectivePaddingBottom()));
                _loc_3 = _loc_3.parent;
            }while (!(_loc_3 is TextFlow))
            return _loc_5;
        }// end function

        private function getLeftSideGap(param1:TextFlowLine) : Number
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = param1.paragraph;
            var _loc_3:* = _loc_2.computedFormat;
            var _loc_4:* = _loc_3.direction == Direction.LTR ? (_loc_3.paragraphStartIndent) : (_loc_3.paragraphEndIndent);
            if (_loc_3.direction == Direction.LTR && param1.location & TextFlowLineLocation.FIRST)
            {
                _loc_4 = _loc_4 + _loc_3.textIndent;
                if (param1.hasNumberLine && _loc_2.getParentByType(ListItemElement).computedFormat.listStylePosition == ListStylePosition.INSIDE)
                {
                    _loc_5 = param1.getTextLine(true);
                    _loc_6 = TextFlowLine.findNumberLine(_loc_5);
                    _loc_4 = _loc_4 + TextFlowLine.getNumberLineInsideLineWidth(_loc_6);
                }
            }
            do
            {
                
                _loc_4 = _loc_4 + (this._blockProgression == BlockProgression.TB ? (_loc_2.getEffectivePaddingLeft()) : (_loc_2.getEffectivePaddingTop()));
                _loc_2 = _loc_2.parent;
            }while (!(_loc_2 is TextFlow))
            return _loc_4;
        }// end function

        private function calculateLineAlignmentAndBounds(param1:TextLine, param2:TextLine, param3:AlignData) : AlignData
        {
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_4:* = param1.textWidth;
            if (GlobalSettings.alwaysCalculateWhitespaceBounds || this._parcelList.explicitLineBreaks)
            {
                _loc_4 = this.calculateLineWidthExplicit(param1);
            }
            var _loc_5:* = this._lineSlug.rightMargin;
            var _loc_6:* = this._lineSlug.leftMargin;
            var _loc_7:* = 0;
            if (param3)
            {
                param3.rightSideGap = _loc_5;
                param3.leftSideGap = _loc_6;
                param3.lineWidth = _loc_4;
                param3.textIndent = this._curParaFormat.textIndent;
                if (this._blockProgression == BlockProgression.TB)
                {
                    if (!this._measuring)
                    {
                        _loc_12 = param1.textWidth;
                        _loc_9 = this._curParcel.width - _loc_6 - _loc_5 - _loc_12;
                        if (param3.textAlign != TextAlign.LEFT)
                        {
                            _loc_7 = param3.textAlign == TextAlign.CENTER ? (_loc_9 / 2) : (_loc_9);
                            _loc_10 = this._curParcel.x + _loc_6 + _loc_7;
                        }
                        else
                        {
                            _loc_10 = this._curParcel.x + _loc_6 + _loc_9;
                        }
                        if (param3.textAlign != TextAlign.LEFT)
                        {
                            this._curLine.x = _loc_10;
                            param1.x = _loc_10;
                        }
                        else
                        {
                            param1.x = this._curLine.x;
                        }
                        if (param2 && TextFlowLine.getNumberLineListStylePosition(param2) == ListStylePosition.OUTSIDE)
                        {
                            param2.x = computeNumberLineAlignment(param3, param1.textWidth, param1.x, param2, _loc_10, _loc_7, _loc_9);
                            this._curLine.numberLinePosition = param2.x;
                        }
                        releaseAlignData(param3);
                        param3 = null;
                    }
                }
                else if (!this._measuring)
                {
                    _loc_9 = this._curParcel.height - _loc_6 - _loc_5 - param1.textWidth;
                    if (param3.textAlign != TextAlign.LEFT)
                    {
                        _loc_7 = param3.textAlign == TextAlign.CENTER ? (_loc_9 / 2) : (_loc_9);
                        _loc_10 = this._curParcel.y + _loc_6 + _loc_7;
                    }
                    else
                    {
                        _loc_10 = this._curParcel.y + _loc_6 + _loc_9;
                    }
                    if (param3.textAlign != TextAlign.LEFT)
                    {
                        this._curLine.y = _loc_10;
                        param1.y = _loc_10;
                    }
                    else
                    {
                        param1.y = this._curLine.y;
                    }
                    if (param2 && TextFlowLine.getNumberLineListStylePosition(param2) == ListStylePosition.OUTSIDE)
                    {
                        param2.y = computeNumberLineAlignment(param3, param1.textWidth, param1.y, param2, _loc_10, _loc_7, _loc_9);
                        this._curLine.numberLinePosition = param2.y;
                    }
                    releaseAlignData(param3);
                    param3 = null;
                }
            }
            var _loc_8:* = _loc_4 + _loc_6 + _loc_5 + _loc_7;
            this._curLine.lineExtent = _loc_8;
            this._workingContentLogicalExtent = Math.max(this._workingContentLogicalExtent, _loc_8);
            this._curLine.accumulatedLineExtent = Math.max(this._contentLogicalExtent, this._workingContentLogicalExtent);
            if (!param3)
            {
                _loc_13 = this._curParaFormat.direction == Direction.LTR ? (Math.max(this._curLine.lineOffset, 0)) : (this._curParaFormat.paragraphEndIndent);
                _loc_13 = this._blockProgression == BlockProgression.RL ? (this._curLine.y - _loc_13) : (this._curLine.x - _loc_13);
                if (param2)
                {
                    _loc_14 = this._blockProgression == BlockProgression.TB ? (param2.x + this._curLine.x) : (param2.y + this._curLine.y);
                    _loc_13 = Math.min(_loc_13, _loc_14);
                    if (TextFlowLine.getNumberLineListStylePosition(param2) == ListStylePosition.OUTSIDE)
                    {
                        _loc_15 = _loc_14 + TextFlowLine.getNumberLineInsideLineWidth(param2);
                        _loc_15 = _loc_15 - _loc_8;
                        if (_loc_15 > 0)
                        {
                            _loc_7 = _loc_7 + _loc_15;
                        }
                    }
                }
                this._workingContentExtent = Math.max(this._workingContentExtent, _loc_4 + _loc_6 + Math.max(0, _loc_5) + _loc_7);
                var _loc_16:* = Math.min(this._accumulatedMinimumStart, _loc_13);
                this._accumulatedMinimumStart = Math.min(this._accumulatedMinimumStart, _loc_13);
                this._curLine.accumulatedMinimumStart = _loc_16;
            }
            if (this._curLine.absoluteStart == this._curParcelStart && isNaN(this._workingParcelLogicalTop))
            {
                this._workingParcelLogicalTop = this.computeTextFlowLineMinimumLogicalTop(this._curLine, param1);
            }
            return param3;
        }// end function

        protected function composeNextLine() : TextLine
        {
            return null;
        }// end function

        protected function fitLineToParcel(param1:TextLine, param2:Boolean, param3:TextLine) : Boolean
        {
            var _loc_4:* = this._lineSlug.depth;
            this._curLine.setController(this._curParcel.controller, this._curParcel.columnIndex);
            var _loc_5:* = Math.max(this._curLine.spaceBefore, this._paragraphSpaceCarried);
            while (true)
            {
                
                this.finishComposeLine(param1, param3);
                if (this._parcelList.getLineSlug(this._lineSlug, _loc_5 + (this._parcelList.atLast() && this._textFlow.configuration.overflowPolicy != OverflowPolicy.FIT_DESCENDERS ? (this._curLine.height - this._curLine.ascent) : (this._curLine.height + this._curLine.descent)), 1, this._textIndent, this._curParaFormat.direction == Direction.LTR))
                {
                    if (Twips.to(this._lineSlug.width) == this._curLine.outerTargetWidthTW && this._lineSlug.depth != _loc_4)
                    {
                        this.finishComposeLine(param1, param3);
                    }
                    break;
                }
                _loc_5 = this._curLine.spaceBefore;
                if (this._pushInFloats && this._parcelList.currentParcel.fitAny && this._pushInFloats.length > 0)
                {
                    break;
                }
                while (true)
                {
                    
                    this.advanceToNextParcel();
                    if (!this._curLine || this._parcelList.atEnd())
                    {
                        return false;
                    }
                    if (this._parcelList.getLineSlug(this._lineSlug, 0, 1, this._textIndent, this._curParaFormat.direction == Direction.LTR))
                    {
                        _loc_4 = this._lineSlug.depth;
                        break;
                    }
                }
                this._curLine.setController(this._curParcel.controller, this._curParcel.columnIndex);
            }
            if (Twips.to(this._lineSlug.width) != this._curLine.outerTargetWidthTW)
            {
                return false;
            }
            if (param2)
            {
                if (param3)
                {
                    TextFlowLine.initializeNumberLinePosition(param3, this._listItemElement, this._curParaElement, param1.textWidth);
                }
                this._curLine.createAdornments(this._blockProgression, this._curElement, this._curElementStart, param1, param3);
            }
            return true;
        }// end function

        protected function calculateLeadingParameters(param1:FlowLeafElement, param2:int, param3:TextLine = null) : Number
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param3)
            {
                _loc_4 = TextFlowLine.getNumberLineSpanFormat(param3);
            }
            if (this._curLineLeadingModel == LeadingModel.BOX)
            {
                _loc_5 = this._curLine.getCSSLineBox(this._blockProgression, param1, param2, this._textFlow.flowComposer.swfContext, _loc_4, param3);
                this._curLineLeading = _loc_5 ? (_loc_5.bottom) : (0);
                return _loc_5 ? (-_loc_5.top) : (0);
            }
            this._curLineLeading = this._curLine.getLineLeading(this._blockProgression, param1, param2);
            if (_loc_4)
            {
                this._curLineLeading = Math.max(this._curLineLeading, TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(_loc_4.lineHeight, _loc_4.fontSize));
            }
            return 0;
        }// end function

        protected function finishComposeLine(param1:TextLine, param2:TextLine) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = false;
            var _loc_15:* = false;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = NaN;
            var _loc_3:* = 0;
            if (this._blockProgression == BlockProgression.RL)
            {
                _loc_4 = this._curParcel.x + this._curParcel.width - this._lineSlug.depth;
                _loc_5 = this._curParcel.y;
            }
            else
            {
                _loc_4 = this._curParcel.y + this._lineSlug.depth;
                _loc_5 = this._curParcel.x;
            }
            _loc_5 = _loc_5 + this._lineSlug.leftMargin;
            this._curLineLeadingModel = this._curParaElement.getEffectiveLeadingModel();
            var _loc_6:* = this.calculateLeadingParameters(this._curElement, this._curElementStart, param2);
            if (this._curLineLeadingModel == LeadingModel.BOX)
            {
                _loc_3 = _loc_3 + (this._atColumnStart ? (0) : (this._lastLineDescent));
                _loc_3 = _loc_3 + _loc_6;
            }
            else
            {
                _loc_9 = this._curParcel.controller.computedFormat;
                _loc_10 = BaselineOffset.LINE_HEIGHT;
                if (this._atColumnStart)
                {
                    if (_loc_9.firstBaselineOffset != BaselineOffset.AUTO && _loc_9.verticalAlign != VerticalAlign.BOTTOM && _loc_9.verticalAlign != VerticalAlign.MIDDLE)
                    {
                        _loc_10 = _loc_9.firstBaselineOffset;
                        _loc_11 = LocaleUtil.leadingModel(_loc_9.locale) == LeadingModel.IDEOGRAPHIC_TOP_DOWN ? (TextBaseline.IDEOGRAPHIC_BOTTOM) : (TextBaseline.ROMAN);
                        _loc_3 = _loc_3 - param1.getBaselinePosition(_loc_11);
                    }
                    else if (this._curLineLeadingModel == LeadingModel.APPROXIMATE_TEXT_FIELD)
                    {
                        _loc_3 = _loc_3 + (Math.round(param1.descent) + Math.round(param1.ascent));
                        if (this._blockProgression == BlockProgression.TB)
                        {
                            _loc_3 = Math.round(_loc_4 + _loc_3) - _loc_4;
                        }
                        else
                        {
                            _loc_3 = _loc_4 - Math.round(_loc_4 - _loc_3);
                        }
                        _loc_10 = 0;
                    }
                    else
                    {
                        _loc_10 = BaselineOffset.ASCENT;
                        if (param1.hasGraphicElement)
                        {
                            _loc_12 = this.getLineAdjustmentForInline(param1, this._curLineLeadingModel, true);
                            if (_loc_12 != null)
                            {
                                if (this._blockProgression == BlockProgression.RL)
                                {
                                    _loc_12.rise = -_loc_12.rise;
                                }
                                this._curLineLeading = this._curLineLeading + _loc_12.leading;
                                _loc_4 = _loc_4 + _loc_12.rise;
                            }
                        }
                        _loc_3 = _loc_3 - param1.getBaselinePosition(TextBaseline.ROMAN);
                    }
                }
                if (_loc_10 == BaselineOffset.ASCENT)
                {
                    _loc_13 = this._curLine.getLineTypographicAscent(this._curElement, this._curElementStart, param1);
                    if (param2)
                    {
                        _loc_3 = _loc_3 + Math.max(_loc_13, TextFlowLine.getTextLineTypographicAscent(param2, null, 0, 0));
                    }
                    else
                    {
                        _loc_3 = _loc_3 + _loc_13;
                    }
                }
                else if (_loc_10 == BaselineOffset.LINE_HEIGHT)
                {
                    if (this._curLineLeadingModel == LeadingModel.APPROXIMATE_TEXT_FIELD)
                    {
                        _loc_3 = _loc_3 + (Math.round(this._lastLineDescent) + Math.round(param1.ascent) + Math.round(param1.descent) + Math.round(this._curLineLeading));
                    }
                    else if (this._curLineLeadingModel == LeadingModel.ASCENT_DESCENT_UP)
                    {
                        _loc_3 = _loc_3 + (this._lastLineDescent + param1.ascent + this._curLineLeading);
                    }
                    else
                    {
                        _loc_14 = this._atColumnStart ? (true) : (ParagraphElement.useUpLeadingDirection(this._curLineLeadingModel));
                        _loc_15 = this._atColumnStart || this._lastLineLeadingModel == "" ? (true) : (ParagraphElement.useUpLeadingDirection(this._lastLineLeadingModel));
                        if (_loc_14)
                        {
                            _loc_3 = _loc_3 + this._curLineLeading;
                        }
                        else if (!_loc_15)
                        {
                            _loc_3 = _loc_3 + this._lastLineLeading;
                        }
                        else
                        {
                            _loc_3 = _loc_3 + (this._lastLineDescent + param1.ascent);
                        }
                    }
                }
                else
                {
                    _loc_3 = _loc_3 + Number(_loc_10);
                }
                if (param1.hasGraphicElement && _loc_10 != BaselineOffset.ASCENT)
                {
                    _loc_17 = this.getLineAdjustmentForInline(param1, this._curLineLeadingModel, false);
                    if (_loc_17 != null)
                    {
                        if (this._blockProgression == BlockProgression.RL)
                        {
                            _loc_17.rise = -_loc_17.rise;
                        }
                        this._curLineLeading = this._curLineLeading + _loc_17.leading;
                        _loc_4 = _loc_4 + _loc_17.rise;
                    }
                }
            }
            _loc_4 = _loc_4 + (this._blockProgression == BlockProgression.RL ? (-_loc_3) : (_loc_3 - param1.ascent));
            var _loc_7:* = this._atColumnStart && this._curLineLeadingModel != LeadingModel.BOX ? (0) : (this._curLine.spaceBefore);
            var _loc_8:* = this._atColumnStart ? (0) : (this._paragraphSpaceCarried);
            if (_loc_7 != 0 || _loc_8 != 0)
            {
                _loc_18 = Math.max(_loc_7, _loc_8);
                _loc_4 = _loc_4 + (this._blockProgression == BlockProgression.RL ? (-_loc_18) : (_loc_18));
            }
            if (this._blockProgression == BlockProgression.TB)
            {
                this._curLine.setXYAndHeight(_loc_5, _loc_4, _loc_3);
            }
            else
            {
                this._curLine.setXYAndHeight(_loc_4, _loc_5, _loc_3);
            }
            return;
        }// end function

        private function applyTextAlign(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            if (this._blockProgression == BlockProgression.TB)
            {
                for each (_loc_5 in this._alignLines)
                {
                    
                    _loc_2 = _loc_5.textLine;
                    _loc_11 = _loc_5.rightSideGap;
                    _loc_10 = _loc_5.leftSideGap;
                    _loc_9 = param1 - _loc_10 - _loc_11 - _loc_2.textWidth;
                    _loc_7 = _loc_5.textAlign == TextAlign.CENTER ? (_loc_9 / 2) : (_loc_9);
                    _loc_6 = this._curParcel.x + _loc_10 + _loc_7;
                    if (_loc_5.textAlign != TextAlign.LEFT)
                    {
                        _loc_4 = _loc_2.userData as TextFlowLine;
                        if (_loc_4)
                        {
                            _loc_4.x = _loc_6;
                        }
                        _loc_2.x = _loc_6;
                    }
                    _loc_8 = _loc_5.lineWidth + _loc_6 + Math.max(_loc_11, 0);
                    this._parcelRight = Math.max(_loc_8, this._parcelRight);
                    _loc_3 = TextFlowLine.findNumberLine(_loc_2);
                    if (_loc_3 && TextFlowLine.getNumberLineListStylePosition(_loc_3) == ListStylePosition.OUTSIDE)
                    {
                        _loc_3.x = computeNumberLineAlignment(_loc_5, _loc_2.textWidth, _loc_2.x, _loc_3, _loc_6, _loc_7, _loc_9);
                        _loc_5.textFlowLine.numberLinePosition = _loc_3.x;
                        _loc_12 = _loc_3.x + _loc_2.x;
                        if (_loc_12 < this._parcelLeft)
                        {
                            this._parcelLeft = _loc_12;
                        }
                        _loc_12 = _loc_12 + TextFlowLine.getNumberLineInsideLineWidth(_loc_3);
                        if (_loc_12 > this._parcelRight)
                        {
                            this._parcelRight = _loc_12;
                        }
                    }
                }
            }
            else
            {
                for each (_loc_5 in this._alignLines)
                {
                    
                    _loc_2 = _loc_5.textLine;
                    _loc_11 = _loc_5.rightSideGap;
                    _loc_10 = _loc_5.leftSideGap;
                    _loc_9 = param1 - _loc_10 - _loc_11 - _loc_2.textWidth;
                    _loc_7 = _loc_5.textAlign == TextAlign.CENTER ? (_loc_9 / 2) : (_loc_9);
                    _loc_6 = this._curParcel.y + _loc_10 + _loc_7;
                    if (_loc_5.textAlign != TextAlign.LEFT)
                    {
                        _loc_4 = _loc_2.userData as TextFlowLine;
                        if (_loc_4)
                        {
                            _loc_4.y = _loc_6;
                        }
                        _loc_2.y = _loc_6;
                    }
                    _loc_8 = _loc_5.lineWidth + _loc_6 + Math.max(_loc_11, 0);
                    this._parcelBottom = Math.max(_loc_8, this._parcelBottom);
                    _loc_3 = TextFlowLine.findNumberLine(_loc_2);
                    if (_loc_3 && TextFlowLine.getNumberLineListStylePosition(_loc_3) == ListStylePosition.OUTSIDE)
                    {
                        _loc_3.y = computeNumberLineAlignment(_loc_5, _loc_2.textWidth, _loc_2.y, _loc_3, _loc_6, _loc_7, _loc_9);
                        _loc_5.textFlowLine.numberLinePosition = _loc_3.y;
                        _loc_12 = _loc_3.y + _loc_2.y;
                        if (_loc_12 < this._parcelTop)
                        {
                            this._parcelTop = _loc_12;
                        }
                        _loc_12 = _loc_12 + TextFlowLine.getNumberLineInsideLineWidth(_loc_3);
                        if (_loc_12 > this._parcelBottom)
                        {
                            this._parcelBottom = _loc_12;
                        }
                    }
                }
            }
            return;
        }// end function

        protected function commitLastLineState(param1:TextFlowLine) : void
        {
            this._lastLineDescent = this._curLineLeadingModel == LeadingModel.BOX ? (this._curLineLeading) : (param1.descent);
            this._lastLineLeading = this._curLineLeading;
            this._lastLineLeadingModel = this._curLineLeadingModel;
            return;
        }// end function

        protected function doVerticalAlignment(param1:Boolean, param2:Parcel) : void
        {
            return;
        }// end function

        protected function finalParcelAdjustment(param1:ContainerController) : void
        {
            return;
        }// end function

        protected function finishParcel(param1:ContainerController, param2:Parcel) : Boolean
        {
            if (this._curParcelStart == this._curElementStart + this._curElementOffset)
            {
                return false;
            }
            var _loc_3:* = this._parcelList.totalDepth;
            if (this._textFlow.configuration.overflowPolicy == OverflowPolicy.FIT_DESCENDERS && !isNaN(this._lastLineDescent))
            {
                _loc_3 = _loc_3 + this._lastLineDescent;
            }
            _loc_3 = Math.max(_loc_3, this._contentCommittedHeight);
            if (this._blockProgression == BlockProgression.TB)
            {
                this._parcelLeft = this._curParcel.x;
                this._parcelTop = this._curParcel.y;
                this._parcelRight = this._contentCommittedExtent + this._curParcel.x;
                this._parcelBottom = _loc_3 + this._curParcel.y;
            }
            else
            {
                this._parcelLeft = this._curParcel.right - _loc_3;
                this._parcelTop = this._curParcel.y;
                this._parcelRight = this._curParcel.right;
                this._parcelBottom = this._contentCommittedExtent + this._curParcel.y;
            }
            if (this._alignLines && this._alignLines.length > 0)
            {
                this.applyTextAlign(this._contentLogicalExtent);
                releaseAlignData(this._alignLines[0]);
                this._alignLines.length = 0;
            }
            var _loc_4:* = false;
            if (this._blockProgression == BlockProgression.TB)
            {
                if (!param1.measureHeight && (!this._curParcel.fitAny || this._curElementStart + this._curElementOffset >= this._textFlow.textLength))
                {
                    _loc_4 = true;
                }
            }
            else if (!param1.measureWidth && (!this._curParcel.fitAny || this._curElementStart + this._curElementOffset >= this._textFlow.textLength))
            {
                _loc_4 = true;
            }
            this.doVerticalAlignment(_loc_4, param2);
            this.finalParcelAdjustment(param1);
            this._contentLogicalExtent = 0;
            this._contentCommittedExtent = 0;
            this._contentCommittedHeight = 0;
            this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
            return true;
        }// end function

        protected function applyVerticalAlignmentToColumn(param1:ContainerController, param2:String, param3:Array, param4:int, param5:int, param6:int, param7:int) : void
        {
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_8:* = param3[param4];
            var _loc_9:* = param3[param4 + param5 - 1];
            if (this._blockProgression == BlockProgression.TB)
            {
                _loc_10 = _loc_8.y;
                _loc_11 = _loc_9.y;
            }
            else
            {
                _loc_10 = _loc_8.x;
                _loc_11 = _loc_9.x;
            }
            var _loc_12:* = VerticalJustifier.applyVerticalAlignmentToColumn(param1, param2, param3, param4, param5, param6, param7);
            if (!isNaN(this._parcelLogicalTop))
            {
                this._parcelLogicalTop = this._parcelLogicalTop + _loc_12;
            }
            if (this._blockProgression == BlockProgression.TB)
            {
                this._parcelTop = this._parcelTop + (_loc_8.y - _loc_10);
                this._parcelBottom = this._parcelBottom + (_loc_9.y - _loc_11);
            }
            else
            {
                this._parcelRight = this._parcelRight + (_loc_8.x - _loc_10);
                this._parcelLeft = this._parcelLeft + (_loc_9.x - _loc_11);
            }
            return;
        }// end function

        protected function finishController(param1:ContainerController) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_2:* = this._curElementStart + this._curElementOffset - param1.absoluteStart;
            if (_loc_2 != 0)
            {
                _loc_3 = param1.getTotalPaddingLeft();
                _loc_4 = param1.getTotalPaddingTop();
                _loc_5 = param1.getTotalPaddingRight();
                _loc_6 = param1.getTotalPaddingBottom();
                if (this._blockProgression == BlockProgression.TB)
                {
                    if (this._controllerLeft > 0)
                    {
                        if (this._controllerLeft < _loc_3)
                        {
                            this._controllerLeft = 0;
                        }
                        else
                        {
                            this._controllerLeft = this._controllerLeft - _loc_3;
                        }
                    }
                    if (this._controllerTop > 0)
                    {
                        if (this._controllerTop < _loc_4)
                        {
                            this._controllerTop = 0;
                        }
                        else
                        {
                            this._controllerTop = this._controllerTop - _loc_4;
                        }
                    }
                    if (isNaN(param1.compositionWidth))
                    {
                        this._controllerRight = this._controllerRight + _loc_5;
                    }
                    else if (this._controllerRight < param1.compositionWidth)
                    {
                        if (this._controllerRight > param1.compositionWidth - _loc_5)
                        {
                            this._controllerRight = param1.compositionWidth;
                        }
                        else
                        {
                            this._controllerRight = this._controllerRight + _loc_5;
                        }
                    }
                    this._controllerBottom = this._controllerBottom + _loc_6;
                }
                else
                {
                    this._controllerLeft = this._controllerLeft - _loc_3;
                    if (this._controllerTop > 0)
                    {
                        if (this._controllerTop < _loc_4)
                        {
                            this._controllerTop = 0;
                        }
                        else
                        {
                            this._controllerTop = this._controllerTop - _loc_4;
                        }
                    }
                    if (this._controllerRight < 0)
                    {
                        if (this._controllerRight > -_loc_5)
                        {
                            this._controllerRight = 0;
                        }
                        else
                        {
                            this._controllerRight = this._controllerRight + _loc_5;
                        }
                    }
                    if (isNaN(param1.compositionHeight))
                    {
                        this._controllerBottom = this._controllerBottom + _loc_6;
                    }
                    else if (this._controllerBottom < param1.compositionHeight)
                    {
                        if (this._controllerBottom > param1.compositionHeight - _loc_6)
                        {
                            this._controllerBottom = param1.compositionHeight;
                        }
                        else
                        {
                            this._controllerBottom = this._controllerBottom + _loc_6;
                        }
                    }
                }
                param1.setContentBounds(this._controllerLeft, this._controllerTop, this._controllerRight - this._controllerLeft, this._controllerBottom - this._controllerTop);
            }
            else
            {
                param1.setContentBounds(0, 0, 0, 0);
            }
            param1.setTextLength(_loc_2);
            param1.finalParcelStart = this._curParcelStart;
            return;
        }// end function

        private function clearControllers(param1:ContainerController, param2:ContainerController) : void
        {
            var _loc_5:* = null;
            var _loc_3:* = param1 ? ((this._flowComposer.getControllerIndex(param1) + 1)) : (0);
            var _loc_4:* = param2 ? (this._flowComposer.getControllerIndex(param2)) : ((this._flowComposer.numControllers - 1));
            while (_loc_3 <= _loc_4)
            {
                
                _loc_5 = ContainerController(this._flowComposer.getControllerAt(_loc_3));
                _loc_5.setContentBounds(0, 0, 0, 0);
                _loc_5.setTextLength(0);
                _loc_5.clearComposedLines(_loc_5.absoluteStart);
                _loc_5.clearFloatsAt(_loc_5.absoluteStart);
                _loc_3++;
            }
            return;
        }// end function

        protected function advanceToNextParcel() : void
        {
            this.parcelHasChanged(this._parcelList.atLast() ? (null) : (this._parcelList.getParcelAt((this._parcelList.currentParcelIndex + 1))));
            this._parcelList.next();
            return;
        }// end function

        protected function advanceToNextContainer() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this._parcelList.atLast() ? (null) : (this._parcelList.getParcelAt((this._parcelList.currentParcelIndex + 1)));
            var _loc_2:* = this._curParcel ? (ContainerController(this._curParcel.controller)) : (null);
            while (!this._parcelList.atLast())
            {
                
                _loc_1 = this._parcelList.atLast() ? (null) : (this._parcelList.getParcelAt((this._parcelList.currentParcelIndex + 1)));
                _loc_3 = _loc_1 ? (ContainerController(_loc_1.controller)) : (null);
                if (_loc_2 != _loc_3)
                {
                    break;
                }
                this._parcelList.next();
            }
            this.parcelHasChanged(this._parcelList.atLast() ? (null) : (this._parcelList.getParcelAt((this._parcelList.currentParcelIndex + 1))));
            this._parcelList.next();
            return;
        }// end function

        protected function parcelHasChanged(param1:Parcel) : void
        {
            var _loc_2:* = this._curParcel ? (ContainerController(this._curParcel.controller)) : (null);
            var _loc_3:* = param1 ? (ContainerController(param1.controller)) : (null);
            if (_loc_2 != null && this._lastGoodStart != -1)
            {
                _loc_2.clearFloatsAt(this._lastGoodStart);
                this._curLine = null;
                this._linePass = 0;
                this._pushInFloats.length = 0;
            }
            if (this._curParcel != null)
            {
                if (this.finishParcel(_loc_2, param1))
                {
                    if (this._parcelLeft < this._controllerLeft)
                    {
                        this._controllerLeft = this._parcelLeft;
                    }
                    if (this._parcelRight > this._controllerRight)
                    {
                        this._controllerRight = this._parcelRight;
                    }
                    if (this._parcelTop < this._controllerTop)
                    {
                        this._controllerTop = this._parcelTop;
                    }
                    if (this._parcelBottom > this._controllerBottom)
                    {
                        this._controllerBottom = this._parcelBottom;
                    }
                }
            }
            if (_loc_2 != _loc_3)
            {
                if (_loc_2)
                {
                    this.finishController(_loc_2);
                }
                this.resetControllerBounds();
                if (this._flowComposer.numControllers > 1)
                {
                    if (_loc_2 == null && this._startController)
                    {
                        this.clearControllers(this._startController, _loc_3);
                    }
                    else
                    {
                        this.clearControllers(_loc_2, _loc_3);
                    }
                }
                if (_loc_3)
                {
                    if (_loc_2)
                    {
                        this._startComposePosition = _loc_3.absoluteStart;
                    }
                    this._curInteractiveObjects = _loc_3.interactiveObjects;
                    this.calculateControllerVisibleBounds(_loc_3);
                }
            }
            this._curParcel = param1;
            this._curParcelStart = this._curElementStart + this._curElementOffset;
            this._atColumnStart = true;
            this._workingTotalDepth = 0;
            if (_loc_3)
            {
                this._verticalSpaceCarried = this._blockProgression == BlockProgression.RL ? (_loc_3.getTotalPaddingRight()) : (_loc_3.getTotalPaddingTop());
                this._measuring = this._blockProgression == BlockProgression.TB && _loc_3.measureWidth || this._blockProgression == BlockProgression.RL && _loc_3.measureHeight;
            }
            return;
        }// end function

        private function calculateControllerVisibleBounds(param1:ContainerController) : void
        {
            var _loc_2:* = param1.measureWidth ? (Number.MAX_VALUE) : (param1.compositionWidth);
            var _loc_3:* = param1.horizontalScrollPosition;
            this._controllerVisibleBoundsXTW = Twips.roundTo(this._blockProgression == BlockProgression.RL ? (_loc_3 - _loc_2) : (_loc_3));
            this._controllerVisibleBoundsYTW = Twips.roundTo(param1.verticalScrollPosition);
            this._controllerVisibleBoundsWidthTW = param1.measureWidth ? (int.MAX_VALUE) : (Twips.to(param1.compositionWidth));
            this._controllerVisibleBoundsHeightTW = param1.measureHeight ? (int.MAX_VALUE) : (Twips.to(param1.compositionHeight));
            return;
        }// end function

        private function getLineAdjustmentForInline(param1:TextLine, param2:String, param3:Boolean) : LeadingAdjustment
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = this._curLine.paragraph;
            var _loc_6:* = this._curElement;
            var _loc_7:* = this._curElement.getAbsoluteStart();
            var _loc_8:* = _loc_6.getEffectiveFontSize();
            var _loc_9:* = 0;
            while (_loc_6 && _loc_7 < this._curLine.absoluteStart + this._curLine.textLength)
            {
                
                if (_loc_7 >= this._curLine.absoluteStart || _loc_7 + _loc_6.textLength >= this._curLine.absoluteStart)
                {
                    if (_loc_6 is InlineGraphicElement)
                    {
                        _loc_10 = _loc_6 as InlineGraphicElement;
                        if (_loc_10.effectiveFloat == Float.NONE && !(this._blockProgression == BlockProgression.RL && _loc_6.parent is TCYElement))
                        {
                            if (_loc_9 < _loc_10.getEffectiveFontSize())
                            {
                                _loc_9 = _loc_10.getEffectiveFontSize();
                                if (_loc_9 >= _loc_8)
                                {
                                    _loc_9 = _loc_9;
                                    _loc_11 = _loc_6.computedFormat.dominantBaseline;
                                    if (_loc_11 == FormatValue.AUTO)
                                    {
                                        _loc_11 = LocaleUtil.dominantBaseline(_loc_5.computedFormat.locale);
                                    }
                                    if (_loc_11 == TextBaseline.IDEOGRAPHIC_CENTER)
                                    {
                                        _loc_12 = this.calculateLinePlacementAdjustment(param1, _loc_11, param2, _loc_10, param3);
                                        if (!_loc_4 || Math.abs(_loc_12.rise) > Math.abs(_loc_4.rise) || Math.abs(_loc_12.leading) > Math.abs(_loc_4.leading))
                                        {
                                            if (_loc_4)
                                            {
                                                _loc_4.rise = _loc_12.rise;
                                                _loc_4.leading = _loc_12.leading;
                                            }
                                            else
                                            {
                                                _loc_4 = _loc_12;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        _loc_13 = _loc_6.getEffectiveFontSize();
                        if (_loc_8 <= _loc_13)
                        {
                            _loc_8 = _loc_13;
                        }
                        if (_loc_4 && _loc_9 < _loc_8)
                        {
                            _loc_4.leading = 0;
                            _loc_4.rise = 0;
                        }
                    }
                }
                _loc_7 = _loc_7 + _loc_6.textLength;
                _loc_6 = _loc_6.getNextLeaf(_loc_5);
            }
            return _loc_4;
        }// end function

        public function get swfContext() : ISWFContext
        {
            var _loc_1:* = this._flowComposer.swfContext;
            return _loc_1 ? (_loc_1) : (GlobalSWFContext.globalSWFContext);
        }// end function

        private function calculateLinePlacementAdjustment(param1:TextLine, param2:String, param3:String, param4:InlineGraphicElement, param5:Boolean) : LeadingAdjustment
        {
            var _loc_6:* = new LeadingAdjustment();
            var _loc_7:* = param4.getEffectiveLineHeight(this._blockProgression);
            var _loc_8:* = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(param4.computedFormat.lineHeight, param1.textHeight);
            if (param2 == TextBaseline.IDEOGRAPHIC_CENTER)
            {
                if (!param5)
                {
                    _loc_6.rise = _loc_6.rise + (_loc_7 - _loc_8) / 2;
                }
                else
                {
                    _loc_6.leading = _loc_6.leading - (_loc_7 - _loc_8) / 2;
                }
            }
            return _loc_6;
        }// end function

        protected function pushInsideListItemMargins(param1:TextLine) : void
        {
            var _loc_2:* = NaN;
            if (param1 && this._listItemElement.computedFormat.listStylePosition == ListStylePosition.INSIDE)
            {
                _loc_2 = TextFlowLine.getNumberLineInsideLineWidth(param1);
                this._parcelList.pushInsideListItemMargin(_loc_2);
            }
            return;
        }// end function

        protected function popInsideListItemMargins(param1:TextLine) : void
        {
            var _loc_2:* = NaN;
            if (param1 && this._listItemElement.computedFormat.listStylePosition == ListStylePosition.INSIDE)
            {
                _loc_2 = TextFlowLine.getNumberLineInsideLineWidth(param1);
                this._parcelList.popInsideListItemMargin(_loc_2);
            }
            return;
        }// end function

        public static function get globalSWFContext() : ISWFContext
        {
            return GlobalSWFContext.globalSWFContext;
        }// end function

        private static function createAlignData(param1:TextFlowLine) : AlignData
        {
            var _loc_2:* = null;
            if (_savedAlignData)
            {
                _loc_2 = _savedAlignData;
                _loc_2.textFlowLine = param1;
                _savedAlignData = null;
                return _loc_2;
            }
            return new AlignData(param1);
        }// end function

        private static function releaseAlignData(param1:AlignData) : void
        {
            param1.textLine = null;
            param1.textFlowLine = null;
            _savedAlignData = param1;
            return;
        }// end function

        static function computeNumberLineAlignment(param1:AlignData, param2:Number, param3:Number, param4:TextLine, param5:Number, param6:Number, param7:Number) : Number
        {
            var _loc_8:* = NaN;
            if (param1.textAlign == TextAlign.CENTER)
            {
                if (TextFlowLine.getNumberLineParagraphDirection(param4) == Direction.LTR)
                {
                    _loc_8 = -(param4.textWidth + TextFlowLine.getListEndIndent(param4) + param6) - param1.textIndent;
                }
                else
                {
                    _loc_8 = param2 + TextFlowLine.getListEndIndent(param4) + (TextFlowLine.getNumberLineInsideLineWidth(param4) - param4.textWidth) + (param5 - param6 + param7 - param3) + param1.textIndent;
                }
            }
            else if (param1.textAlign == TextAlign.RIGHT)
            {
                if (TextFlowLine.getNumberLineParagraphDirection(param4) == Direction.LTR)
                {
                    _loc_8 = -(param4.textWidth + TextFlowLine.getListEndIndent(param4) + param6) - param1.textIndent;
                }
                else
                {
                    _loc_8 = param2 + TextFlowLine.getListEndIndent(param4) + (TextFlowLine.getNumberLineInsideLineWidth(param4) - param4.textWidth) + param1.textIndent;
                }
            }
            else if (TextFlowLine.getNumberLineParagraphDirection(param4) == Direction.LTR)
            {
                _loc_8 = -(param4.textWidth + TextFlowLine.getListEndIndent(param4)) - param1.textIndent;
            }
            else
            {
                _loc_8 = param2 + TextFlowLine.getListEndIndent(param4) + (TextFlowLine.getNumberLineInsideLineWidth(param4) - param4.textWidth) + (param5 - param3) + param1.textIndent;
            }
            return _loc_8;
        }// end function

    }
}

import flash.display.*;

import flash.geom.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.container.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.formats.*;

import flashx.textLayout.utils.*;

class AlignData extends Object
{
    public var textFlowLine:TextFlowLine;
    public var textLine:TextLine;
    public var lineWidth:Number;
    public var textAlign:String;
    public var leftSideGap:Number;
    public var rightSideGap:Number;
    public var textIndent:Number;

    function AlignData(param1:TextFlowLine)
    {
        this.textFlowLine = param1;
        return;
    }// end function

}


import flash.display.*;

import flash.geom.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.container.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.formats.*;

import flashx.textLayout.utils.*;

class LeadingAdjustment extends Object
{
    public var rise:Number = 0;
    public var leading:Number = 0;
    public var lineHeight:Number = 0;

    function LeadingAdjustment()
    {
        return;
    }// end function

}

