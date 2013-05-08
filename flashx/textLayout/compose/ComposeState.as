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
         var rslt:ComposeState = _sharedComposeState;
         if(rslt)
         {
            _sharedComposeState=null;
            return rslt;
         }
         return new ComposeState();
      }

      tlf_internal  static function releaseComposeState(state:ComposeState) : void {
         state.releaseAnyReferences();
         _sharedComposeState=state;
      }

      protected var _curLineIndex:int;

      protected var vjBeginLineIndex:int;

      protected var vjDisableThisParcel:Boolean;

      protected var _useExistingLine:Boolean;

      override protected function createParcelList() : ParcelList {
         return ParcelList.getParcelList();
      }

      override protected function releaseParcelList(list:ParcelList) : void {
         ParcelList.releaseParcelList(list);
      }

      override public function composeTextFlow(textFlow:TextFlow, composeToPosition:int, controllerEndIndex:int) : int {
         this._curLineIndex=-1;
         _curLine=null;
         this.vjBeginLineIndex=0;
         this.vjDisableThisParcel=false;
         return super.composeTextFlow(textFlow,composeToPosition,controllerEndIndex);
      }

      override protected function initializeForComposer(composer:IFlowComposer, composeToPosition:int, controllerStartIndex:int, controllerEndIndex:int) : void {
         var controllerIndex:* = 0;
         _startComposePosition=composer.damageAbsoluteStart;
         if(controllerStartIndex==-1)
         {
            controllerIndex=composer.findControllerIndexAtPosition(_startComposePosition);
            if(controllerIndex==-1)
            {
               controllerIndex=composer.numControllers-1;
               while((!(controllerIndex==0))&&(composer.getControllerAt(controllerIndex).textLength==0))
               {
                  controllerIndex--;
               }
            }
         }
         _startController=composer.getControllerAt(controllerIndex);
         if(_startController.computedFormat.verticalAlign!=VerticalAlign.TOP)
         {
            _startComposePosition=_startController.absoluteStart;
         }
         super.initializeForComposer(composer,composeToPosition,controllerIndex,controllerEndIndex);
      }

      override protected function composeInternal(composeRoot:FlowGroupElement, absStart:int) : void {
         var lineIndex:* = 0;
         super.composeInternal(composeRoot,absStart);
         if(_curElement)
         {
            lineIndex=this._curLineIndex;
            while(lineIndex<_flowComposer.numLines)
            {
               _flowComposer.getLineAt(lineIndex++).setController(null,-1);
            }
         }
      }

      override protected function doVerticalAlignment(canVerticalAlign:Boolean, nextParcel:Parcel) : void {
         var controller:ContainerController = null;
         var vjtype:String = null;
         var i:* = 0;
         var floatInfo:FloatCompositionData = null;
         var end:* = 0;
         var beginFloatIndex:* = 0;
         var endFloatIndex:* = 0;
         var lines:Array = null;
         if(((canVerticalAlign)&&(_curParcel))&&(!(this.vjBeginLineIndex==this._curLineIndex))&&(!this.vjDisableThisParcel))
         {
            controller=_curParcel.controller;
            vjtype=controller.computedFormat.verticalAlign;
            if(vjtype==VerticalAlign.JUSTIFY)
            {
               i=controller.numFloats-1;
               while((i>=0)&&(canVerticalAlign))
               {
                  floatInfo=controller.getFloatAt(i);
                  if(floatInfo.floatType!=Float.NONE)
                  {
                     canVerticalAlign=false;
                  }
                  i--;
               }
            }
            if((canVerticalAlign)&&(!(vjtype==VerticalAlign.TOP)))
            {
               end=_flowComposer.findLineIndexAtPosition(_curElementStart+_curElementOffset);
               if(this.vjBeginLineIndex<end)
               {
                  beginFloatIndex=0;
                  endFloatIndex=0;
                  lines=(_flowComposer as StandardFlowComposer).lines;
                  if(controller.numFloats>0)
                  {
                     beginFloatIndex=controller.findFloatIndexAtOrAfter(lines[this.vjBeginLineIndex].absoluteStart);
                     endFloatIndex=controller.findFloatIndexAfter(_curElementStart+_curElementOffset);
                  }
                  this.applyVerticalAlignmentToColumn(controller,vjtype,lines,this.vjBeginLineIndex,end-this.vjBeginLineIndex,beginFloatIndex,endFloatIndex);
               }
            }
         }
         this.vjDisableThisParcel=false;
         this.vjBeginLineIndex=this._curLineIndex;
      }

      override protected function applyVerticalAlignmentToColumn(controller:ContainerController, vjType:String, lines:Array, beginIndex:int, numLines:int, beginFloatIndex:int, endFloatIndex:int) : void {
         var textLine:TextLine = null;
         var line:TextFlowLine = null;
         super.applyVerticalAlignmentToColumn(controller,vjType,lines,beginIndex,numLines,beginFloatIndex,endFloatIndex);
         for each (textLine in controller.composedLines)
         {
            line=textLine.userData as TextFlowLine;
            line.createShape(_blockProgression,textLine);
         }
      }

      override protected function finalParcelAdjustment(controller:ContainerController) : void {
         var edgeAdjust:* = NaN;
         var curPara:ParagraphElement = null;
         var curParaFormat:ITextLayoutFormat = null;
         var curParaDirection:String = null;
         var lineIndex:* = 0;
         var line:TextFlowLine = null;
         var numberLine:TextLine = null;
         var numberLineStart:* = NaN;
         var minX:Number = TextLine.MAX_LINE_WIDTH;
         var minY:Number = TextLine.MAX_LINE_WIDTH;
         var maxX:Number = -TextLine.MAX_LINE_WIDTH;
         var verticalText:Boolean = _blockProgression==BlockProgression.RL;
         if(!isNaN(_parcelLogicalTop))
         {
            if(verticalText)
            {
               maxX=_parcelLogicalTop;
            }
            else
            {
               minY=_parcelLogicalTop;
            }
         }
         if(!_measuring)
         {
            if(verticalText)
            {
               minY=_accumulatedMinimumStart;
            }
            else
            {
               minX=_accumulatedMinimumStart;
            }
         }
         else
         {
            lineIndex=_flowComposer.findLineIndexAtPosition(_curParcelStart);
            while(lineIndex<this._curLineIndex)
            {
               line=_flowComposer.getLineAt(lineIndex);
               if(line.paragraph!=curPara)
               {
                  curPara=line.paragraph;
                  curParaFormat=curPara.computedFormat;
                  curParaDirection=curParaFormat.direction;
                  if(curParaDirection!=Direction.LTR)
                  {
                     edgeAdjust=curParaFormat.paragraphEndIndent;
                  }
               }
               if(curParaDirection==Direction.LTR)
               {
                  edgeAdjust=Math.max(line.lineOffset,0);
               }
               edgeAdjust=verticalText?line.y-edgeAdjust:line.x-edgeAdjust;
               numberLine=TextFlowLine.findNumberLine(line.getTextLine(true));
               if(numberLine)
               {
                  numberLineStart=verticalText?numberLine.y+line.y:numberLine.x+line.x;
                  edgeAdjust=Math.min(edgeAdjust,numberLineStart);
               }
               if(verticalText)
               {
                  minY=Math.min(edgeAdjust,minY);
               }
               else
               {
                  minX=Math.min(edgeAdjust,minX);
               }
               lineIndex++;
            }
         }
         if((!(minX==TextLine.MAX_LINE_WIDTH))&&(Math.abs(minX-_parcelLeft)>=1))
         {
            _parcelLeft=minX;
         }
         if((!(maxX==-TextLine.MAX_LINE_WIDTH))&&(Math.abs(maxX-_parcelRight)>=1))
         {
            _parcelRight=maxX;
         }
         if((!(minY==TextLine.MAX_LINE_WIDTH))&&(Math.abs(minY-_parcelTop)>=1))
         {
            _parcelTop=minY;
         }
      }

      override protected function endLine(textLine:TextLine) : void {
         super.endLine(textLine);
         if(!this._useExistingLine)
         {
            (_flowComposer as StandardFlowComposer).addLine(_curLine,this._curLineIndex);
         }
         commitLastLineState(_curLine);
         this._curLineIndex++;
      }

      override protected function composeParagraphElement(elem:ParagraphElement, absStart:int) : Boolean {
         if(this._curLineIndex<0)
         {
            this._curLineIndex=_flowComposer.findLineIndexAtPosition(_curElementStart+_curElementOffset);
         }
         return super.composeParagraphElement(elem,absStart);
      }

      override protected function composeNextLine() : TextLine {
         var numberLine:TextLine = null;
         var textLine:TextLine = null;
         var peekLine:TextLine = null;
         var isRTL:* = false;
         var newDepth:* = NaN;
         var startCompose:int = _curElementStart+_curElementOffset-_curParaStart;
         var line:TextFlowLine = this._curLineIndex>_flowComposer.numLines?(_flowComposer as StandardFlowComposer).lines[this._curLineIndex]:null;
         var useExistingLine:Boolean = (line)&&((!line.isDamaged())||(line.validity==FlowDamageType.GEOMETRY));
         if((_listItemElement)&&(_listItemElement.getAbsoluteStart()==_curElementStart+_curElementOffset))
         {
            if((useExistingLine)&&(!((peekLine=line.peekTextLine())==null)))
            {
               numberLine=TextFlowLine.findNumberLine(peekLine);
            }
            else
            {
               isRTL=_curParaElement.computedFormat.direction==Direction.RTL;
               numberLine=TextFlowLine.createNumberLine(_listItemElement,_curParaElement,_flowComposer.swfContext,isRTL?_parcelList.rightMargin:_parcelList.leftMargin);
            }
            pushInsideListItemMargins(numberLine);
         }
         _parcelList.getLineSlug(_lineSlug,0,1,_textIndent,_curParaFormat.direction==Direction.LTR);
         if((useExistingLine)&&(!(Twips.to(_lineSlug.width)==line.outerTargetWidthTW)))
         {
            useExistingLine=false;
         }
         _curLine=useExistingLine?line:null;
         loop0:
         for(;true;if(!textLine)
         {
            textLine=_curLine.getTextLine(true);
            },if(fitLineToParcel(textLine,!useExistingLine,numberLine))
            {
               if(_curLine.validity==FlowDamageType.GEOMETRY)
               {
                  _curLine.clearDamage();
               }
               this._useExistingLine=useExistingLine;
               popInsideListItemMargins(numberLine);
               return textLine;
               },_curLine=null,if(_parcelList.atEnd())
               {
                  popInsideListItemMargins(numberLine);
                  return null;
                  })
                  {
                     while(!_curLine)
                     {
                        useExistingLine=false;
                        textLine=this.createTextLine(_lineSlug.width,!_lineSlug.wrapsKnockOut);
                        if(textLine)
                        {
                           continue loop0;
                        }
                        newDepth=_curParcel.findNextTransition(_lineSlug.depth);
                        if(newDepth<Number.MAX_VALUE)
                        {
                           _parcelList.addTotalDepth(newDepth-_lineSlug.depth);
                           if(!_parcelList.getLineSlug(_lineSlug,0,1,_textIndent,_curParaFormat.direction==Direction.LTR))
                           {
                              return null;
                           }
                           continue;
                        }
                        advanceToNextParcel();
                        if(!_parcelList.atEnd())
                        {
                           if(_parcelList.getLineSlug(_lineSlug,0,1,_textIndent,_curParaFormat.direction==Direction.LTR))
                           {
                              continue;
                           }
                        }
                        popInsideListItemMargins(numberLine);
                        return null;
                     }
                  }
                  while(!_curLine)
                  {
                     useExistingLine=false;
                     textLine=this.createTextLine(_lineSlug.width,!_lineSlug.wrapsKnockOut);
                     if(textLine)
                     {
                        continue loop0;
                     }
                     newDepth=_curParcel.findNextTransition(_lineSlug.depth);
                     if(newDepth<Number.MAX_VALUE)
                     {
                        _parcelList.addTotalDepth(newDepth-_lineSlug.depth);
                        if(!_parcelList.getLineSlug(_lineSlug,0,1,_textIndent,_curParaFormat.direction==Direction.LTR))
                        {
                           return null;
                        }
                        continue;
                     }
                     advanceToNextParcel();
                     if(!_parcelList.atEnd())
                     {
                        if(_parcelList.getLineSlug(_lineSlug,0,1,_textIndent,_curParaFormat.direction==Direction.LTR))
                        {
                           continue;
                        }
                     }
                     popInsideListItemMargins(numberLine);
                     return null;
                  }
                  continue loop0;
      }

      override protected function createTextLine(targetWidth:Number, allowEmergencyBreaks:Boolean) : TextLine {
         _curLine=new TextFlowLine(null,null);
         var textLine:TextLine = super.createTextLine(targetWidth,allowEmergencyBreaks);
         if(textLine)
         {
            textLine.doubleClickEnabled=true;
         }
         else
         {
            _curLine=null;
         }
         return textLine;
      }
   }

}