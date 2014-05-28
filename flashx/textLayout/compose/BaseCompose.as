package flashx.textLayout.compose
{
   import flashx.textLayout.tlf_internal;
   import flash.text.engine.TextLine;
   import flashx.textLayout.formats.TextAlign;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.ContainerFormattedElement;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.formats.ClearFloats;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.Configuration;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.formats.Float;
   import flash.text.engine.TextBlock;
   import flashx.textLayout.formats.ListStylePosition;
   import flashx.textLayout.formats.LeadingModel;
   import flash.text.engine.TextLineCreationResult;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flashx.textLayout.elements.OverflowPolicy;
   import flashx.textLayout.utils.Twips;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.formats.BaselineOffset;
   import flashx.textLayout.formats.VerticalAlign;
   import flashx.textLayout.utils.LocaleUtil;
   import flash.text.engine.TextBaseline;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.formats.FormatValue;
   
   use namespace tlf_internal;
   
   public class BaseCompose extends Object
   {
      
      public function BaseCompose() {
         this._lineSlug = new Slug();
         super();
      }
      
      public static function get globalSWFContext() : ISWFContext {
         return GlobalSWFContext.globalSWFContext;
      }
      
      private static var _savedAlignData:AlignData;
      
      private static function createAlignData(param1:TextFlowLine) : AlignData {
         var _loc2_:AlignData = null;
         if(_savedAlignData)
         {
            _loc2_ = _savedAlignData;
            _loc2_.textFlowLine = param1;
            _savedAlignData = null;
            return _loc2_;
         }
         return new AlignData(param1);
      }
      
      private static function releaseAlignData(param1:AlignData) : void {
         param1.textLine = null;
         param1.textFlowLine = null;
         _savedAlignData = param1;
      }
      
      protected static var _savedLineSlug:Slug;
      
      protected static var _floatSlug:Slug;
      
      tlf_internal  static function computeNumberLineAlignment(param1:AlignData, param2:Number, param3:Number, param4:TextLine, param5:Number, param6:Number, param7:Number) : Number {
         var _loc8_:* = NaN;
         if(param1.textAlign == TextAlign.CENTER)
         {
            if(TextFlowLine.getNumberLineParagraphDirection(param4) == Direction.LTR)
            {
               _loc8_ = -(param4.textWidth + TextFlowLine.getListEndIndent(param4) + param6) - param1.textIndent;
            }
            else
            {
               _loc8_ = param2 + TextFlowLine.getListEndIndent(param4) + (TextFlowLine.getNumberLineInsideLineWidth(param4) - param4.textWidth) + (param5 - param6 + param7 - param3) + param1.textIndent;
            }
         }
         else
         {
            if(param1.textAlign == TextAlign.RIGHT)
            {
               if(TextFlowLine.getNumberLineParagraphDirection(param4) == Direction.LTR)
               {
                  _loc8_ = -(param4.textWidth + TextFlowLine.getListEndIndent(param4) + param6) - param1.textIndent;
               }
               else
               {
                  _loc8_ = param2 + TextFlowLine.getListEndIndent(param4) + (TextFlowLine.getNumberLineInsideLineWidth(param4) - param4.textWidth) + param1.textIndent;
               }
            }
            else
            {
               if(TextFlowLine.getNumberLineParagraphDirection(param4) == Direction.LTR)
               {
                  _loc8_ = -(param4.textWidth + TextFlowLine.getListEndIndent(param4)) - param1.textIndent;
               }
               else
               {
                  _loc8_ = param2 + TextFlowLine.getListEndIndent(param4) + (TextFlowLine.getNumberLineInsideLineWidth(param4) - param4.textWidth) + (param5 - param3) + param1.textIndent;
               }
            }
         }
         return _loc8_;
      }
      
      protected var _parcelList:ParcelList;
      
      public function get parcelList() : ParcelList {
         return this._parcelList;
      }
      
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
      
      protected var _measuring:Boolean;
      
      protected var _curLine:TextFlowLine;
      
      protected var _previousLine:TextLine;
      
      protected var _listItemElement:ListItemElement;
      
      protected function createParcelList() : ParcelList {
         return null;
      }
      
      protected function releaseParcelList(param1:ParcelList) : void {
      }
      
      public function get startController() : ContainerController {
         return this._startController;
      }
      
      tlf_internal function releaseAnyReferences() : void {
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
      }
      
      protected function initializeForComposer(param1:IFlowComposer, param2:int, param3:int, param4:int) : void {
         if(!_savedLineSlug)
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
         this._stopComposePos = param2 >= 0?Math.min(this._textFlow.textLength,param2):this._textFlow.textLength;
         if(param3 < 0)
         {
            param3 = 0;
         }
         this._parcelList.beginCompose(param1,param3,param4,param2 > 0);
         this._contentLogicalExtent = 0;
         this._contentCommittedExtent = 0;
         this._contentCommittedHeight = 0;
         this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
         this._parcelLogicalTop = NaN;
         this._linePass = 0;
         this._lastGoodStart = -1;
         if(this._pushInFloats)
         {
            this._pushInFloats.length = 0;
         }
         this._listItemElement = null;
      }
      
      private function composeBlockElement(param1:FlowGroupElement, param2:int) : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function composeTextFlow(param1:TextFlow, param2:int, param3:int) : int {
         var _loc4_:* = 0;
         var _loc5_:TextFlowLine = null;
         this._textFlow = param1;
         this._releaseLineCreationData = (param1.configuration.releaseLineCreationData) && (Configuration.playerEnablesArgoFeatures);
         this._flowComposer = this._textFlow.flowComposer;
         this._rootElement = param1;
         this._curElementOffset = 0;
         this._curElement = this._rootElement.getFirstLeaf();
         this._curElementStart = 0;
         this._curParcel = null;
         this.initializeForComposer(this._flowComposer,param2,-1,param3);
         this.resetControllerBounds();
         this._curElement = this._textFlow.findLeaf(this._startComposePosition);
         this._curElementStart = this._curElement.getAbsoluteStart();
         this._curElementOffset = this._startComposePosition - this._curElementStart;
         if(this._startComposePosition <= this._startController.absoluteStart || !this.advanceToComposeStartPosition())
         {
            if(this._startComposePosition > this._startController.absoluteStart)
            {
               this._startComposePosition = this._startController.absoluteStart;
               this._curElement = this._textFlow.findLeaf(this._startComposePosition);
               this._curElementStart = this._curElement.getAbsoluteStart();
               this._curElementOffset = this._startComposePosition - this._curElementStart;
            }
            if(this._startComposePosition == this._curElement.getParagraph().getAbsoluteStart())
            {
               this._previousLine = null;
            }
            else
            {
               _loc4_ = this._flowComposer.findLineIndexAtPosition(this._startComposePosition-1);
               _loc5_ = this._flowComposer.getLineAt(_loc4_);
               this._previousLine = _loc5_.getTextLine(true);
            }
            this.advanceToNextParcel();
            if(this._curParcel)
            {
               this._curParcel.controller.clearFloatsAt(0);
            }
         }
         this._startController.clearComposedLines(this._curElementStart + this._curElementOffset);
         this._curParcelStart = this._startController.absoluteStart;
         this.composeInternal(this._rootElement,0);
         while(!this.parcelList.atEnd())
         {
            this.advanceToNextParcel();
         }
         this.parcelHasChanged(null);
         this.releaseParcelList(this._parcelList);
         this._parcelList = null;
         _savedLineSlug = this._lineSlug;
         return this._curElementStart + this._curElementOffset;
      }
      
      private function advanceToComposeStartPosition() : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function initializeContentBounds(param1:int, param2:int) : void {
         var _loc4_:TextFlowLine = null;
         var _loc5_:* = NaN;
         var _loc6_:TextLine = null;
         var _loc7_:AlignData = null;
         var _loc8_:ITextLayoutFormat = null;
         var _loc3_:* = -1;
         this._parcelLogicalTop = this.computeTextFlowLineMinimumLogicalTop(this._flowComposer.getLineAt(param1),null);
         if(this._measuring)
         {
            while(param1 <= param2)
            {
               _loc4_ = this._flowComposer.getLineAt(param1);
               if(_loc4_.columnIndex != _loc3_)
               {
                  _loc3_ = _loc4_.columnIndex;
                  this._contentLogicalExtent = 0;
                  this._contentCommittedExtent = 0;
                  this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
               }
               _loc5_ = _loc4_.lineExtent;
               this._contentLogicalExtent = Math.max(this._contentLogicalExtent,_loc5_);
               if(_loc4_.alignment == TextAlign.LEFT && !_loc4_.hasNumberLine)
               {
                  this._contentCommittedExtent = Math.max(this._contentCommittedExtent,_loc5_);
               }
               else
               {
                  _loc7_ = createAlignData(_loc4_);
                  _loc7_.textLine = _loc4_.getTextLine(true);
                  _loc7_.textAlign = _loc4_.alignment;
                  _loc8_ = _loc4_.paragraph.computedFormat;
                  _loc7_.rightSideGap = this.getRightSideGap(_loc4_,!(_loc4_.alignment == TextAlign.LEFT));
                  _loc7_.leftSideGap = this.getLeftSideGap(_loc4_);
                  _loc7_.textIndent = _loc8_.textIndent;
                  _loc7_.lineWidth = _loc5_ - (_loc7_.rightSideGap + _loc7_.leftSideGap);
                  if(!this._alignLines)
                  {
                     this._alignLines = [];
                  }
                  this._alignLines.push(_loc7_);
               }
               param1++;
            }
         }
         else
         {
            _loc4_ = this._flowComposer.getLineAt(param2);
            this._contentLogicalExtent = this._contentCommittedExtent = _loc4_.accumulatedLineExtent;
            this._accumulatedMinimumStart = _loc4_.accumulatedMinimumStart;
            if(this._parcelList.currentParcelIndex > 0 && this._parcelList.currentParcel.columnIndex > 0)
            {
               if(this._blockProgression == BlockProgression.TB)
               {
                  this._controllerBottom = this._curParcel.controller.compositionHeight;
               }
               else
               {
                  this._controllerLeft = 0 - this._curParcel.controller.compositionWidth;
               }
               if(this._textFlow.computedFormat.direction == Direction.RTL)
               {
                  this._controllerRight = this._curParcel.controller.compositionWidth;
               }
            }
         }
      }
      
      tlf_internal function computeTextFlowLineMinimumLogicalTop(param1:TextFlowLine, param2:TextLine) : Number {
         var _loc3_:* = 0;
         var _loc4_:FlowLeafElement = null;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:ContainerController = null;
         var _loc8_:* = 0;
         var _loc9_:FloatCompositionData = null;
         if(param1.hasGraphicElement)
         {
            _loc3_ = param1.absoluteStart;
            _loc4_ = this._textFlow.findLeaf(_loc3_);
            _loc5_ = param1.getLineTypographicAscent(_loc4_,_loc4_.getAbsoluteStart(),param2);
            _loc6_ = this._blockProgression == BlockProgression.RL?param1.x + _loc5_:param1.y + param1.ascent - _loc5_;
            _loc7_ = param1.controller;
            _loc8_ = _loc3_ + param1.textLength;
            if(_loc7_.numFloats > 0)
            {
               while(_loc3_ < _loc8_)
               {
                  _loc9_ = _loc7_.getFloatAtPosition(_loc3_);
                  if(_loc9_)
                  {
                     _loc6_ = Math.min(_loc6_,_loc9_.depth);
                     _loc3_ = _loc9_.absolutePosition + 1;
                     continue;
                  }
                  break;
               }
            }
            return _loc6_;
         }
         return NaN;
      }
      
      private function resetControllerBounds() : void {
         this._controllerLeft = TextLine.MAX_LINE_WIDTH;
         this._controllerTop = TextLine.MAX_LINE_WIDTH;
         this._controllerRight = -TextLine.MAX_LINE_WIDTH;
         this._controllerBottom = -TextLine.MAX_LINE_WIDTH;
      }
      
      protected function get releaseLineCreationData() : Boolean {
         return this._releaseLineCreationData;
      }
      
      protected function composeInternal(param1:FlowGroupElement, param2:int) : void {
         this.composeBlockElement(param1,param2);
      }
      
      protected function composeParagraphElement(param1:ParagraphElement, param2:int) : Boolean {
         var _loc5_:TextBlock = null;
         var _loc6_:TextLine = null;
         this._curParaElement = param1;
         this._curParaStart = param2;
         this._curParaFormat = param1.computedFormat;
         this._paragraphContainsVisibleLines = !(this._curElementStart + this._curElementOffset == this._curParaStart);
         var _loc3_:Boolean = this.composeParagraphElementIntoLines();
         var _loc4_:* = true;
         if(!this._paragraphContainsVisibleLines)
         {
            _loc5_ = param1.getTextBlock();
            _loc6_ = _loc5_.lastLine;
            while((_loc6_) && (_loc4_))
            {
               if(_loc6_.parent)
               {
                  _loc4_ = false;
               }
               _loc6_ = _loc6_.previousLine;
            }
            if(_loc4_)
            {
               _loc6_ = _loc5_.lastLine;
               while(_loc6_)
               {
                  _loc5_.releaseLines(_loc6_,_loc6_);
                  _loc6_.userData = null;
                  TextLineRecycler.addLineForReuse(_loc6_);
                  if(this._textFlow.backgroundManager)
                  {
                     this._textFlow.backgroundManager.removeLineFromCache(_loc6_);
                  }
                  _loc6_ = _loc5_.lastLine;
               }
               param1.releaseTextBlock();
            }
         }
         if((this.releaseLineCreationData) && !_loc4_)
         {
            param1.releaseLineCreationData();
         }
         return _loc3_;
      }
      
      protected function getFirstIndentCharPos(param1:ParagraphElement) : int {
         var _loc2_:* = 0;
         var _loc3_:FlowLeafElement = param1.getFirstLeaf();
         while((_loc3_) && (_loc3_ is InlineGraphicElement) && !(InlineGraphicElement(_loc3_).effectiveFloat == Float.NONE))
         {
            _loc2_ = _loc2_ + _loc3_.textLength;
            _loc3_ = _loc3_.getNextLeaf();
         }
         return _loc2_;
      }
      
      protected function composeParagraphElementIntoLines() : Boolean {
         var _loc2_:TextLine = null;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc7_:String = null;
         var _loc8_:TextLine = null;
         var _loc9_:* = false;
         var _loc10_:AlignData = null;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = 0;
         var _loc1_:* = true;
         var _loc5_:Number = 0;
         if(this._curParaFormat.direction == Direction.LTR)
         {
            _loc3_ = this._curParaFormat.paragraphStartIndent;
            _loc4_ = this._curParaFormat.paragraphEndIndent;
         }
         else
         {
            _loc3_ = this._curParaFormat.paragraphEndIndent;
            _loc4_ = this._curParaFormat.paragraphStartIndent;
         }
         this._parcelList.pushLeftMargin(_loc3_);
         this._parcelList.pushRightMargin(_loc4_);
         var _loc6_:int = this._curParaStart;
         if(this.preProcessILGs(this._curElementStart - this._curParaStart))
         {
            _loc6_ = this.getFirstIndentCharPos(this._curParaElement) + this._curParaStart;
         }
         while(_loc1_)
         {
            if(this._parcelList.atEnd())
            {
               _loc1_ = false;
               break;
            }
            this.startLine();
            if(!this._forceILGs)
            {
               this.processFloatsAtLineStart();
            }
            this._textIndent = this._curElementStart + this._curElementOffset <= _loc6_?this._curParaFormat.textIndent:0;
            if(this._parcelList.atEnd())
            {
               _loc1_ = false;
               break;
            }
            _loc2_ = this.composeNextLine();
            if(_loc2_ == null)
            {
               _loc1_ = false;
               break;
            }
            _loc7_ = this._curParaFormat.textAlign;
            if(_loc7_ == TextAlign.JUSTIFY)
            {
               _loc13_ = this._curLine.location;
               if(_loc13_ == TextFlowLineLocation.LAST || _loc13_ == TextFlowLineLocation.ONLY)
               {
                  _loc7_ = this._curParaFormat.textAlignLast;
               }
            }
            switch(_loc7_)
            {
               case TextAlign.START:
                  _loc7_ = this._curParaFormat.direction == Direction.LTR?TextAlign.LEFT:TextAlign.RIGHT;
                  break;
               case TextAlign.END:
                  _loc7_ = this._curParaFormat.direction == Direction.LTR?TextAlign.RIGHT:TextAlign.LEFT;
                  break;
            }
            _loc8_ = TextFlowLine.findNumberLine(_loc2_);
            _loc9_ = ((_loc8_) && (TextFlowLine.getNumberLineListStylePosition(_loc8_) == ListStylePosition.OUTSIDE)) || _loc7_ == TextAlign.CENTER || _loc7_ == TextAlign.RIGHT;
            if(Configuration.playerEnablesArgoFeatures)
            {
               if(_loc2_["hasTabs"])
               {
                  if(this._curParaFormat.direction == Direction.LTR)
                  {
                     if(!_loc8_ || TextFlowLine.getNumberLineListStylePosition(_loc8_) == ListStylePosition.INSIDE)
                     {
                        _loc9_ = false;
                     }
                     _loc7_ = TextAlign.LEFT;
                  }
                  else
                  {
                     _loc9_ = true;
                     _loc7_ = TextAlign.RIGHT;
                  }
               }
            }
            if(_loc9_)
            {
               _loc10_ = createAlignData(this._curLine);
               _loc10_.textLine = _loc2_;
               _loc10_.textAlign = _loc7_;
            }
            _loc11_ = (this._atColumnStart) && !(this._curParaFormat.leadingModel == LeadingModel.BOX)?0:this._curLine.spaceBefore;
            _loc12_ = this._atColumnStart?0:this._paragraphSpaceCarried;
            if(!(_loc11_ == 0) || !(_loc12_ == 0))
            {
               this._parcelList.addTotalDepth(Math.max(_loc11_,_loc12_));
            }
            this._paragraphSpaceCarried = 0;
            if(this._verticalSpaceCarried != 0)
            {
               this._verticalSpaceCarried = 0;
            }
            this._parcelList.addTotalDepth(this._curLine.height);
            _loc10_ = this.calculateLineAlignmentAndBounds(_loc2_,_loc8_,_loc10_);
            if(_loc10_)
            {
               if(!this._alignLines)
               {
                  this._alignLines = [];
               }
               this._alignLines.push(_loc10_);
               this._curLine.alignment = _loc7_;
            }
            if(_loc5_ != 0)
            {
               if(this._curParaFormat.direction == Direction.LTR)
               {
                  this._parcelList.popLeftMargin(_loc5_);
               }
               else
               {
                  this._parcelList.popRightMargin(_loc5_);
               }
               _loc5_ = 0;
            }
            if(!this.processFloatsAtLineEnd(_loc2_) || !this._curLine)
            {
               this.resetLine(_loc2_);
            }
            else
            {
               this.endLine(_loc2_);
               this._lastGoodStart = -1;
               if(this.isLineVisible(_loc2_))
               {
                  this._curParcel.controller.addComposedLine(_loc2_);
                  this._paragraphContainsVisibleLines = true;
               }
               if(this._parcelList.atEnd())
               {
                  _loc1_ = false;
                  break;
               }
               this._previousLine = _loc2_;
               this._curElementOffset = this._curElementOffset + this._curLine.textLength;
               if(this._curElementOffset >= this._curElement.textLength)
               {
                  do
                  {
                        this._curElementOffset = this._curElementOffset - this._curElement.textLength;
                        this._curElementStart = this._curElementStart + this._curElement.textLength;
                        this._curElement = this._curElement.getNextLeaf();
                        if(this._curElementStart == this._curParaStart + this._curParaElement.textLength)
                        {
                           break;
                        }
                     }while(this._curElementOffset >= this._curElement.textLength || this._curElement.textLength == 0);
                     
                  }
                  this._paragraphSpaceCarried = this._curLine.spaceAfter;
                  if(this._curElementStart == this._curParaStart + this._curParaElement.textLength)
                  {
                     break;
                  }
               }
            }
            this._parcelList.popLeftMargin(_loc3_);
            this._parcelList.popRightMargin(_loc4_);
            if(_loc5_ != 0)
            {
               if(this._curParaFormat.direction == Direction.LTR)
               {
                  this._parcelList.popLeftMargin(_loc5_);
               }
               else
               {
                  this._parcelList.popRightMargin(_loc5_);
               }
               _loc5_ = 0;
            }
            this._previousLine = null;
            return _loc1_;
         }
         
         protected function createTextLine(param1:Number, param2:Boolean) : TextLine {
            var _loc3_:Number = this._curParaFormat.direction == Direction.LTR?this._lineSlug.leftMargin:this._lineSlug.rightMargin;
            var _loc4_:TextLine = null;
            _loc4_ = TextLineRecycler.getLineForReuse();
            var _loc5_:TextBlock = this._curParaElement.getTextBlock();
            if(_loc4_)
            {
               _loc4_ = this.swfContext.callInContext(_loc5_["recreateTextLine"],_loc5_,[_loc4_,this._previousLine,param1,_loc3_,true]);
            }
            else
            {
               _loc4_ = this.swfContext.callInContext(_loc5_.createTextLine,_loc5_,[this._previousLine,param1,_loc3_,true]);
            }
            if(!param2 && _loc5_.textLineCreationResult == TextLineCreationResult.EMERGENCY)
            {
               _loc4_ = null;
            }
            if(_loc4_ == null)
            {
               return null;
            }
            this._curLine.initialize(this._curParaElement,param1,_loc3_ - this._parcelList.insideListItemMargin,_loc4_.textBlockBeginIndex + this._curParaStart,_loc4_.rawTextLength,_loc4_);
            return _loc4_;
         }
         
         protected function startLine() : void {
            this._workingContentExtent = 0;
            this._workingContentHeight = 0;
            this._workingContentLogicalExtent = 0;
            this._workingParcelIndex = this._parcelList.currentParcelIndex;
            this._workingTotalDepth = this.parcelList.totalDepth;
            this._workingParcelLogicalTop = NaN;
         }
         
         protected function isLineVisible(param1:TextLine) : Boolean {
            return !(this._curParcel.controller.isLineVisible(this._blockProgression,this._controllerVisibleBoundsXTW,this._controllerVisibleBoundsYTW,this._controllerVisibleBoundsWidthTW,this._controllerVisibleBoundsHeightTW,this._curLine,param1) == null);
         }
         
         protected function endLine(param1:TextLine) : void {
            this._contentCommittedExtent = Math.max(this._contentCommittedExtent,this._workingContentExtent);
            this._contentCommittedHeight = Math.max(this._contentCommittedHeight,this._workingContentHeight);
            this._contentLogicalExtent = Math.max(this._contentLogicalExtent,this._workingContentLogicalExtent);
            if(!this._measuring)
            {
               this._contentLogicalExtent = this._contentCommittedExtent;
            }
            if(this._pushInFloats)
            {
               this._pushInFloats.length = 0;
            }
            this._atColumnStart = false;
            this._linePass = 0;
            if(!isNaN(this._workingParcelLogicalTop))
            {
               this._parcelLogicalTop = this._workingParcelLogicalTop;
            }
         }
         
         protected function resetLine(param1:TextLine) : void {
            if(this._textFlow.backgroundManager)
            {
               this._textFlow.backgroundManager.removeLineFromCache(param1);
            }
            if(this._workingParcelIndex != this.parcelList.currentParcelIndex)
            {
               this._linePass = 0;
               if(this._pushInFloats)
               {
                  this._pushInFloats.length = 0;
               }
            }
            else
            {
               this._linePass++;
            }
            this.parcelList.addTotalDepth(this._workingTotalDepth - this._parcelList.totalDepth);
            this._workingTotalDepth = this.parcelList.totalDepth;
         }
         
         protected function preProcessILGs(param1:int) : Boolean {
            var _loc5_:InlineGraphicElement = null;
            if(!this._curParcel)
            {
               return false;
            }
            var _loc2_:* = false;
            var _loc3_:* = this._blockProgression == BlockProgression.RL;
            this._forceILGs = (this._parcelList.explicitLineBreaks) || (_loc3_) && (this._curParcel.controller.measureHeight) || !_loc3_ && (this._curParcel.controller.measureWidth);
            var _loc4_:FlowLeafElement = this._curParaElement.findLeaf(param1);
            while(_loc4_)
            {
               if(_loc4_ is InlineGraphicElement)
               {
                  _loc5_ = _loc4_ as InlineGraphicElement;
                  _loc5_.setEffectiveFloat(this._forceILGs?Float.NONE:_loc5_.computedFloat);
                  _loc2_ = true;
               }
               _loc4_ = _loc4_.getNextLeaf(this._curParaElement);
            }
            return _loc2_;
         }
         
         protected function processFloatsAtLineStart() : void {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:FlowLeafElement = null;
            if(this._forceILGs)
            {
               return;
            }
            if((this._pushInFloats) && this._pushInFloats.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this._pushInFloats.length)
               {
                  _loc2_ = this._pushInFloats[_loc1_];
                  _loc3_ = this._textFlow.findLeaf(_loc2_);
                  if(!this.composeFloat(_loc3_ as InlineGraphicElement,false))
                  {
                     this._pushInFloats.length = _loc1_;
                  }
                  _loc1_++;
               }
            }
         }
         
         protected function processFloatsAtLineEnd(param1:TextLine) : Boolean {
            var _loc8_:* = 0;
            var _loc9_:* = 0;
            var _loc10_:InlineGraphicElement = null;
            var _loc11_:* = NaN;
            var _loc12_:FloatCompositionData = null;
            var _loc13_:* = NaN;
            var _loc14_:InlineGraphicElement = null;
            if(!param1.hasGraphicElement && this._linePass <= 0)
            {
               return true;
            }
            if((this._pushInFloats) && this._pushInFloats.length > 0)
            {
               _loc8_ = this._pushInFloats[this._pushInFloats.length-1];
               if(this._curLine.absoluteStart + this._curLine.textLength <= _loc8_)
               {
                  _loc9_ = this._pushInFloats.length-1;
                  while(_loc9_ >= 0)
                  {
                     _loc8_ = this._pushInFloats[_loc9_];
                     _loc10_ = this._textFlow.findLeaf(_loc8_) as InlineGraphicElement;
                     _loc11_ = this._blockProgression == BlockProgression.RL?_loc10_.elementWidth + _loc10_.getEffectivePaddingLeft() + _loc10_.getEffectivePaddingRight():_loc10_.elementHeightWithMarginsAndPadding();
                     _loc12_ = this._curLine.controller.getFloatAtPosition(_loc8_);
                     if((_loc12_) && _loc12_.absolutePosition == _loc8_)
                     {
                        _loc13_ = isNaN(this._lastLineDescent)?0:this._lastLineDescent;
                        this._curParcel.removeKnockOut(_loc12_.knockOutWidth,_loc12_.depth - _loc13_,_loc12_.depth + _loc11_,_loc12_.floatType == Float.LEFT);
                     }
                     _loc9_--;
                  }
                  this._curLine.controller.clearFloatsAt(this._pushInFloats[0]);
                  this._pushInFloats.length--;
                  return false;
               }
            }
            var _loc2_:int = this._curElementStart;
            var _loc3_:FlowLeafElement = this._curElement;
            var _loc4_:int = this._curLine.absoluteStart + this._curLine.textLength;
            var _loc5_:* = 0;
            var _loc6_:* = false;
            while(_loc2_ < _loc4_)
            {
               if(_loc3_ is InlineGraphicElement)
               {
                  _loc14_ = InlineGraphicElement(_loc3_);
                  if(_loc14_.computedFloat == Float.NONE || (this._forceILGs))
                  {
                     _loc6_ = true;
                  }
                  else
                  {
                     if(this._linePass == 0)
                     {
                        if(!this._pushInFloats)
                        {
                           this._pushInFloats = [];
                        }
                        this._pushInFloats.push(_loc2_);
                     }
                     else
                     {
                        if(this._pushInFloats.indexOf(_loc2_) >= 0)
                        {
                           _loc5_++;
                        }
                        else
                        {
                           if(!this.composeFloat(_loc14_,true))
                           {
                              this.advanceToNextParcel();
                              return false;
                           }
                        }
                     }
                  }
               }
               _loc2_ = _loc2_ + _loc3_.textLength;
               _loc3_ = _loc3_.getNextLeaf();
            }
            var _loc7_:* = _loc5_ >= (this._pushInFloats?this._pushInFloats.length:0);
            if((_loc7_) && (_loc6_))
            {
               this.processInlinesAtLineEnd(param1);
            }
            return _loc7_;
         }
         
         protected function processInlinesAtLineEnd(param1:TextLine) : void {
            var _loc5_:InlineGraphicElement = null;
            var _loc2_:int = this._curElementStart;
            var _loc3_:FlowLeafElement = this._curElement;
            var _loc4_:int = this._curLine.absoluteStart + this._curLine.textLength;
            while(_loc2_ < _loc4_)
            {
               if(_loc3_ is InlineGraphicElement)
               {
                  _loc5_ = _loc3_ as InlineGraphicElement;
                  if(_loc5_.computedFloat == Float.NONE || (this._forceILGs))
                  {
                     this.composeInlineGraphicElement(_loc5_,param1);
                  }
               }
               _loc2_ = _loc2_ + _loc3_.textLength;
               _loc3_ = _loc3_.getNextLeaf();
            }
         }
         
         protected function composeInlineGraphicElement(param1:InlineGraphicElement, param2:TextLine) : Boolean {
            var _loc3_:Number = this._blockProgression == BlockProgression.RL?-param1.getEffectivePaddingRight():param1.getEffectivePaddingLeft();
            var _loc4_:Number = param1.getEffectivePaddingTop();
            var _loc5_:DisplayObject = param1.placeholderGraphic.parent;
            this._curParcel.controller.addFloatAt(this._curParaStart + param1.getElementRelativeStart(this._curParaElement),param1.graphic,Float.NONE,_loc3_,_loc4_,_loc5_?_loc5_.alpha:1,_loc5_?_loc5_.transform.matrix:null,this._parcelList.totalDepth,0,this._curParcel.columnIndex,param2);
            return true;
         }
         
         protected function composeFloat(param1:InlineGraphicElement, param2:Boolean) : Boolean {
            var _loc7_:* = NaN;
            var _loc8_:* = NaN;
            var _loc11_:String = null;
            var _loc12_:Rectangle = null;
            var _loc13_:* = NaN;
            var _loc14_:* = NaN;
            if(param1.elementHeight == 0 || param1.elementWidth == 0)
            {
               return true;
            }
            if(this._lastGoodStart == -1)
            {
               this._lastGoodStart = this._curElementStart + this._curElementOffset;
            }
            var _loc3_:* = this._blockProgression == BlockProgression.RL;
            var _loc4_:Number = 0;
            if(((param2) || !this._atColumnStart) && !isNaN(this._lastLineDescent))
            {
               _loc4_ = this._lastLineDescent;
            }
            var _loc5_:Number = 0;
            if((this._curLine) && (!(this._curParaElement == this._curLine.paragraph)) && !this._atColumnStart)
            {
               _loc5_ = Math.max(this._curParaElement.computedFormat.paragraphSpaceBefore,this._paragraphSpaceCarried);
            }
            var _loc6_:Number = this._parcelList.totalDepth + _loc5_ + _loc4_;
            if(!_floatSlug)
            {
               _floatSlug = new Slug();
            }
            if(_loc3_)
            {
               _loc7_ = param1.elementHeight + param1.getEffectivePaddingTop() + param1.getEffectivePaddingBottom();
               _loc8_ = param1.elementWidth + param1.getEffectivePaddingLeft() + param1.getEffectivePaddingRight();
            }
            else
            {
               _loc7_ = param1.elementWidthWithMarginsAndPadding();
               _loc8_ = param1.elementHeightWithMarginsAndPadding();
            }
            var _loc9_:int = param1.getAbsoluteStart();
            var _loc10_:Boolean = this._parcelList.fitFloat(_floatSlug,_loc6_,_loc7_,_loc8_);
            if(!_loc10_ && ((this._curParcel.fitAny) || (this._curParcel.fitsInHeight(_loc6_,int(_loc8_)))) && (!this._curLine || this._curLine.absoluteStart == _loc9_ || (param2)))
            {
               _loc10_ = true;
            }
            if(_loc10_)
            {
               _loc11_ = param1.computedFloat;
               if(_loc11_ == Float.START)
               {
                  _loc11_ = this._curParaFormat.direction == Direction.LTR?Float.LEFT:Float.RIGHT;
               }
               else
               {
                  if(_loc11_ == Float.END)
                  {
                     _loc11_ = this._curParaFormat.direction == Direction.LTR?Float.RIGHT:Float.LEFT;
                  }
               }
               _loc12_ = this.calculateFloatBounds(param1,_loc3_,_loc11_);
               if(_loc3_)
               {
                  this._workingContentExtent = Math.max(this._workingContentExtent,_loc12_.bottom);
                  this._workingContentHeight = Math.max(this._workingContentHeight,_floatSlug.depth + _loc12_.width);
                  this._workingContentLogicalExtent = Math.max(this._workingContentLogicalExtent,_loc12_.bottom);
                  this._accumulatedMinimumStart = Math.min(this._accumulatedMinimumStart,_loc12_.y);
               }
               else
               {
                  this._workingContentExtent = Math.max(this._workingContentExtent,_loc12_.right);
                  this._workingContentHeight = Math.max(this._workingContentHeight,_floatSlug.depth + _loc12_.height);
                  this._workingContentLogicalExtent = Math.max(this._workingContentLogicalExtent,_loc12_.right);
                  this._accumulatedMinimumStart = Math.min(this._accumulatedMinimumStart,_loc12_.x);
               }
               if(_loc9_ == this._curParcelStart)
               {
                  this._workingParcelLogicalTop = _floatSlug.depth;
               }
               _loc13_ = (_loc11_ == Float.LEFT?_floatSlug.leftMargin:_floatSlug.rightMargin) + _loc7_;
               _loc14_ = isNaN(this._lastLineDescent)?0:this._lastLineDescent;
               this._curParcel.knockOut(_loc13_,_floatSlug.depth - _loc14_,_floatSlug.depth + _loc8_,_loc11_ == Float.LEFT);
               this._curParcel.controller.addFloatAt(_loc9_,param1.graphic,_loc11_,_loc12_.x,_loc12_.y,param1.computedFormat.textAlpha,null,_floatSlug.depth,_loc13_,this._curParcel.columnIndex,this._curParcel.controller.container);
            }
            return _loc10_;
         }
         
         private function calculateFloatBounds(param1:InlineGraphicElement, param2:Boolean, param3:String) : Rectangle {
            var _loc4_:Rectangle = new Rectangle();
            if(param2)
            {
               _loc4_.x = this._curParcel.right - _floatSlug.depth - param1.elementWidth - param1.getEffectivePaddingRight();
               _loc4_.y = param3 == Float.LEFT?this._curParcel.y + _floatSlug.leftMargin + param1.getEffectivePaddingTop():this._curParcel.bottom - _floatSlug.rightMargin - param1.getEffectivePaddingBottom() - param1.elementHeight;
               _loc4_.width = param1.elementWidth;
               _loc4_.height = param1.elementHeight;
            }
            else
            {
               _loc4_.x = param3 == Float.LEFT?this._curParcel.x + _floatSlug.leftMargin + param1.getEffectivePaddingLeft():this._curParcel.right - _floatSlug.rightMargin - param1.getEffectivePaddingRight() - param1.elementWidth;
               _loc4_.y = this._curParcel.y + _floatSlug.depth + param1.getEffectivePaddingTop();
               _loc4_.width = param1.elementWidth;
               _loc4_.height = param1.elementHeight;
            }
            return _loc4_;
         }
         
         private function calculateLineWidthExplicit(param1:TextLine) : Number {
            var _loc2_:* = this._curParaElement.computedFormat.direction == Direction.RTL;
            var _loc3_:int = param1.atomCount-1;
            var _loc4_:* = this._curLine.absoluteStart + this._curLine.textLength == this._curParaStart + this._curParaElement.textLength;
            if((_loc4_) && !_loc2_)
            {
               _loc3_--;
            }
            var _loc5_:Rectangle = param1.getAtomBounds(_loc3_ >= 0?_loc3_:0);
            var _loc6_:Number = this._blockProgression == BlockProgression.TB?_loc3_ >= 0?_loc5_.right:_loc5_.left:_loc3_ >= 0?_loc5_.bottom:_loc5_.top;
            if(_loc2_)
            {
               _loc5_ = param1.getAtomBounds(!(_loc3_ == 0) && (_loc4_)?1:0);
               _loc6_ = _loc6_ - (this._blockProgression == BlockProgression.TB?_loc5_.left:_loc5_.top);
            }
            return _loc6_;
         }
         
         private function getRightSideGap(param1:TextFlowLine, param2:Boolean) : Number {
            var _loc6_:TextLine = null;
            var _loc7_:TextLine = null;
            var _loc3_:FlowGroupElement = param1.paragraph;
            var _loc4_:ITextLayoutFormat = _loc3_.computedFormat;
            var _loc5_:Number = _loc4_.direction == Direction.RTL?_loc4_.paragraphStartIndent:_loc4_.paragraphEndIndent;
            if(_loc4_.direction == Direction.RTL && (param1.location & TextFlowLineLocation.FIRST))
            {
               _loc5_ = _loc5_ + _loc4_.textIndent;
               if((param1.hasNumberLine) && _loc3_.getParentByType(ListItemElement).computedFormat.listStylePosition == ListStylePosition.INSIDE)
               {
                  _loc6_ = param1.getTextLine(true);
                  _loc7_ = TextFlowLine.findNumberLine(_loc6_);
                  _loc5_ = _loc5_ + TextFlowLine.getNumberLineInsideLineWidth(_loc7_);
               }
            }
            do
            {
                  _loc5_ = _loc5_ + (this._blockProgression == BlockProgression.TB?_loc3_.getEffectivePaddingRight():_loc3_.getEffectivePaddingBottom());
                  _loc3_ = _loc3_.parent;
               }while(!(_loc3_ is TextFlow));
               
               return _loc5_;
            }
            
            private function getLeftSideGap(param1:TextFlowLine) : Number {
               var _loc5_:TextLine = null;
               var _loc6_:TextLine = null;
               var _loc2_:FlowGroupElement = param1.paragraph;
               var _loc3_:ITextLayoutFormat = _loc2_.computedFormat;
               var _loc4_:Number = _loc3_.direction == Direction.LTR?_loc3_.paragraphStartIndent:_loc3_.paragraphEndIndent;
               if(_loc3_.direction == Direction.LTR && (param1.location & TextFlowLineLocation.FIRST))
               {
                  _loc4_ = _loc4_ + _loc3_.textIndent;
                  if((param1.hasNumberLine) && _loc2_.getParentByType(ListItemElement).computedFormat.listStylePosition == ListStylePosition.INSIDE)
                  {
                     _loc5_ = param1.getTextLine(true);
                     _loc6_ = TextFlowLine.findNumberLine(_loc5_);
                     _loc4_ = _loc4_ + TextFlowLine.getNumberLineInsideLineWidth(_loc6_);
                  }
               }
               do
               {
                     _loc4_ = _loc4_ + (this._blockProgression == BlockProgression.TB?_loc2_.getEffectivePaddingLeft():_loc2_.getEffectivePaddingTop());
                     _loc2_ = _loc2_.parent;
                  }while(!(_loc2_ is TextFlow));
                  
                  return _loc4_;
               }
               
               private function calculateLineAlignmentAndBounds(param1:TextLine, param2:TextLine, param3:AlignData) : AlignData {
                  var _loc9_:* = NaN;
                  var _loc10_:* = NaN;
                  var _loc11_:* = NaN;
                  var _loc12_:* = NaN;
                  var _loc13_:* = NaN;
                  var _loc14_:* = NaN;
                  var _loc15_:* = NaN;
                  var _loc4_:Number = this._parcelList.explicitLineBreaks?this.calculateLineWidthExplicit(param1):param1.textWidth;
                  var _loc5_:Number = this._lineSlug.rightMargin;
                  var _loc6_:Number = this._lineSlug.leftMargin;
                  var _loc7_:Number = 0;
                  if(param3)
                  {
                     param3.rightSideGap = _loc5_;
                     param3.leftSideGap = _loc6_;
                     param3.lineWidth = _loc4_;
                     param3.textIndent = this._curParaFormat.textIndent;
                     if(this._blockProgression == BlockProgression.TB)
                     {
                        if(!this._measuring)
                        {
                           _loc12_ = param1.textWidth;
                           _loc9_ = this._curParcel.width - _loc6_ - _loc5_ - _loc12_;
                           if(param3.textAlign != TextAlign.LEFT)
                           {
                              _loc7_ = param3.textAlign == TextAlign.CENTER?_loc9_ / 2:_loc9_;
                              _loc10_ = this._curParcel.x + _loc6_ + _loc7_;
                           }
                           else
                           {
                              _loc10_ = this._curParcel.x + _loc6_ + _loc9_;
                           }
                           if(param3.textAlign != TextAlign.LEFT)
                           {
                              this._curLine.x = _loc10_;
                              param1.x = _loc10_;
                           }
                           else
                           {
                              param1.x = this._curLine.x;
                           }
                           if((param2) && TextFlowLine.getNumberLineListStylePosition(param2) == ListStylePosition.OUTSIDE)
                           {
                              param2.x = computeNumberLineAlignment(param3,param1.textWidth,param1.x,param2,_loc10_,_loc7_,_loc9_);
                              this._curLine.numberLinePosition = param2.x;
                           }
                           releaseAlignData(param3);
                           param3 = null;
                        }
                     }
                     else
                     {
                        if(!this._measuring)
                        {
                           _loc9_ = this._curParcel.height - _loc6_ - _loc5_ - param1.textWidth;
                           if(param3.textAlign != TextAlign.LEFT)
                           {
                              _loc7_ = param3.textAlign == TextAlign.CENTER?_loc9_ / 2:_loc9_;
                              _loc10_ = this._curParcel.y + _loc6_ + _loc7_;
                           }
                           else
                           {
                              _loc10_ = this._curParcel.y + _loc6_ + _loc9_;
                           }
                           if(param3.textAlign != TextAlign.LEFT)
                           {
                              this._curLine.y = _loc10_;
                              param1.y = _loc10_;
                           }
                           else
                           {
                              param1.y = this._curLine.y;
                           }
                           if((param2) && TextFlowLine.getNumberLineListStylePosition(param2) == ListStylePosition.OUTSIDE)
                           {
                              param2.y = computeNumberLineAlignment(param3,param1.textWidth,param1.y,param2,_loc10_,_loc7_,_loc9_);
                              this._curLine.numberLinePosition = param2.y;
                           }
                           releaseAlignData(param3);
                           param3 = null;
                        }
                     }
                  }
                  var _loc8_:Number = _loc4_ + _loc6_ + _loc5_ + _loc7_;
                  this._curLine.lineExtent = _loc8_;
                  this._workingContentLogicalExtent = Math.max(this._workingContentLogicalExtent,_loc8_);
                  this._curLine.accumulatedLineExtent = Math.max(this._contentLogicalExtent,this._workingContentLogicalExtent);
                  if(!param3)
                  {
                     _loc13_ = this._curParaFormat.direction == Direction.LTR?Math.max(this._curLine.lineOffset,0):this._curParaFormat.paragraphEndIndent;
                     _loc13_ = this._blockProgression == BlockProgression.RL?this._curLine.y - _loc13_:this._curLine.x - _loc13_;
                     if(param2)
                     {
                        _loc14_ = this._blockProgression == BlockProgression.TB?param2.x + this._curLine.x:param2.y + this._curLine.y;
                        _loc13_ = Math.min(_loc13_,_loc14_);
                        if(TextFlowLine.getNumberLineListStylePosition(param2) == ListStylePosition.OUTSIDE)
                        {
                           _loc15_ = _loc14_ + TextFlowLine.getNumberLineInsideLineWidth(param2);
                           _loc15_ = _loc15_ - _loc8_;
                           if(_loc15_ > 0)
                           {
                              _loc7_ = _loc7_ + _loc15_;
                           }
                        }
                     }
                     this._workingContentExtent = Math.max(this._workingContentExtent,_loc4_ + _loc6_ + Math.max(0,_loc5_) + _loc7_);
                     this._curLine.accumulatedMinimumStart = this._accumulatedMinimumStart = Math.min(this._accumulatedMinimumStart,_loc13_);
                  }
                  if(this._curLine.absoluteStart == this._curParcelStart && (isNaN(this._workingParcelLogicalTop)))
                  {
                     this._workingParcelLogicalTop = this.computeTextFlowLineMinimumLogicalTop(this._curLine,param1);
                  }
                  return param3;
               }
               
               protected function composeNextLine() : TextLine {
                  return null;
               }
               
               protected function fitLineToParcel(param1:TextLine, param2:Boolean, param3:TextLine) : Boolean {
                  var _loc4_:Number = this._lineSlug.depth;
                  this._curLine.setController(this._curParcel.controller,this._curParcel.columnIndex);
                  var _loc5_:Number = Math.max(this._curLine.spaceBefore,this._paragraphSpaceCarried);
                  loop0:
                  while(true)
                  {
                     this.finishComposeLine(param1,param3);
                     if(this._parcelList.getLineSlug(this._lineSlug,_loc5_ + ((this._parcelList.atLast()) && !(this._textFlow.configuration.overflowPolicy == OverflowPolicy.FIT_DESCENDERS)?this._curLine.height - this._curLine.ascent:this._curLine.height + this._curLine.descent),1,this._textIndent,this._curParaFormat.direction == Direction.LTR))
                     {
                        if(Twips.to(this._lineSlug.width) == this._curLine.outerTargetWidthTW && !(this._lineSlug.depth == _loc4_))
                        {
                           this.finishComposeLine(param1,param3);
                        }
                        break;
                     }
                     _loc5_ = this._curLine.spaceBefore;
                     if((this._pushInFloats) && (this._parcelList.currentParcel.fitAny) && this._pushInFloats.length > 0)
                     {
                        break;
                     }
                     while(true)
                     {
                        this.advanceToNextParcel();
                        if(!this._curLine || (this._parcelList.atEnd()))
                        {
                           break;
                        }
                        if(this._parcelList.getLineSlug(this._lineSlug,0,1,this._textIndent,this._curParaFormat.direction == Direction.LTR))
                        {
                           _loc4_ = this._lineSlug.depth;
                           this._curLine.setController(this._curParcel.controller,this._curParcel.columnIndex);
                           continue loop0;
                        }
                     }
                     return false;
                  }
                  if(Twips.to(this._lineSlug.width) != this._curLine.outerTargetWidthTW)
                  {
                     return false;
                  }
                  if(param2)
                  {
                     if(param3)
                     {
                        TextFlowLine.initializeNumberLinePosition(param3,this._listItemElement,this._curParaElement,param1.textWidth);
                     }
                     this._curLine.createAdornments(this._blockProgression,this._curElement,this._curElementStart,param1,param3);
                  }
                  return true;
               }
               
               protected function calculateLeadingParameters(param1:FlowLeafElement, param2:int, param3:TextLine=null) : Number {
                  var _loc4_:ITextLayoutFormat = null;
                  var _loc5_:Rectangle = null;
                  if(param3)
                  {
                     _loc4_ = TextFlowLine.getNumberLineSpanFormat(param3);
                  }
                  if(this._curLineLeadingModel == LeadingModel.BOX)
                  {
                     _loc5_ = this._curLine.getCSSLineBox(this._blockProgression,param1,param2,this._textFlow.flowComposer.swfContext,_loc4_,param3);
                     this._curLineLeading = _loc5_?_loc5_.bottom:0;
                     return _loc5_?-_loc5_.top:0;
                  }
                  this._curLineLeading = this._curLine.getLineLeading(this._blockProgression,param1,param2);
                  if(_loc4_)
                  {
                     this._curLineLeading = Math.max(this._curLineLeading,TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(_loc4_.lineHeight,_loc4_.fontSize));
                  }
                  return 0;
               }
               
               protected function finishComposeLine(param1:TextLine, param2:TextLine) : void {
                  var _loc4_:* = NaN;
                  var _loc5_:* = NaN;
                  var _loc9_:ITextLayoutFormat = null;
                  var _loc10_:Object = null;
                  var _loc11_:String = null;
                  var _loc12_:LeadingAdjustment = null;
                  var _loc13_:* = NaN;
                  var _loc14_:* = false;
                  var _loc15_:* = false;
                  var _loc16_:FlowLeafElement = null;
                  var _loc17_:LeadingAdjustment = null;
                  var _loc18_:* = NaN;
                  var _loc3_:Number = 0;
                  if(this._blockProgression == BlockProgression.RL)
                  {
                     _loc4_ = this._curParcel.x + this._curParcel.width - this._lineSlug.depth;
                     _loc5_ = this._curParcel.y;
                  }
                  else
                  {
                     _loc4_ = this._curParcel.y + this._lineSlug.depth;
                     _loc5_ = this._curParcel.x;
                  }
                  _loc5_ = _loc5_ + this._lineSlug.leftMargin;
                  this._curLineLeadingModel = this._curParaElement.getEffectiveLeadingModel();
                  var _loc6_:Number = this.calculateLeadingParameters(this._curElement,this._curElementStart,param2);
                  if(this._curLineLeadingModel == LeadingModel.BOX)
                  {
                     _loc3_ = _loc3_ + (this._atColumnStart?0:this._lastLineDescent);
                     _loc3_ = _loc3_ + _loc6_;
                  }
                  else
                  {
                     _loc9_ = this._curParcel.controller.computedFormat;
                     _loc10_ = BaselineOffset.LINE_HEIGHT;
                     if(this._atColumnStart)
                     {
                        if(!(_loc9_.firstBaselineOffset == BaselineOffset.AUTO) && !(_loc9_.verticalAlign == VerticalAlign.BOTTOM) && !(_loc9_.verticalAlign == VerticalAlign.MIDDLE))
                        {
                           _loc10_ = _loc9_.firstBaselineOffset;
                           _loc11_ = LocaleUtil.leadingModel(_loc9_.locale) == LeadingModel.IDEOGRAPHIC_TOP_DOWN?TextBaseline.IDEOGRAPHIC_BOTTOM:TextBaseline.ROMAN;
                           _loc3_ = _loc3_ - param1.getBaselinePosition(_loc11_);
                        }
                        else
                        {
                           if(this._curLineLeadingModel == LeadingModel.APPROXIMATE_TEXT_FIELD)
                           {
                              _loc3_ = _loc3_ + (Math.round(param1.descent) + Math.round(param1.ascent));
                              if(this._blockProgression == BlockProgression.TB)
                              {
                                 _loc3_ = Math.round(_loc4_ + _loc3_) - _loc4_;
                              }
                              else
                              {
                                 _loc3_ = _loc4_ - Math.round(_loc4_ - _loc3_);
                              }
                              _loc10_ = 0;
                           }
                           else
                           {
                              _loc10_ = BaselineOffset.ASCENT;
                              if(param1.hasGraphicElement)
                              {
                                 _loc12_ = this.getLineAdjustmentForInline(param1,this._curLineLeadingModel,true);
                                 if(_loc12_ != null)
                                 {
                                    if(this._blockProgression == BlockProgression.RL)
                                    {
                                       _loc12_.rise = -_loc12_.rise;
                                    }
                                    this._curLineLeading = this._curLineLeading + _loc12_.leading;
                                    _loc4_ = _loc4_ + _loc12_.rise;
                                 }
                              }
                              _loc3_ = _loc3_ - param1.getBaselinePosition(TextBaseline.ROMAN);
                           }
                        }
                     }
                     if(_loc10_ == BaselineOffset.ASCENT)
                     {
                        _loc13_ = this._curLine.getLineTypographicAscent(this._curElement,this._curElementStart,param1);
                        if(param2)
                        {
                           _loc3_ = _loc3_ + Math.max(_loc13_,TextFlowLine.getTextLineTypographicAscent(param2,null,0,0));
                        }
                        else
                        {
                           _loc3_ = _loc3_ + _loc13_;
                        }
                     }
                     else
                     {
                        if(_loc10_ == BaselineOffset.LINE_HEIGHT)
                        {
                           if(this._curLineLeadingModel == LeadingModel.APPROXIMATE_TEXT_FIELD)
                           {
                              _loc3_ = _loc3_ + (Math.round(this._lastLineDescent) + Math.round(param1.ascent) + Math.round(param1.descent) + Math.round(this._curLineLeading));
                           }
                           else
                           {
                              if(this._curLineLeadingModel == LeadingModel.ASCENT_DESCENT_UP)
                              {
                                 _loc3_ = _loc3_ + (this._lastLineDescent + param1.ascent + this._curLineLeading);
                              }
                              else
                              {
                                 _loc14_ = this._atColumnStart?true:ParagraphElement.useUpLeadingDirection(this._curLineLeadingModel);
                                 _loc15_ = (this._atColumnStart) || this._lastLineLeadingModel == ""?true:ParagraphElement.useUpLeadingDirection(this._lastLineLeadingModel);
                                 if(_loc14_)
                                 {
                                    _loc3_ = _loc3_ + this._curLineLeading;
                                 }
                                 else
                                 {
                                    if(!_loc15_)
                                    {
                                       _loc3_ = _loc3_ + this._lastLineLeading;
                                    }
                                    else
                                    {
                                       _loc3_ = _loc3_ + (this._lastLineDescent + param1.ascent);
                                    }
                                 }
                              }
                           }
                        }
                        else
                        {
                           _loc3_ = _loc3_ + Number(_loc10_);
                        }
                     }
                     if((param1.hasGraphicElement) && !(_loc10_ == BaselineOffset.ASCENT))
                     {
                        _loc17_ = this.getLineAdjustmentForInline(param1,this._curLineLeadingModel,false);
                        if(_loc17_ != null)
                        {
                           if(this._blockProgression == BlockProgression.RL)
                           {
                              _loc17_.rise = -_loc17_.rise;
                           }
                           this._curLineLeading = this._curLineLeading + _loc17_.leading;
                           _loc4_ = _loc4_ + _loc17_.rise;
                        }
                     }
                  }
                  _loc4_ = _loc4_ + (this._blockProgression == BlockProgression.RL?-_loc3_:_loc3_ - param1.ascent);
                  var _loc7_:Number = (this._atColumnStart) && !(this._curLineLeadingModel == LeadingModel.BOX)?0:this._curLine.spaceBefore;
                  var _loc8_:Number = this._atColumnStart?0:this._paragraphSpaceCarried;
                  if(!(_loc7_ == 0) || !(_loc8_ == 0))
                  {
                     _loc18_ = Math.max(_loc7_,_loc8_);
                     _loc4_ = _loc4_ + (this._blockProgression == BlockProgression.RL?-_loc18_:_loc18_);
                  }
                  if(this._blockProgression == BlockProgression.TB)
                  {
                     this._curLine.setXYAndHeight(_loc5_,_loc4_,_loc3_);
                  }
                  else
                  {
                     this._curLine.setXYAndHeight(_loc4_,_loc5_,_loc3_);
                  }
               }
               
               private function applyTextAlign(param1:Number) : void {
                  var _loc2_:TextLine = null;
                  var _loc3_:TextLine = null;
                  var _loc4_:TextFlowLine = null;
                  var _loc5_:AlignData = null;
                  var _loc6_:* = NaN;
                  var _loc7_:* = NaN;
                  var _loc8_:* = NaN;
                  var _loc9_:* = NaN;
                  var _loc10_:* = NaN;
                  var _loc11_:* = NaN;
                  var _loc12_:* = NaN;
                  if(this._blockProgression == BlockProgression.TB)
                  {
                     for each (_loc5_ in this._alignLines)
                     {
                        _loc2_ = _loc5_.textLine;
                        _loc11_ = _loc5_.rightSideGap;
                        _loc10_ = _loc5_.leftSideGap;
                        _loc9_ = param1 - _loc10_ - _loc11_ - _loc2_.textWidth;
                        _loc7_ = _loc5_.textAlign == TextAlign.CENTER?_loc9_ / 2:_loc9_;
                        _loc6_ = this._curParcel.x + _loc10_ + _loc7_;
                        if(_loc5_.textAlign != TextAlign.LEFT)
                        {
                           _loc4_ = _loc2_.userData as TextFlowLine;
                           if(_loc4_)
                           {
                              _loc4_.x = _loc6_;
                           }
                           _loc2_.x = _loc6_;
                        }
                        _loc8_ = _loc5_.lineWidth + _loc6_ + Math.max(_loc11_,0);
                        this._parcelRight = Math.max(_loc8_,this._parcelRight);
                        _loc3_ = TextFlowLine.findNumberLine(_loc2_);
                        if((_loc3_) && TextFlowLine.getNumberLineListStylePosition(_loc3_) == ListStylePosition.OUTSIDE)
                        {
                           _loc3_.x = computeNumberLineAlignment(_loc5_,_loc2_.textWidth,_loc2_.x,_loc3_,_loc6_,_loc7_,_loc9_);
                           _loc5_.textFlowLine.numberLinePosition = _loc3_.x;
                           _loc12_ = _loc3_.x + _loc2_.x;
                           if(_loc12_ < this._parcelLeft)
                           {
                              this._parcelLeft = _loc12_;
                           }
                           _loc12_ = _loc12_ + TextFlowLine.getNumberLineInsideLineWidth(_loc3_);
                           if(_loc12_ > this._parcelRight)
                           {
                              this._parcelRight = _loc12_;
                           }
                        }
                     }
                  }
                  else
                  {
                     for each (_loc5_ in this._alignLines)
                     {
                        _loc2_ = _loc5_.textLine;
                        _loc11_ = _loc5_.rightSideGap;
                        _loc10_ = _loc5_.leftSideGap;
                        _loc9_ = param1 - _loc10_ - _loc11_ - _loc2_.textWidth;
                        _loc7_ = _loc5_.textAlign == TextAlign.CENTER?_loc9_ / 2:_loc9_;
                        _loc6_ = this._curParcel.y + _loc10_ + _loc7_;
                        if(_loc5_.textAlign != TextAlign.LEFT)
                        {
                           _loc4_ = _loc2_.userData as TextFlowLine;
                           if(_loc4_)
                           {
                              _loc4_.y = _loc6_;
                           }
                           _loc2_.y = _loc6_;
                        }
                        _loc8_ = _loc5_.lineWidth + _loc6_ + Math.max(_loc11_,0);
                        this._parcelBottom = Math.max(_loc8_,this._parcelBottom);
                        _loc3_ = TextFlowLine.findNumberLine(_loc2_);
                        if((_loc3_) && TextFlowLine.getNumberLineListStylePosition(_loc3_) == ListStylePosition.OUTSIDE)
                        {
                           _loc3_.y = computeNumberLineAlignment(_loc5_,_loc2_.textWidth,_loc2_.y,_loc3_,_loc6_,_loc7_,_loc9_);
                           _loc5_.textFlowLine.numberLinePosition = _loc3_.y;
                           _loc12_ = _loc3_.y + _loc2_.y;
                           if(_loc12_ < this._parcelTop)
                           {
                              this._parcelTop = _loc12_;
                           }
                           _loc12_ = _loc12_ + TextFlowLine.getNumberLineInsideLineWidth(_loc3_);
                           if(_loc12_ > this._parcelBottom)
                           {
                              this._parcelBottom = _loc12_;
                           }
                        }
                     }
                  }
               }
               
               protected function commitLastLineState(param1:TextFlowLine) : void {
                  this._lastLineDescent = this._curLineLeadingModel == LeadingModel.BOX?this._curLineLeading:param1.descent;
                  this._lastLineLeading = this._curLineLeading;
                  this._lastLineLeadingModel = this._curLineLeadingModel;
               }
               
               protected function doVerticalAlignment(param1:Boolean, param2:Parcel) : void {
               }
               
               protected function finalParcelAdjustment(param1:ContainerController) : void {
               }
               
               protected function finishParcel(param1:ContainerController, param2:Parcel) : Boolean {
                  if(this._curParcelStart == this._curElementStart + this._curElementOffset)
                  {
                     return false;
                  }
                  var _loc3_:Number = this._parcelList.totalDepth;
                  if(this._textFlow.configuration.overflowPolicy == OverflowPolicy.FIT_DESCENDERS && !isNaN(this._lastLineDescent))
                  {
                     _loc3_ = _loc3_ + this._lastLineDescent;
                  }
                  _loc3_ = Math.max(_loc3_,this._contentCommittedHeight);
                  if(this._blockProgression == BlockProgression.TB)
                  {
                     this._parcelLeft = this._curParcel.x;
                     this._parcelTop = this._curParcel.y;
                     this._parcelRight = this._contentCommittedExtent + this._curParcel.x;
                     this._parcelBottom = _loc3_ + this._curParcel.y;
                  }
                  else
                  {
                     this._parcelLeft = this._curParcel.right - _loc3_;
                     this._parcelTop = this._curParcel.y;
                     this._parcelRight = this._curParcel.right;
                     this._parcelBottom = this._contentCommittedExtent + this._curParcel.y;
                  }
                  if((this._alignLines) && this._alignLines.length > 0)
                  {
                     this.applyTextAlign(this._contentLogicalExtent);
                     releaseAlignData(this._alignLines[0]);
                     this._alignLines.length = 0;
                  }
                  var _loc4_:* = false;
                  if(this._blockProgression == BlockProgression.TB)
                  {
                     if(!param1.measureHeight && (!this._curParcel.fitAny || this._curElementStart + this._curElementOffset >= this._textFlow.textLength))
                     {
                        _loc4_ = true;
                     }
                  }
                  else
                  {
                     if(!param1.measureWidth && (!this._curParcel.fitAny || this._curElementStart + this._curElementOffset >= this._textFlow.textLength))
                     {
                        _loc4_ = true;
                     }
                  }
                  this.doVerticalAlignment(_loc4_,param2);
                  this.finalParcelAdjustment(param1);
                  this._contentLogicalExtent = 0;
                  this._contentCommittedExtent = 0;
                  this._contentCommittedHeight = 0;
                  this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
                  return true;
               }
               
               protected function applyVerticalAlignmentToColumn(param1:ContainerController, param2:String, param3:Array, param4:int, param5:int, param6:int, param7:int) : void {
                  var _loc10_:* = NaN;
                  var _loc11_:* = NaN;
                  var _loc8_:IVerticalJustificationLine = param3[param4];
                  var _loc9_:IVerticalJustificationLine = param3[param4 + param5-1];
                  if(this._blockProgression == BlockProgression.TB)
                  {
                     _loc10_ = _loc8_.y;
                     _loc11_ = _loc9_.y;
                  }
                  else
                  {
                     _loc10_ = _loc8_.x;
                     _loc11_ = _loc9_.x;
                  }
                  var _loc12_:Number = VerticalJustifier.applyVerticalAlignmentToColumn(param1,param2,param3,param4,param5,param6,param7);
                  if(!isNaN(this._parcelLogicalTop))
                  {
                     this._parcelLogicalTop = this._parcelLogicalTop + _loc12_;
                  }
                  if(this._blockProgression == BlockProgression.TB)
                  {
                     this._parcelTop = this._parcelTop + (_loc8_.y - _loc10_);
                     this._parcelBottom = this._parcelBottom + (_loc9_.y - _loc11_);
                  }
                  else
                  {
                     this._parcelRight = this._parcelRight + (_loc8_.x - _loc10_);
                     this._parcelLeft = this._parcelLeft + (_loc9_.x - _loc11_);
                  }
               }
               
               protected function finishController(param1:ContainerController) : void {
                  var _loc3_:* = NaN;
                  var _loc4_:* = NaN;
                  var _loc5_:* = NaN;
                  var _loc6_:* = NaN;
                  var _loc2_:int = this._curElementStart + this._curElementOffset - param1.absoluteStart;
                  if(_loc2_ != 0)
                  {
                     _loc3_ = param1.getTotalPaddingLeft();
                     _loc4_ = param1.getTotalPaddingTop();
                     _loc5_ = param1.getTotalPaddingRight();
                     _loc6_ = param1.getTotalPaddingBottom();
                     if(this._blockProgression == BlockProgression.TB)
                     {
                        if(this._controllerLeft > 0)
                        {
                           if(this._controllerLeft < _loc3_)
                           {
                              this._controllerLeft = 0;
                           }
                           else
                           {
                              this._controllerLeft = this._controllerLeft - _loc3_;
                           }
                        }
                        if(this._controllerTop > 0)
                        {
                           if(this._controllerTop < _loc4_)
                           {
                              this._controllerTop = 0;
                           }
                           else
                           {
                              this._controllerTop = this._controllerTop - _loc4_;
                           }
                        }
                        if(isNaN(param1.compositionWidth))
                        {
                           this._controllerRight = this._controllerRight + _loc5_;
                        }
                        else
                        {
                           if(this._controllerRight < param1.compositionWidth)
                           {
                              if(this._controllerRight > param1.compositionWidth - _loc5_)
                              {
                                 this._controllerRight = param1.compositionWidth;
                              }
                              else
                              {
                                 this._controllerRight = this._controllerRight + _loc5_;
                              }
                           }
                        }
                        this._controllerBottom = this._controllerBottom + _loc6_;
                     }
                     else
                     {
                        this._controllerLeft = this._controllerLeft - _loc3_;
                        if(this._controllerTop > 0)
                        {
                           if(this._controllerTop < _loc4_)
                           {
                              this._controllerTop = 0;
                           }
                           else
                           {
                              this._controllerTop = this._controllerTop - _loc4_;
                           }
                        }
                        if(this._controllerRight < 0)
                        {
                           if(this._controllerRight > -_loc5_)
                           {
                              this._controllerRight = 0;
                           }
                           else
                           {
                              this._controllerRight = this._controllerRight + _loc5_;
                           }
                        }
                        if(isNaN(param1.compositionHeight))
                        {
                           this._controllerBottom = this._controllerBottom + _loc6_;
                        }
                        else
                        {
                           if(this._controllerBottom < param1.compositionHeight)
                           {
                              if(this._controllerBottom > param1.compositionHeight - _loc6_)
                              {
                                 this._controllerBottom = param1.compositionHeight;
                              }
                              else
                              {
                                 this._controllerBottom = this._controllerBottom + _loc6_;
                              }
                           }
                        }
                     }
                     param1.setContentBounds(this._controllerLeft,this._controllerTop,this._controllerRight - this._controllerLeft,this._controllerBottom - this._controllerTop);
                  }
                  else
                  {
                     param1.setContentBounds(0,0,0,0);
                  }
                  param1.setTextLength(_loc2_);
                  param1.finalParcelStart = this._curParcelStart;
               }
               
               private function clearControllers(param1:ContainerController, param2:ContainerController) : void {
                  var _loc5_:ContainerController = null;
                  var _loc3_:int = param1?this._flowComposer.getControllerIndex(param1) + 1:0;
                  var _loc4_:int = param2?this._flowComposer.getControllerIndex(param2):this._flowComposer.numControllers-1;
                  while(_loc3_ <= _loc4_)
                  {
                     _loc5_ = ContainerController(this._flowComposer.getControllerAt(_loc3_));
                     _loc5_.setContentBounds(0,0,0,0);
                     _loc5_.setTextLength(0);
                     _loc5_.clearComposedLines(_loc5_.absoluteStart);
                     _loc5_.clearFloatsAt(_loc5_.absoluteStart);
                     _loc3_++;
                  }
               }
               
               protected function advanceToNextParcel() : void {
                  this.parcelHasChanged(this._parcelList.atLast()?null:this._parcelList.getParcelAt(this._parcelList.currentParcelIndex + 1));
                  this._parcelList.next();
               }
               
               protected function parcelHasChanged(param1:Parcel) : void {
                  var _loc2_:ContainerController = this._curParcel?ContainerController(this._curParcel.controller):null;
                  var _loc3_:ContainerController = param1?ContainerController(param1.controller):null;
                  if(!(_loc2_ == null) && !(this._lastGoodStart == -1))
                  {
                     _loc2_.clearFloatsAt(this._lastGoodStart);
                     this._curLine = null;
                     this._linePass = 0;
                     this._pushInFloats.length = 0;
                  }
                  if(this._curParcel != null)
                  {
                     if(this.finishParcel(_loc2_,param1))
                     {
                        if(this._parcelLeft < this._controllerLeft)
                        {
                           this._controllerLeft = this._parcelLeft;
                        }
                        if(this._parcelRight > this._controllerRight)
                        {
                           this._controllerRight = this._parcelRight;
                        }
                        if(this._parcelTop < this._controllerTop)
                        {
                           this._controllerTop = this._parcelTop;
                        }
                        if(this._parcelBottom > this._controllerBottom)
                        {
                           this._controllerBottom = this._parcelBottom;
                        }
                     }
                  }
                  if(_loc2_ != _loc3_)
                  {
                     if(_loc2_)
                     {
                        this.finishController(_loc2_);
                     }
                     this.resetControllerBounds();
                     if(this._flowComposer.numControllers > 1)
                     {
                        if(_loc2_ == null && (this._startController))
                        {
                           this.clearControllers(this._startController,_loc3_);
                        }
                        else
                        {
                           this.clearControllers(_loc2_,_loc3_);
                        }
                     }
                     if(_loc3_)
                     {
                        if(_loc2_)
                        {
                           this._startComposePosition = _loc3_.absoluteStart;
                        }
                        this.calculateControllerVisibleBounds(_loc3_);
                     }
                  }
                  this._curParcel = param1;
                  this._curParcelStart = this._curElementStart + this._curElementOffset;
                  this._atColumnStart = true;
                  this._workingTotalDepth = 0;
                  if(_loc3_)
                  {
                     this._verticalSpaceCarried = this._blockProgression == BlockProgression.RL?_loc3_.getTotalPaddingRight():_loc3_.getTotalPaddingTop();
                     this._measuring = this._blockProgression == BlockProgression.TB && (_loc3_.measureWidth) || this._blockProgression == BlockProgression.RL && (_loc3_.measureHeight);
                  }
               }
               
               private function calculateControllerVisibleBounds(param1:ContainerController) : void {
                  var _loc2_:Number = param1.measureWidth?Number.MAX_VALUE:param1.compositionWidth;
                  var _loc3_:Number = param1.horizontalScrollPosition;
                  this._controllerVisibleBoundsXTW = Twips.roundTo(this._blockProgression == BlockProgression.RL?_loc3_ - _loc2_:_loc3_);
                  this._controllerVisibleBoundsYTW = Twips.roundTo(param1.verticalScrollPosition);
                  this._controllerVisibleBoundsWidthTW = param1.measureWidth?int.MAX_VALUE:Twips.to(param1.compositionWidth);
                  this._controllerVisibleBoundsHeightTW = param1.measureHeight?int.MAX_VALUE:Twips.to(param1.compositionHeight);
               }
               
               private function getLineAdjustmentForInline(param1:TextLine, param2:String, param3:Boolean) : LeadingAdjustment {
                  var _loc10_:InlineGraphicElement = null;
                  var _loc11_:String = null;
                  var _loc12_:LeadingAdjustment = null;
                  var _loc13_:* = NaN;
                  var _loc4_:LeadingAdjustment = null;
                  var _loc5_:ParagraphElement = this._curLine.paragraph;
                  var _loc6_:FlowLeafElement = this._curElement;
                  var _loc7_:int = _loc6_.getAbsoluteStart();
                  var _loc8_:Number = _loc6_.getEffectiveFontSize();
                  var _loc9_:Number = 0;
                  while((_loc6_) && _loc7_ < this._curLine.absoluteStart + this._curLine.textLength)
                  {
                     if(_loc7_ >= this._curLine.absoluteStart || _loc7_ + _loc6_.textLength >= this._curLine.absoluteStart)
                     {
                        if(_loc6_ is InlineGraphicElement)
                        {
                           _loc10_ = _loc6_ as InlineGraphicElement;
                           if(_loc10_.effectiveFloat == Float.NONE && !(this._blockProgression == BlockProgression.RL && _loc6_.parent is TCYElement))
                           {
                              if(_loc9_ < _loc10_.getEffectiveFontSize())
                              {
                                 _loc9_ = _loc10_.getEffectiveFontSize();
                                 if(_loc9_ >= _loc8_)
                                 {
                                    _loc9_ = _loc9_;
                                    _loc11_ = _loc6_.computedFormat.dominantBaseline;
                                    if(_loc11_ == FormatValue.AUTO)
                                    {
                                       _loc11_ = LocaleUtil.dominantBaseline(_loc5_.computedFormat.locale);
                                    }
                                    if(_loc11_ == TextBaseline.IDEOGRAPHIC_CENTER)
                                    {
                                       _loc12_ = this.calculateLinePlacementAdjustment(param1,_loc11_,param2,_loc10_,param3);
                                       if(!_loc4_ || Math.abs(_loc12_.rise) > Math.abs(_loc4_.rise) || Math.abs(_loc12_.leading) > Math.abs(_loc4_.leading))
                                       {
                                          if(_loc4_)
                                          {
                                             _loc4_.rise = _loc12_.rise;
                                             _loc4_.leading = _loc12_.leading;
                                          }
                                          else
                                          {
                                             _loc4_ = _loc12_;
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                        else
                        {
                           _loc13_ = _loc6_.getEffectiveFontSize();
                           if(_loc8_ <= _loc13_)
                           {
                              _loc8_ = _loc13_;
                           }
                           if((_loc4_) && _loc9_ < _loc8_)
                           {
                              _loc4_.leading = 0;
                              _loc4_.rise = 0;
                           }
                        }
                     }
                     _loc7_ = _loc7_ + _loc6_.textLength;
                     _loc6_ = _loc6_.getNextLeaf(_loc5_);
                  }
                  return _loc4_;
               }
               
               public function get swfContext() : ISWFContext {
                  var _loc1_:ISWFContext = this._flowComposer.swfContext;
                  return _loc1_?_loc1_:GlobalSWFContext.globalSWFContext;
               }
               
               private function calculateLinePlacementAdjustment(param1:TextLine, param2:String, param3:String, param4:InlineGraphicElement, param5:Boolean) : LeadingAdjustment {
                  var _loc6_:LeadingAdjustment = new LeadingAdjustment();
                  var _loc7_:Number = param4.getEffectiveLineHeight(this._blockProgression);
                  var _loc8_:Number = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(param4.computedFormat.lineHeight,param1.textHeight);
                  if(param2 == TextBaseline.IDEOGRAPHIC_CENTER)
                  {
                     if(!param5)
                     {
                        _loc6_.rise = _loc6_.rise + (_loc7_ - _loc8_) / 2;
                     }
                     else
                     {
                        _loc6_.leading = _loc6_.leading - (_loc7_ - _loc8_) / 2;
                     }
                  }
                  return _loc6_;
               }
               
               protected function pushInsideListItemMargins(param1:TextLine) : void {
                  var _loc2_:* = NaN;
                  if((param1) && this._listItemElement.computedFormat.listStylePosition == ListStylePosition.INSIDE)
                  {
                     _loc2_ = TextFlowLine.getNumberLineInsideLineWidth(param1);
                     this._parcelList.pushInsideListItemMargin(_loc2_);
                  }
               }
               
               protected function popInsideListItemMargins(param1:TextLine) : void {
                  var _loc2_:* = NaN;
                  if((param1) && this._listItemElement.computedFormat.listStylePosition == ListStylePosition.INSIDE)
                  {
                     _loc2_ = TextFlowLine.getNumberLineInsideLineWidth(param1);
                     this._parcelList.popInsideListItemMargin(_loc2_);
                  }
               }
            }
         }
         import flashx.textLayout.compose.TextFlowLine;
         import flash.text.engine.TextLine;
         
         class AlignData extends Object
         {
            
            function AlignData(param1:TextFlowLine) {
               super();
               this.textFlowLine = param1;
            }
            
            public var textFlowLine:TextFlowLine;
            
            public var textLine:TextLine;
            
            public var lineWidth:Number;
            
            public var textAlign:String;
            
            public var leftSideGap:Number;
            
            public var rightSideGap:Number;
            
            public var textIndent:Number;
         }
         import flashx.textLayout.compose.ISWFContext;
         
         class GlobalSWFContext extends Object implements ISWFContext
         {
            
            function GlobalSWFContext() {
               super();
            }
            
            public static const globalSWFContext:GlobalSWFContext = new GlobalSWFContext();
            
            public function callInContext(param1:Function, param2:Object, param3:Array, param4:Boolean=true) : * {
               if(param4)
               {
                  return param1.apply(param2,param3);
               }
               param1.apply(param2,param3);
            }
         }
         class LeadingAdjustment extends Object
         {
            
            function LeadingAdjustment() {
               super();
            }
            
            public var rise:Number = 0;
            
            public var leading:Number = 0;
            
            public var lineHeight:Number = 0;
         }
