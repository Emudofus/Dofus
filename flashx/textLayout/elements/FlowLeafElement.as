package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.FormatValue;
   import flash.text.engine.TextRotation;
   import flash.text.engine.TextBaseline;
   import flashx.textLayout.utils.LocaleUtil;
   import flash.text.engine.ElementFormat;
   import flashx.textLayout.compose.ISWFContext;
   import flash.text.engine.FontMetrics;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flash.text.engine.TypographicCase;
   import flashx.textLayout.formats.TLFTypographicCase;
   import flash.text.engine.FontDescription;
   import flashx.textLayout.compose.FlowComposerBase;
   import flashx.textLayout.formats.BaselineShift;
   import flash.geom.Rectangle;
   import flash.text.engine.TextLine;
   import flash.text.engine.ContentElement;
   import flashx.textLayout.events.FlowElementEventDispatcher;
   import flash.events.IEventDispatcher;
   import flashx.textLayout.events.ModelChange;
   import flash.text.engine.TextElement;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.utils.CharacterUtil;
   import flash.display.Shape;
   import flashx.textLayout.formats.IMEStatus;
   import flashx.textLayout.formats.TextDecoration;
   import flashx.textLayout.formats.BackgroundColor;
   import flash.display.Graphics;
   
   use namespace tlf_internal;
   
   public class FlowLeafElement extends FlowElement
   {
      
      public function FlowLeafElement() {
         this._hasAttachedListeners = false;
         super();
      }
      
      tlf_internal  static function resolveDomBaseline(param1:ITextLayoutFormat, param2:ParagraphElement) : String {
         var _loc3_:String = param1.dominantBaseline;
         if(_loc3_ == FormatValue.AUTO)
         {
            if(param1.textRotation == TextRotation.ROTATE_270)
            {
               _loc3_ = TextBaseline.IDEOGRAPHIC_CENTER;
            }
            else
            {
               if(param2 != null)
               {
                  _loc3_ = param2.getEffectiveDominantBaseline();
               }
               else
               {
                  _loc3_ = LocaleUtil.dominantBaseline(param1.locale);
               }
            }
         }
         return _loc3_;
      }
      
      tlf_internal  static function computeElementFormatHelper(param1:ITextLayoutFormat, param2:ParagraphElement, param3:ISWFContext) : ElementFormat {
         var _loc7_:FontMetrics = null;
         var _loc4_:ElementFormat = new ElementFormat();
         _loc4_.alignmentBaseline = param1.alignmentBaseline;
         _loc4_.alpha = Number(param1.textAlpha);
         _loc4_.breakOpportunity = param1.breakOpportunity;
         _loc4_.color = uint(param1.color);
         _loc4_.dominantBaseline = resolveDomBaseline(param1,param2);
         _loc4_.digitCase = param1.digitCase;
         _loc4_.digitWidth = param1.digitWidth;
         _loc4_.ligatureLevel = param1.ligatureLevel;
         _loc4_.fontSize = Number(param1.fontSize);
         _loc4_.kerning = param1.kerning;
         _loc4_.locale = param1.locale;
         _loc4_.trackingLeft = TextLayoutFormat.trackingLeftProperty.computeActualPropertyValue(param1.trackingLeft,_loc4_.fontSize);
         _loc4_.trackingRight = TextLayoutFormat.trackingRightProperty.computeActualPropertyValue(param1.trackingRight,_loc4_.fontSize);
         _loc4_.textRotation = param1.textRotation;
         _loc4_.baselineShift = -TextLayoutFormat.baselineShiftProperty.computeActualPropertyValue(param1.baselineShift,_loc4_.fontSize);
         switch(param1.typographicCase)
         {
            case TLFTypographicCase.LOWERCASE_TO_SMALL_CAPS:
               _loc4_.typographicCase = TypographicCase.CAPS_AND_SMALL_CAPS;
               break;
            case TLFTypographicCase.CAPS_TO_SMALL_CAPS:
               _loc4_.typographicCase = TypographicCase.SMALL_CAPS;
               break;
            default:
               _loc4_.typographicCase = param1.typographicCase;
         }
         var _loc5_:FontDescription = new FontDescription();
         _loc5_.fontWeight = param1.fontWeight;
         _loc5_.fontPosture = param1.fontStyle;
         _loc5_.fontName = param1.fontFamily;
         _loc5_.renderingMode = param1.renderingMode;
         _loc5_.cffHinting = param1.cffHinting;
         if(GlobalSettings.resolveFontLookupFunction == null)
         {
            _loc5_.fontLookup = param1.fontLookup;
         }
         else
         {
            _loc5_.fontLookup = GlobalSettings.resolveFontLookupFunction(param3?FlowComposerBase.computeBaseSWFContext(param3):null,param1);
         }
         var _loc6_:Function = GlobalSettings.fontMapperFunction;
         if(_loc6_ != null)
         {
            _loc6_(_loc5_);
         }
         _loc4_.fontDescription = _loc5_;
         if(param1.baselineShift == BaselineShift.SUPERSCRIPT || param1.baselineShift == BaselineShift.SUBSCRIPT)
         {
            if(param3)
            {
               _loc7_ = param3.callInContext(_loc4_.getFontMetrics,_loc4_,null,true);
            }
            else
            {
               _loc7_ = _loc4_.getFontMetrics();
            }
            if(param1.baselineShift == BaselineShift.SUPERSCRIPT)
            {
               _loc4_.baselineShift = _loc7_.superscriptOffset * _loc4_.fontSize;
               _loc4_.fontSize = _loc7_.superscriptScale * _loc4_.fontSize;
            }
            else
            {
               _loc4_.baselineShift = _loc7_.subscriptOffset * _loc4_.fontSize;
               _loc4_.fontSize = _loc7_.subscriptScale * _loc4_.fontSize;
            }
         }
         return _loc4_;
      }
      
      tlf_internal  static function getCSSInlineBoxHelper(param1:ITextLayoutFormat, param2:FontMetrics, param3:TextLine, param4:ParagraphElement=null) : Rectangle {
         var _loc14_:* = NaN;
         var _loc5_:Rectangle = param2.emBox;
         var _loc6_:Number = -_loc5_.top;
         var _loc7_:Number = _loc5_.bottom;
         var _loc8_:Number = _loc5_.height;
         var _loc9_:Number = param1.fontSize;
         var _loc10_:Number = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(param1.lineHeight,_loc9_);
         var _loc11_:Number = (_loc10_ - _loc8_) / 2;
         _loc5_.top = _loc5_.top - _loc11_;
         _loc5_.bottom = _loc5_.bottom + _loc11_;
         var _loc12_:String = resolveDomBaseline(param1,param4);
         switch(_loc12_)
         {
            case TextBaseline.ASCENT:
            case TextBaseline.IDEOGRAPHIC_TOP:
               _loc5_.offset(0,_loc6_);
               break;
            case TextBaseline.IDEOGRAPHIC_CENTER:
               _loc5_.offset(0,_loc6_ - _loc8_ / 2);
               break;
            case TextBaseline.ROMAN:
               break;
            case TextBaseline.DESCENT:
            case TextBaseline.IDEOGRAPHIC_BOTTOM:
               _loc5_.offset(0,-_loc7_);
         }
         var _loc13_:String = param1.alignmentBaseline == TextBaseline.USE_DOMINANT_BASELINE?_loc12_:param1.alignmentBaseline;
         _loc5_.offset(0,param3.getBaselinePosition(_loc13_));
         if(param1.baselineShift == BaselineShift.SUPERSCRIPT)
         {
            _loc14_ = param2.superscriptOffset * _loc9_;
         }
         else
         {
            if(param1.baselineShift == BaselineShift.SUBSCRIPT)
            {
               _loc14_ = param2.subscriptOffset * _loc9_;
            }
            else
            {
               _loc14_ = -param1.baselineShift;
            }
         }
         _loc5_.offset(0,_loc14_);
         return _loc5_;
      }
      
      protected var _blockElement:ContentElement;
      
      protected var _text:String;
      
      private var _hasAttachedListeners:Boolean;
      
      tlf_internal var _eventMirror:FlowElementEventDispatcher = null;
      
      override tlf_internal function createContentElement() : void {
         if(_computedFormat)
         {
            this._blockElement.elementFormat = this.computeElementFormat();
         }
         if(parent)
         {
            parent.insertBlockElement(this,this._blockElement);
         }
      }
      
      override tlf_internal function releaseContentElement() : void {
         this._blockElement = null;
         _computedFormat = null;
      }
      
      private function blockElementExists() : Boolean {
         return !(this._blockElement == null);
      }
      
      tlf_internal function getBlockElement() : ContentElement {
         if(!this._blockElement)
         {
            this.createContentElement();
         }
         return this._blockElement;
      }
      
      override tlf_internal function getEventMirror() : IEventDispatcher {
         if(!this._eventMirror)
         {
            this._eventMirror = new FlowElementEventDispatcher(this);
         }
         return this._eventMirror;
      }
      
      override tlf_internal function hasActiveEventMirror() : Boolean {
         return (this._eventMirror) && !(this._eventMirror._listenerCount == 0);
      }
      
      override tlf_internal function appendElementsForDelayedUpdate(param1:TextFlow, param2:String) : void {
         if(param2 == ModelChange.ELEMENT_ADDED)
         {
            if(this.hasActiveEventMirror())
            {
               param1.incInteractiveObjectCount();
            }
         }
         else
         {
            if(param2 == ModelChange.ELEMENT_REMOVAL)
            {
               if(this.hasActiveEventMirror())
               {
                  param1.decInteractiveObjectCount();
               }
            }
         }
         super.appendElementsForDelayedUpdate(param1,param2);
      }
      
      public function get text() : String {
         return this._text;
      }
      
      tlf_internal function getElementFormat() : ElementFormat {
         if(!this._blockElement)
         {
            this.createContentElement();
         }
         return this._blockElement.elementFormat;
      }
      
      override tlf_internal function setParentAndRelativeStart(param1:FlowGroupElement, param2:int) : void {
         if(param1 == parent)
         {
            return;
         }
         var _loc3_:* = !(this._blockElement == null);
         if((this._blockElement) && (parent) && (parent.hasBlockElement()))
         {
            parent.removeBlockElement(this,this._blockElement);
         }
         if((param1) && (!param1.hasBlockElement()) && (this._blockElement))
         {
            param1.createContentElement();
         }
         super.setParentAndRelativeStart(param1,param2);
         if(parent)
         {
            if(parent.hasBlockElement())
            {
               if(!this._blockElement)
               {
                  this.createContentElement();
               }
               else
               {
                  if(_loc3_)
                  {
                     parent.insertBlockElement(this,this._blockElement);
                  }
               }
            }
            else
            {
               if(this._blockElement)
               {
                  this.releaseContentElement();
               }
            }
         }
      }
      
      tlf_internal function quickInitializeForSplit(param1:FlowLeafElement, param2:int, param3:TextElement) : void {
         setTextLength(param2);
         this._blockElement = param3;
         if(this._blockElement)
         {
            this._text = this._blockElement.text;
         }
         quickCloneTextLayoutFormat(param1);
         var _loc4_:TextFlow = param1.getTextFlow();
         if(_loc4_ == null || _loc4_.formatResolver == null)
         {
            _computedFormat = param1._computedFormat;
            if(this._blockElement)
            {
               this._blockElement.elementFormat = param1.getElementFormat();
            }
         }
      }
      
      public function getNextLeaf(param1:FlowGroupElement=null) : FlowLeafElement {
         if(!parent)
         {
            return null;
         }
         return parent.getNextLeafHelper(param1,this);
      }
      
      public function getPreviousLeaf(param1:FlowGroupElement=null) : FlowLeafElement {
         if(!parent)
         {
            return null;
         }
         return parent.getPreviousLeafHelper(param1,this);
      }
      
      override public function getCharAtPosition(param1:int) : String {
         return this._text?this._text.charAt(param1):"";
      }
      
      override tlf_internal function normalizeRange(param1:uint, param2:uint) : void {
         if(this._blockElement)
         {
         }
      }
      
      public function getComputedFontMetrics() : FontMetrics {
         if(!this._blockElement)
         {
            this.createContentElement();
         }
         var _loc1_:ElementFormat = this._blockElement.elementFormat;
         if(!_loc1_)
         {
            return null;
         }
         var _loc2_:TextFlow = getTextFlow();
         if((_loc2_) && (_loc2_.flowComposer) && (_loc2_.flowComposer.swfContext))
         {
            return _loc2_.flowComposer.swfContext.callInContext(_loc1_.getFontMetrics,_loc1_,null,true);
         }
         return _loc1_.getFontMetrics();
      }
      
      tlf_internal function computeElementFormat() : ElementFormat {
         var _loc1_:TextFlow = getTextFlow();
         return computeElementFormatHelper(_computedFormat,getParagraph(),(_loc1_) && (_loc1_.flowComposer)?_loc1_.flowComposer.swfContext:null);
      }
      
      override public function get computedFormat() : ITextLayoutFormat {
         if(!_computedFormat)
         {
            _computedFormat = doComputeTextLayoutFormat();
            if(this._blockElement)
            {
               this._blockElement.elementFormat = this.computeElementFormat();
            }
         }
         return _computedFormat;
      }
      
      tlf_internal function getEffectiveLineHeight(param1:String) : Number {
         if(param1 == BlockProgression.RL && parent is TCYElement)
         {
            return 0;
         }
         return TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(_computedFormat.lineHeight,this.getEffectiveFontSize());
      }
      
      tlf_internal function getCSSInlineBox(param1:String, param2:TextLine, param3:ParagraphElement=null, param4:ISWFContext=null) : Rectangle {
         if(param1 == BlockProgression.RL && parent is TCYElement)
         {
            return null;
         }
         return getCSSInlineBoxHelper(this.computedFormat,this.getComputedFontMetrics(),param2,param3);
      }
      
      tlf_internal function getEffectiveFontSize() : Number {
         return Number(this.computedFormat.fontSize);
      }
      
      tlf_internal function getSpanBoundsOnLine(param1:TextLine, param2:String) : Array {
         var _loc10_:String = null;
         var _loc3_:TextFlowLine = TextFlowLine(param1.userData);
         var _loc4_:int = _loc3_.paragraph.getAbsoluteStart();
         var _loc5_:int = _loc3_.absoluteStart + _loc3_.textLength - _loc4_;
         var _loc6_:int = getAbsoluteStart() - _loc4_;
         var _loc7_:int = _loc6_ + this.text.length;
         var _loc8_:int = Math.max(_loc6_,_loc3_.absoluteStart - _loc4_);
         if(_loc7_ >= _loc5_)
         {
            _loc7_ = _loc5_;
            _loc10_ = this.text;
            while(_loc7_ > _loc8_ && (CharacterUtil.isWhitespace(_loc10_.charCodeAt(_loc7_ - _loc6_-1))))
            {
               _loc7_--;
            }
         }
         var _loc9_:Array = [];
         _loc3_.calculateSelectionBounds(param1,_loc9_,_loc8_,_loc7_,param2,[_loc3_.textHeight,0]);
         return _loc9_;
      }
      
      tlf_internal function updateIMEAdornments(param1:TextLine, param2:String, param3:String) : void {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:Rectangle = null;
         var _loc14_:* = NaN;
         var _loc15_:* = NaN;
         var _loc16_:Shape = null;
         var _loc17_:TextFlowLine = null;
         var _loc18_:* = 0;
         var _loc19_:TCYElement = null;
         var _loc20_:Rectangle = null;
         var _loc21_:* = NaN;
         var _loc4_:FontMetrics = this.getComputedFontMetrics();
         var _loc5_:Array = this.getSpanBoundsOnLine(param1,param2);
         var _loc6_:* = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = 1;
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = 0;
            _loc11_ = 0;
            _loc12_ = 0;
            if(param3 == IMEStatus.SELECTED_CONVERTED || param3 == IMEStatus.SELECTED_RAW)
            {
               _loc7_ = 2;
            }
            if(param3 == IMEStatus.SELECTED_RAW || param3 == IMEStatus.NOT_SELECTED_RAW || param3 == IMEStatus.DEAD_KEY_INPUT_STATE)
            {
               _loc8_ = 10921638;
            }
            _loc13_ = _loc5_[_loc6_] as Rectangle;
            _loc14_ = this.calculateStrikeThrough(param1,param2,_loc4_);
            _loc15_ = this.calculateUnderlineOffset(_loc14_,param2,_loc4_,param1);
            if(param2 != BlockProgression.RL)
            {
               _loc9_ = _loc13_.topLeft.x + 1;
               _loc11_ = _loc13_.topLeft.x + _loc13_.width-1;
               _loc10_ = _loc15_;
               _loc12_ = _loc15_;
            }
            else
            {
               _loc17_ = param1.userData as TextFlowLine;
               _loc18_ = this.getAbsoluteStart() - _loc17_.absoluteStart;
               _loc10_ = _loc13_.topLeft.y + 1;
               _loc12_ = _loc13_.topLeft.y + _loc13_.height-1;
               if(_loc18_ < 0 || param1.atomCount <= _loc18_ || !(param1.getAtomTextRotation(_loc18_) == TextRotation.ROTATE_0))
               {
                  _loc9_ = _loc15_;
                  _loc11_ = _loc15_;
               }
               else
               {
                  _loc19_ = this.getParentByType(TCYElement) as TCYElement;
                  if(this.getAbsoluteStart() + this.textLength == _loc19_.getAbsoluteStart() + _loc19_.textLength)
                  {
                     _loc20_ = new Rectangle();
                     _loc19_.calculateAdornmentBounds(_loc19_,param1,param2,_loc20_);
                     _loc21_ = _loc4_.underlineOffset + _loc4_.underlineThickness / 2;
                     _loc10_ = _loc20_.top + 1;
                     _loc12_ = _loc20_.bottom-1;
                     _loc9_ = _loc13_.bottomRight.x + _loc21_;
                     _loc11_ = _loc13_.bottomRight.x + _loc21_;
                  }
               }
            }
            _loc16_ = new Shape();
            _loc16_.alpha = 1;
            _loc16_.graphics.beginFill(_loc8_);
            _loc16_.graphics.lineStyle(_loc7_,_loc8_,_loc16_.alpha);
            _loc16_.graphics.moveTo(_loc9_,_loc10_);
            _loc16_.graphics.lineTo(_loc11_,_loc12_);
            _loc16_.graphics.endFill();
            param1.addChild(_loc16_);
            _loc6_++;
         }
      }
      
      tlf_internal function updateAdornments(param1:TextLine, param2:String) : int {
         var _loc3_:Array = null;
         var _loc4_:* = 0;
         if((_computedFormat.textDecoration == TextDecoration.UNDERLINE) || (_computedFormat.lineThrough) || _computedFormat.backgroundAlpha > 0 && !(_computedFormat.backgroundColor == BackgroundColor.TRANSPARENT))
         {
            _loc3_ = this.getSpanBoundsOnLine(param1,param2);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               this.updateAdornmentsOnBounds(param1,param2,_loc3_[_loc4_]);
               _loc4_++;
            }
            return _loc3_.length;
         }
         return 0;
      }
      
      private function updateAdornmentsOnBounds(param1:TextLine, param2:String, param3:Rectangle) : void {
         var _loc6_:Shape = null;
         var _loc7_:Graphics = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:TextFlowLine = null;
         var _loc11_:* = 0;
         var _loc12_:TCYElement = null;
         var _loc13_:ParagraphElement = null;
         var _loc14_:String = null;
         var _loc15_:* = false;
         var _loc16_:Rectangle = null;
         var _loc17_:* = NaN;
         var _loc18_:* = NaN;
         var _loc19_:* = NaN;
         var _loc20_:TextLine = null;
         var _loc4_:FontMetrics = this.getComputedFontMetrics();
         var _loc5_:* = !((_computedFormat.textDecoration == TextDecoration.UNDERLINE) || (_computedFormat.lineThrough));
         if(!_loc5_)
         {
            _loc6_ = new Shape();
            _loc6_.alpha = Number(_computedFormat.textAlpha);
            _loc7_ = _loc6_.graphics;
            _loc8_ = this.calculateStrikeThrough(param1,param2,_loc4_);
            _loc9_ = this.calculateUnderlineOffset(_loc8_,param2,_loc4_,param1);
         }
         if(param2 != BlockProgression.RL)
         {
            this.addBackgroundRect(param1,_loc4_,param3,true);
            if(_computedFormat.textDecoration == TextDecoration.UNDERLINE)
            {
               _loc7_.lineStyle(_loc4_.underlineThickness,_computedFormat.color as uint);
               _loc7_.moveTo(param3.topLeft.x,_loc9_);
               _loc7_.lineTo(param3.topLeft.x + param3.width,_loc9_);
            }
            if(_computedFormat.lineThrough)
            {
               _loc7_.lineStyle(_loc4_.strikethroughThickness,_computedFormat.color as uint);
               _loc7_.moveTo(param3.topLeft.x,_loc8_);
               _loc7_.lineTo(param3.topLeft.x + param3.width,_loc8_);
            }
         }
         else
         {
            _loc10_ = param1.userData as TextFlowLine;
            _loc11_ = this.getAbsoluteStart() - _loc10_.absoluteStart;
            if(_loc11_ < 0 || param1.atomCount <= _loc11_ || !(param1.getAtomTextRotation(_loc11_) == TextRotation.ROTATE_0))
            {
               this.addBackgroundRect(param1,_loc4_,param3,false);
               if(_computedFormat.textDecoration == TextDecoration.UNDERLINE)
               {
                  _loc7_.lineStyle(_loc4_.underlineThickness,_computedFormat.color as uint);
                  _loc7_.moveTo(_loc9_,param3.topLeft.y);
                  _loc7_.lineTo(_loc9_,param3.topLeft.y + param3.height);
               }
               if(_computedFormat.lineThrough == true)
               {
                  _loc7_.lineStyle(_loc4_.strikethroughThickness,_computedFormat.color as uint);
                  _loc7_.moveTo(-_loc8_,param3.topLeft.y);
                  _loc7_.lineTo(-_loc8_,param3.topLeft.y + param3.height);
               }
            }
            else
            {
               this.addBackgroundRect(param1,_loc4_,param3,true,true);
               if(!_loc5_)
               {
                  _loc12_ = this.getParentByType(TCYElement) as TCYElement;
                  _loc13_ = this.getParentByType(ParagraphElement) as ParagraphElement;
                  _loc14_ = _loc13_.computedFormat.locale.toLowerCase();
                  _loc15_ = !(_loc14_.indexOf("zh") == 0);
                  if(this.getAbsoluteStart() + this.textLength == _loc12_.getAbsoluteStart() + _loc12_.textLength)
                  {
                     _loc16_ = new Rectangle();
                     _loc12_.calculateAdornmentBounds(_loc12_,param1,param2,_loc16_);
                     if(_computedFormat.textDecoration == TextDecoration.UNDERLINE)
                     {
                        _loc7_.lineStyle(_loc4_.underlineThickness,_computedFormat.color as uint);
                        _loc17_ = _loc4_.underlineOffset + _loc4_.underlineThickness / 2;
                        _loc18_ = _loc15_?param3.right:param3.left;
                        if(!_loc15_)
                        {
                           _loc17_ = -_loc17_;
                        }
                        _loc7_.moveTo(_loc18_ + _loc17_,_loc16_.top);
                        _loc7_.lineTo(_loc18_ + _loc17_,_loc16_.bottom);
                     }
                     if(_computedFormat.lineThrough == true)
                     {
                        _loc19_ = param3.bottomRight.x - _loc16_.x;
                        _loc19_ = _loc19_ / 2;
                        _loc19_ = _loc19_ + _loc16_.x;
                        _loc7_.lineStyle(_loc4_.strikethroughThickness,_computedFormat.color as uint);
                        _loc7_.moveTo(_loc19_,_loc16_.top);
                        _loc7_.lineTo(_loc19_,_loc16_.bottom);
                     }
                  }
               }
            }
         }
         if(_loc6_)
         {
            _loc20_ = (param1.userData as TextFlowLine).peekTextLine();
            if((_loc20_) && !(param1 == _loc20_))
            {
               param1 = _loc20_;
            }
            param1.addChild(_loc6_);
         }
      }
      
      private function addBackgroundRect(param1:TextLine, param2:FontMetrics, param3:Rectangle, param4:Boolean, param5:Boolean=false) : void {
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc15_:* = NaN;
         if(_computedFormat.backgroundAlpha == 0 || _computedFormat.backgroundColor == BackgroundColor.TRANSPARENT)
         {
            return;
         }
         var _loc6_:TextFlow = this.getTextFlow();
         if(!_loc6_.getBackgroundManager())
         {
            return;
         }
         var _loc7_:Rectangle = param3.clone();
         if(!param5 && (_computedFormat.baselineShift == BaselineShift.SUPERSCRIPT || _computedFormat.baselineShift == BaselineShift.SUBSCRIPT))
         {
            _loc10_ = this.getEffectiveFontSize();
            _loc11_ = param2.strikethroughOffset + param2.strikethroughThickness / 2;
            if(_computedFormat.baselineShift == BaselineShift.SUPERSCRIPT)
            {
               _loc12_ = -3 * _loc11_;
               _loc9_ = -param2.superscriptOffset * _loc10_;
               _loc13_ = param1.getBaselinePosition(TextBaseline.DESCENT) - param1.getBaselinePosition(TextBaseline.ROMAN);
               _loc8_ = _loc12_ + _loc9_ + _loc13_;
               if(param4)
               {
                  if(_loc8_ > _loc7_.height)
                  {
                     _loc7_.y = _loc7_.y - (_loc8_ - _loc7_.height);
                     _loc7_.height = _loc8_;
                  }
               }
               else
               {
                  if(_loc8_ > _loc7_.width)
                  {
                     _loc7_.width = _loc8_;
                  }
               }
            }
            else
            {
               _loc14_ = -_loc11_;
               _loc9_ = param2.subscriptOffset * _loc10_;
               _loc15_ = param1.getBaselinePosition(TextBaseline.ROMAN) - param1.getBaselinePosition(TextBaseline.ASCENT);
               _loc8_ = _loc15_ + _loc9_ + _loc14_;
               if(param4)
               {
                  if(_loc8_ > _loc7_.height)
                  {
                     _loc7_.height = _loc8_;
                  }
               }
               else
               {
                  if(_loc8_ > _loc7_.width)
                  {
                     _loc7_.x = _loc7_.x - (_loc8_ - _loc7_.width);
                     _loc7_.width = _loc8_;
                  }
               }
            }
         }
         _loc6_.backgroundManager.addRect(param1,this,_loc7_,_computedFormat.backgroundColor,_computedFormat.backgroundAlpha);
      }
      
      tlf_internal function calculateStrikeThrough(param1:TextLine, param2:String, param3:FontMetrics) : Number {
         var _loc4_:* = 0;
         var _loc5_:Number = this.getEffectiveFontSize();
         if(_computedFormat.baselineShift == BaselineShift.SUPERSCRIPT)
         {
            _loc4_ = -(param3.superscriptOffset * _loc5_);
         }
         else
         {
            if(_computedFormat.baselineShift == BaselineShift.SUBSCRIPT)
            {
               _loc4_ = -(param3.subscriptOffset * _loc5_ / param3.subscriptScale);
            }
            else
            {
               _loc4_ = TextLayoutFormat.baselineShiftProperty.computeActualPropertyValue(_computedFormat.baselineShift,_loc5_);
            }
         }
         var _loc6_:String = resolveDomBaseline(this.computedFormat,getParagraph());
         var _loc7_:String = this.computedFormat.alignmentBaseline;
         var _loc8_:Number = param1.getBaselinePosition(_loc6_);
         if(!(_loc7_ == TextBaseline.USE_DOMINANT_BASELINE) && !(_loc7_ == _loc6_))
         {
            _loc8_ = param1.getBaselinePosition(_loc7_);
         }
         var _loc9_:Number = param3.strikethroughOffset;
         if(_loc6_ == TextBaseline.IDEOGRAPHIC_CENTER)
         {
            _loc9_ = 0;
         }
         else
         {
            if(_loc6_ == TextBaseline.IDEOGRAPHIC_TOP || _loc6_ == TextBaseline.ASCENT)
            {
               _loc9_ = _loc9_ * -2;
               _loc9_ = _loc9_ - 2 * param3.strikethroughThickness;
            }
            else
            {
               if(_loc6_ == TextBaseline.IDEOGRAPHIC_BOTTOM || _loc6_ == TextBaseline.DESCENT)
               {
                  _loc9_ = _loc9_ * 2;
                  _loc9_ = _loc9_ + 2 * param3.strikethroughThickness;
               }
               else
               {
                  _loc9_ = _loc9_ - param3.strikethroughThickness;
               }
            }
         }
         _loc9_ = _loc9_ + (_loc8_ - _loc4_);
         return _loc9_;
      }
      
      tlf_internal function calculateUnderlineOffset(param1:Number, param2:String, param3:FontMetrics, param4:TextLine) : Number {
         var _loc7_:ParagraphElement = null;
         var _loc5_:Number = param3.underlineOffset + param3.underlineThickness;
         var _loc6_:Number = param3.strikethroughOffset;
         if(param2 != BlockProgression.RL)
         {
            _loc5_ = _loc5_ + (param1 - _loc6_ + param3.underlineThickness / 2);
         }
         else
         {
            _loc7_ = this.getParagraph();
            if(_loc7_.computedFormat.locale.toLowerCase().indexOf("zh") == 0)
            {
               _loc5_ = -_loc5_;
               _loc5_ = _loc5_ - (param1 - _loc6_ + param3.underlineThickness * 2);
            }
            else
            {
               _loc5_ = _loc5_ - (-_loc5_ + param1 + _loc6_ + param3.underlineThickness / 2);
            }
         }
         return _loc5_;
      }
   }
}
