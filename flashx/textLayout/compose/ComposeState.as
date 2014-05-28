package flashx.textLayout.compose
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.formats.VerticalAlign;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.formats.Float;
   import flash.text.engine.TextLine;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.utils.Twips;
   
   use namespace tlf_internal;
   
   public class ComposeState extends BaseCompose
   {
      
      public function ComposeState() {
         super();
      }
      
      private static var _sharedComposeState:ComposeState;
      
      tlf_internal  static function getComposeState() : ComposeState {
         var _loc1_:ComposeState = _sharedComposeState;
         if(_loc1_)
         {
            _sharedComposeState = null;
            return _loc1_;
         }
         return new ComposeState();
      }
      
      tlf_internal  static function releaseComposeState(param1:ComposeState) : void {
         param1.releaseAnyReferences();
         _sharedComposeState = param1;
      }
      
      protected var _curLineIndex:int;
      
      protected var vjBeginLineIndex:int;
      
      protected var vjDisableThisParcel:Boolean;
      
      protected var _useExistingLine:Boolean;
      
      override protected function createParcelList() : ParcelList {
         return ParcelList.getParcelList();
      }
      
      override protected function releaseParcelList(param1:ParcelList) : void {
         ParcelList.releaseParcelList(param1);
      }
      
      override public function composeTextFlow(param1:TextFlow, param2:int, param3:int) : int {
         this._curLineIndex = -1;
         _curLine = null;
         this.vjBeginLineIndex = 0;
         this.vjDisableThisParcel = false;
         return super.composeTextFlow(param1,param2,param3);
      }
      
      override protected function initializeForComposer(param1:IFlowComposer, param2:int, param3:int, param4:int) : void {
         var _loc5_:* = 0;
         _startComposePosition = param1.damageAbsoluteStart;
         if(param3 == -1)
         {
            _loc5_ = param1.findControllerIndexAtPosition(_startComposePosition);
            if(_loc5_ == -1)
            {
               _loc5_ = param1.numControllers-1;
               while(!(_loc5_ == 0) && param1.getControllerAt(_loc5_).textLength == 0)
               {
                  _loc5_--;
               }
            }
         }
         _startController = param1.getControllerAt(_loc5_);
         if(_startController.computedFormat.verticalAlign != VerticalAlign.TOP)
         {
            _startComposePosition = _startController.absoluteStart;
         }
         super.initializeForComposer(param1,param2,_loc5_,param4);
      }
      
      override protected function composeInternal(param1:FlowGroupElement, param2:int) : void {
         var _loc3_:* = 0;
         super.composeInternal(param1,param2);
         if(_curElement)
         {
            _loc3_ = this._curLineIndex;
            while(_loc3_ < _flowComposer.numLines)
            {
               _flowComposer.getLineAt(_loc3_++).setController(null,-1);
            }
         }
      }
      
      override protected function doVerticalAlignment(param1:Boolean, param2:Parcel) : void {
         var _loc3_:ContainerController = null;
         var _loc4_:String = null;
         var _loc5_:* = 0;
         var _loc6_:FloatCompositionData = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:Array = null;
         if(((param1) && (_curParcel)) && (!(this.vjBeginLineIndex == this._curLineIndex)) && !this.vjDisableThisParcel)
         {
            _loc3_ = _curParcel.controller;
            _loc4_ = _loc3_.computedFormat.verticalAlign;
            if(_loc4_ == VerticalAlign.JUSTIFY)
            {
               _loc5_ = _loc3_.numFloats-1;
               while(_loc5_ >= 0 && (param1))
               {
                  _loc6_ = _loc3_.getFloatAt(_loc5_);
                  if(_loc6_.floatType != Float.NONE)
                  {
                     param1 = false;
                  }
                  _loc5_--;
               }
            }
            if((param1) && !(_loc4_ == VerticalAlign.TOP))
            {
               _loc7_ = _flowComposer.findLineIndexAtPosition(_curElementStart + _curElementOffset);
               if(this.vjBeginLineIndex < _loc7_)
               {
                  _loc8_ = 0;
                  _loc9_ = 0;
                  _loc10_ = (_flowComposer as StandardFlowComposer).lines;
                  if(_loc3_.numFloats > 0)
                  {
                     _loc8_ = _loc3_.findFloatIndexAtOrAfter(_loc10_[this.vjBeginLineIndex].absoluteStart);
                     _loc9_ = _loc3_.findFloatIndexAfter(_curElementStart + _curElementOffset);
                  }
                  this.applyVerticalAlignmentToColumn(_loc3_,_loc4_,_loc10_,this.vjBeginLineIndex,_loc7_ - this.vjBeginLineIndex,_loc8_,_loc9_);
               }
            }
         }
         this.vjDisableThisParcel = false;
         this.vjBeginLineIndex = this._curLineIndex;
      }
      
      override protected function applyVerticalAlignmentToColumn(param1:ContainerController, param2:String, param3:Array, param4:int, param5:int, param6:int, param7:int) : void {
         var _loc8_:TextLine = null;
         var _loc9_:TextFlowLine = null;
         super.applyVerticalAlignmentToColumn(param1,param2,param3,param4,param5,param6,param7);
         for each (_loc8_ in param1.composedLines)
         {
            _loc9_ = _loc8_.userData as TextFlowLine;
            _loc9_.createShape(_blockProgression,_loc8_);
         }
      }
      
      override protected function finalParcelAdjustment(param1:ContainerController) : void {
         var _loc6_:* = NaN;
         var _loc7_:ParagraphElement = null;
         var _loc8_:ITextLayoutFormat = null;
         var _loc9_:String = null;
         var _loc10_:* = 0;
         var _loc11_:TextFlowLine = null;
         var _loc12_:TextLine = null;
         var _loc13_:* = NaN;
         var _loc2_:Number = TextLine.MAX_LINE_WIDTH;
         var _loc3_:Number = TextLine.MAX_LINE_WIDTH;
         var _loc4_:Number = -TextLine.MAX_LINE_WIDTH;
         var _loc5_:* = _blockProgression == BlockProgression.RL;
         if(!isNaN(_parcelLogicalTop))
         {
            if(_loc5_)
            {
               _loc4_ = _parcelLogicalTop;
            }
            else
            {
               _loc3_ = _parcelLogicalTop;
            }
         }
         if(!_measuring)
         {
            if(_loc5_)
            {
               _loc3_ = _accumulatedMinimumStart;
            }
            else
            {
               _loc2_ = _accumulatedMinimumStart;
            }
         }
         else
         {
            _loc10_ = _flowComposer.findLineIndexAtPosition(_curParcelStart);
            while(_loc10_ < this._curLineIndex)
            {
               _loc11_ = _flowComposer.getLineAt(_loc10_);
               if(_loc11_.paragraph != _loc7_)
               {
                  _loc7_ = _loc11_.paragraph;
                  _loc8_ = _loc7_.computedFormat;
                  _loc9_ = _loc8_.direction;
                  if(_loc9_ != Direction.LTR)
                  {
                     _loc6_ = _loc8_.paragraphEndIndent;
                  }
               }
               if(_loc9_ == Direction.LTR)
               {
                  _loc6_ = Math.max(_loc11_.lineOffset,0);
               }
               _loc6_ = _loc5_?_loc11_.y - _loc6_:_loc11_.x - _loc6_;
               _loc12_ = TextFlowLine.findNumberLine(_loc11_.getTextLine(true));
               if(_loc12_)
               {
                  _loc13_ = _loc5_?_loc12_.y + _loc11_.y:_loc12_.x + _loc11_.x;
                  _loc6_ = Math.min(_loc6_,_loc13_);
               }
               if(_loc5_)
               {
                  _loc3_ = Math.min(_loc6_,_loc3_);
               }
               else
               {
                  _loc2_ = Math.min(_loc6_,_loc2_);
               }
               _loc10_++;
            }
         }
         if(!(_loc2_ == TextLine.MAX_LINE_WIDTH) && Math.abs(_loc2_ - _parcelLeft) >= 1)
         {
            _parcelLeft = _loc2_;
         }
         if(!(_loc4_ == -TextLine.MAX_LINE_WIDTH) && Math.abs(_loc4_ - _parcelRight) >= 1)
         {
            _parcelRight = _loc4_;
         }
         if(!(_loc3_ == TextLine.MAX_LINE_WIDTH) && Math.abs(_loc3_ - _parcelTop) >= 1)
         {
            _parcelTop = _loc3_;
         }
      }
      
      override protected function endLine(param1:TextLine) : void {
         super.endLine(param1);
         if(!this._useExistingLine)
         {
            (_flowComposer as StandardFlowComposer).addLine(_curLine,this._curLineIndex);
         }
         commitLastLineState(_curLine);
         this._curLineIndex++;
      }
      
      override protected function composeParagraphElement(param1:ParagraphElement, param2:int) : Boolean {
         if(this._curLineIndex < 0)
         {
            this._curLineIndex = _flowComposer.findLineIndexAtPosition(_curElementStart + _curElementOffset);
         }
         return super.composeParagraphElement(param1,param2);
      }
      
      override protected function composeNextLine() : TextLine {
         var _loc4_:TextLine = null;
         var _loc5_:TextLine = null;
         var _loc6_:TextLine = null;
         var _loc7_:* = false;
         var _loc8_:* = NaN;
         var _loc1_:int = _curElementStart + _curElementOffset - _curParaStart;
         var _loc2_:TextFlowLine = this._curLineIndex < _flowComposer.numLines?(_flowComposer as StandardFlowComposer).lines[this._curLineIndex]:null;
         var _loc3_:Boolean = (_loc2_) && (!_loc2_.isDamaged() || _loc2_.validity == FlowDamageType.GEOMETRY);
         if((_listItemElement) && _listItemElement.getAbsoluteStart() == _curElementStart + _curElementOffset)
         {
            if((_loc3_) && !((_loc6_ = _loc2_.peekTextLine()) == null))
            {
               _loc4_ = TextFlowLine.findNumberLine(_loc6_);
            }
            else
            {
               _loc7_ = _curParaElement.computedFormat.direction == Direction.RTL;
               _loc4_ = TextFlowLine.createNumberLine(_listItemElement,_curParaElement,_flowComposer.swfContext,_loc7_?_parcelList.rightMargin:_parcelList.leftMargin);
            }
            pushInsideListItemMargins(_loc4_);
         }
         _parcelList.getLineSlug(_lineSlug,0,1,_textIndent,_curParaFormat.direction == Direction.LTR);
         if((_loc3_) && !(Twips.to(_lineSlug.width) == _loc2_.outerTargetWidthTW))
         {
            _loc3_ = false;
         }
         _curLine = _loc3_?_loc2_:null;
         loop0:
         while(true)
         {
            while(true)
            {
               if(!_curLine)
               {
                  _loc3_ = false;
                  _loc5_ = this.createTextLine(_lineSlug.width,!_lineSlug.wrapsKnockOut);
                  if(!_loc5_)
                  {
                     _loc8_ = _curParcel.findNextTransition(_lineSlug.depth);
                     if(_loc8_ < Number.MAX_VALUE)
                     {
                        _parcelList.addTotalDepth(_loc8_ - _lineSlug.depth);
                        if(!_parcelList.getLineSlug(_lineSlug,0,1,_textIndent,_curParaFormat.direction == Direction.LTR))
                        {
                           return null;
                        }
                        continue;
                     }
                     advanceToNextParcel();
                     if(!_parcelList.atEnd())
                     {
                        if(_parcelList.getLineSlug(_lineSlug,0,1,_textIndent,_curParaFormat.direction == Direction.LTR))
                        {
                           continue;
                        }
                        break;
                     }
                     break;
                     break;
                  }
               }
               if(!_loc5_)
               {
                  _loc5_ = _curLine.getTextLine(true);
               }
               if(fitLineToParcel(_loc5_,!_loc3_,_loc4_))
               {
                  break loop0;
               }
               _curLine = null;
               if(_parcelList.atEnd())
               {
                  popInsideListItemMargins(_loc4_);
                  return null;
               }
               continue loop0;
            }
            popInsideListItemMargins(_loc4_);
            return null;
         }
         if(_curLine.validity == FlowDamageType.GEOMETRY)
         {
            _curLine.clearDamage();
         }
         this._useExistingLine = _loc3_;
         popInsideListItemMargins(_loc4_);
         return _loc5_;
      }
      
      override protected function createTextLine(param1:Number, param2:Boolean) : TextLine {
         _curLine = new TextFlowLine(null,null);
         var _loc3_:TextLine = super.createTextLine(param1,param2);
         if(_loc3_)
         {
            _loc3_.doubleClickEnabled = true;
         }
         else
         {
            _curLine = null;
         }
         return _loc3_;
      }
   }
}
