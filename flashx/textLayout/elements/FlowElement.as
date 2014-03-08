package flashx.textLayout.elements
{
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.formats.FormatValue;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flashx.textLayout.events.ModelChange;
   import flash.events.IEventDispatcher;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.compose.IFlowComposer;
   
   use namespace tlf_internal;
   
   public class FlowElement extends Object implements ITextLayoutFormat
   {
      
      public function FlowElement() {
         super();
         if(this.abstract)
         {
            throw new Error(GlobalSettings.resourceStringFunction("invalidFlowElementConstruct"));
         }
         else
         {
            return;
         }
      }
      
      private static const idString:String = "id";
      
      private static const typeNameString:String = "typeName";
      
      private static const impliedElementString:String = "impliedElement";
      
      tlf_internal  static var _scratchTextLayoutFormat:TextLayoutFormat = new TextLayoutFormat();
      
      tlf_internal  static function createTextLayoutFormatPrototype(param1:ITextLayoutFormat, param2:TextLayoutFormat) : TextLayoutFormat {
         var _loc5_:Object = null;
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc9_:Property = null;
         var _loc11_:TextLayoutFormat = null;
         var _loc12_:Object = null;
         var _loc13_:TextLayoutFormat = null;
         var _loc14_:Object = null;
         var _loc3_:* = true;
         var _loc4_:* = false;
         if(param2)
         {
            _loc5_ = param2.getStyles();
            if(_loc5_.hasNonInheritedStyles !== undefined)
            {
               if(_loc5_.hasNonInheritedStyles === true)
               {
                  _loc12_ = Property.createObjectWithPrototype(_loc5_);
                  TextLayoutFormat.resetModifiedNoninheritedStyles(_loc12_);
                  _loc5_.hasNonInheritedStyles = _loc12_;
                  _loc5_ = _loc12_;
               }
               else
               {
                  _loc5_ = _loc5_.hasNonInheritedStyles;
               }
               _loc3_ = false;
            }
         }
         else
         {
            param2 = TextLayoutFormat.defaultFormat as TextLayoutFormat;
            _loc5_ = param2.getStyles();
         }
         var _loc6_:Object = Property.createObjectWithPrototype(_loc5_);
         var _loc10_:* = false;
         if(param1 != null)
         {
            _loc13_ = param1 as TextLayoutFormat;
            if(_loc13_)
            {
               _loc14_ = _loc13_.getStyles();
               for (_loc7_ in _loc14_)
               {
                  _loc8_ = _loc14_[_loc7_];
                  if(_loc8_ == FormatValue.INHERIT)
                  {
                     if(param2)
                     {
                        _loc9_ = TextLayoutFormat.description[_loc7_];
                        if((_loc9_) && !_loc9_.inherited)
                        {
                           _loc8_ = param2[_loc7_];
                           if(_loc6_[_loc7_] != _loc8_)
                           {
                              _loc6_[_loc7_] = _loc8_;
                              _loc10_ = true;
                              _loc4_ = true;
                           }
                        }
                     }
                  }
                  else
                  {
                     if(_loc6_[_loc7_] != _loc8_)
                     {
                        _loc9_ = TextLayoutFormat.description[_loc7_];
                        if((_loc9_) && !_loc9_.inherited)
                        {
                           _loc10_ = true;
                        }
                        _loc6_[_loc7_] = _loc8_;
                        _loc4_ = true;
                     }
                  }
               }
            }
            else
            {
               for each (_loc9_ in TextLayoutFormat.description)
               {
                  _loc7_ = _loc9_.name;
                  _loc8_ = param1[_loc7_];
                  if(_loc8_ !== undefined)
                  {
                     if(_loc8_ == FormatValue.INHERIT)
                     {
                        if(param2)
                        {
                           if(!_loc9_.inherited)
                           {
                              _loc8_ = param2[_loc7_];
                              if(_loc6_[_loc7_] != _loc8_)
                              {
                                 _loc6_[_loc7_] = _loc8_;
                                 _loc10_ = true;
                                 _loc4_ = true;
                              }
                           }
                        }
                     }
                     else
                     {
                        if(_loc6_[_loc7_] != _loc8_)
                        {
                           if(!_loc9_.inherited)
                           {
                              _loc10_ = true;
                           }
                           _loc6_[_loc7_] = _loc8_;
                           _loc4_ = true;
                        }
                     }
                  }
               }
            }
         }
         if(!_loc4_)
         {
            if(_loc3_)
            {
               return param2;
            }
            _loc11_ = new TextLayoutFormat();
            _loc11_.setStyles(_loc6_,true);
            return _loc11_;
         }
         if(_loc10_)
         {
            _loc6_.hasNonInheritedStyles = true;
            _loc6_.setPropertyIsEnumerable("hasNonInheritedStyles",false);
         }
         else
         {
            if(_loc6_.hasNonInheritedStyles !== undefined)
            {
               _loc6_.hasNonInheritedStyles = undefined;
               _loc6_.setPropertyIsEnumerable("hasNonInheritedStyles",false);
            }
         }
         _loc11_ = new TextLayoutFormat();
         _loc11_.setStyles(_loc6_,false);
         return _loc11_;
      }
      
      private var _parent:FlowGroupElement;
      
      private var _format:FlowValueHolder;
      
      protected var _computedFormat:TextLayoutFormat;
      
      private var _parentRelativeStart:int = 0;
      
      private var _textLength:int = 0;
      
      public function initialized(param1:Object, param2:String) : void {
         this.id = param2;
      }
      
      protected function get abstract() : Boolean {
         return true;
      }
      
      public function get userStyles() : Object {
         return this._format?this._format.userStyles:null;
      }
      
      public function set userStyles(param1:Object) : void {
         var _loc2_:String = null;
         for (_loc2_ in this.userStyles)
         {
            this.setStyle(_loc2_,undefined);
         }
         for (_loc2_ in param1)
         {
            if(!TextLayoutFormat.description.hasOwnProperty(_loc2_))
            {
               this.setStyle(_loc2_,param1[_loc2_]);
            }
         }
      }
      
      public function get coreStyles() : Object {
         return this._format?this._format.coreStyles:null;
      }
      
      public function get styles() : Object {
         return this._format?this._format.styles:null;
      }
      
      tlf_internal function setStylesInternal(param1:Object) : void {
         if(param1)
         {
            this.writableTextLayoutFormat().setStyles(Property.shallowCopy(param1),false);
         }
         else
         {
            if(this._format)
            {
               this._format.clearStyles();
            }
         }
         this.formatChanged();
      }
      
      public function equalUserStyles(param1:FlowElement) : Boolean {
         return Property.equalStyles(this.userStyles,param1.userStyles,null);
      }
      
      tlf_internal function equalStylesForMerge(param1:FlowElement) : Boolean {
         return this.id == param1.id && this.typeName == param1.typeName && (TextLayoutFormat.isEqual(param1.format,this.format));
      }
      
      public function shallowCopy(param1:int=0, param2:int=-1) : FlowElement {
         var _loc3_:FlowElement = new getDefinitionByName(getQualifiedClassName(this)) as Class();
         if(this._format != null)
         {
            _loc3_._format = new FlowValueHolder(this._format);
         }
         return _loc3_;
      }
      
      public function deepCopy(param1:int=0, param2:int=-1) : FlowElement {
         if(param2 == -1)
         {
            param2 = this._textLength;
         }
         return this.shallowCopy(param1,param2);
      }
      
      public function getText(param1:int=0, param2:int=-1, param3:String="\n") : String {
         return "";
      }
      
      public function splitAtPosition(param1:int) : FlowElement {
         if(param1 < 0 || param1 > this._textLength)
         {
            throw RangeError(GlobalSettings.resourceStringFunction("invalidSplitAtPosition"));
         }
         else
         {
            return this;
         }
      }
      
      tlf_internal function get bindableElement() : Boolean {
         return this.getPrivateStyle("bindable") == true;
      }
      
      tlf_internal function set bindableElement(param1:Boolean) : void {
         this.setPrivateStyle("bindable",param1);
      }
      
      tlf_internal function mergeToPreviousIfPossible() : Boolean {
         return false;
      }
      
      tlf_internal function createContentElement() : void {
      }
      
      tlf_internal function releaseContentElement() : void {
      }
      
      public function get parent() : FlowGroupElement {
         return this._parent;
      }
      
      tlf_internal function setParentAndRelativeStart(param1:FlowGroupElement, param2:int) : void {
         this._parent = param1;
         this._parentRelativeStart = param2;
         this.attributesChanged(false);
      }
      
      tlf_internal function setParentAndRelativeStartOnly(param1:FlowGroupElement, param2:int) : void {
         this._parent = param1;
         this._parentRelativeStart = param2;
      }
      
      public function get textLength() : int {
         return this._textLength;
      }
      
      tlf_internal function setTextLength(param1:int) : void {
         this._textLength = param1;
      }
      
      public function get parentRelativeStart() : int {
         return this._parentRelativeStart;
      }
      
      tlf_internal function setParentRelativeStart(param1:int) : void {
         this._parentRelativeStart = param1;
      }
      
      public function get parentRelativeEnd() : int {
         return this._parentRelativeStart + this._textLength;
      }
      
      tlf_internal function getAncestorWithContainer() : ContainerFormattedElement {
         var _loc2_:ContainerFormattedElement = null;
         var _loc1_:FlowElement = this;
         while(_loc1_)
         {
            _loc2_ = _loc1_ as ContainerFormattedElement;
            if(_loc2_)
            {
               if(!_loc2_._parent || (_loc2_.flowComposer))
               {
                  return _loc2_;
               }
            }
            _loc1_ = _loc1_._parent;
         }
         return null;
      }
      
      tlf_internal function getPrivateStyle(param1:String) : * {
         return this._format?this._format.getPrivateData(param1):undefined;
      }
      
      tlf_internal function setPrivateStyle(param1:String, param2:*) : void {
         if(this.getPrivateStyle(param1) != param2)
         {
            this.writableTextLayoutFormat().setPrivateData(param1,param2);
            this.modelChanged(ModelChange.STYLE_SELECTOR_CHANGED,this,0,this._textLength);
         }
      }
      
      public function get id() : String {
         return this.getPrivateStyle(idString);
      }
      
      public function set id(param1:String) : void {
         return this.setPrivateStyle(idString,param1);
      }
      
      public function get typeName() : String {
         var _loc1_:String = this.getPrivateStyle(typeNameString);
         return _loc1_?_loc1_:this.defaultTypeName;
      }
      
      public function set typeName(param1:String) : void {
         if(param1 != this.typeName)
         {
            this.setPrivateStyle(typeNameString,param1 == this.defaultTypeName?undefined:param1);
         }
      }
      
      tlf_internal function get defaultTypeName() : String {
         return null;
      }
      
      tlf_internal function get impliedElement() : Boolean {
         return !(this.getPrivateStyle(impliedElementString) === undefined);
      }
      
      tlf_internal function set impliedElement(param1:*) : void {
         this.setPrivateStyle(impliedElementString,param1);
      }
      
      public function get color() : * {
         return this._format?this._format.color:undefined;
      }
      
      public function set color(param1:*) : void {
         this.writableTextLayoutFormat().color = param1;
         this.formatChanged();
      }
      
      public function get backgroundColor() : * {
         return this._format?this._format.backgroundColor:undefined;
      }
      
      public function set backgroundColor(param1:*) : void {
         this.writableTextLayoutFormat().backgroundColor = param1;
         this.formatChanged();
      }
      
      public function get lineThrough() : * {
         return this._format?this._format.lineThrough:undefined;
      }
      
      public function set lineThrough(param1:*) : void {
         this.writableTextLayoutFormat().lineThrough = param1;
         this.formatChanged();
      }
      
      public function get textAlpha() : * {
         return this._format?this._format.textAlpha:undefined;
      }
      
      public function set textAlpha(param1:*) : void {
         this.writableTextLayoutFormat().textAlpha = param1;
         this.formatChanged();
      }
      
      public function get backgroundAlpha() : * {
         return this._format?this._format.backgroundAlpha:undefined;
      }
      
      public function set backgroundAlpha(param1:*) : void {
         this.writableTextLayoutFormat().backgroundAlpha = param1;
         this.formatChanged();
      }
      
      public function get fontSize() : * {
         return this._format?this._format.fontSize:undefined;
      }
      
      public function set fontSize(param1:*) : void {
         this.writableTextLayoutFormat().fontSize = param1;
         this.formatChanged();
      }
      
      public function get baselineShift() : * {
         return this._format?this._format.baselineShift:undefined;
      }
      
      public function set baselineShift(param1:*) : void {
         this.writableTextLayoutFormat().baselineShift = param1;
         this.formatChanged();
      }
      
      public function get trackingLeft() : * {
         return this._format?this._format.trackingLeft:undefined;
      }
      
      public function set trackingLeft(param1:*) : void {
         this.writableTextLayoutFormat().trackingLeft = param1;
         this.formatChanged();
      }
      
      public function get trackingRight() : * {
         return this._format?this._format.trackingRight:undefined;
      }
      
      public function set trackingRight(param1:*) : void {
         this.writableTextLayoutFormat().trackingRight = param1;
         this.formatChanged();
      }
      
      public function get lineHeight() : * {
         return this._format?this._format.lineHeight:undefined;
      }
      
      public function set lineHeight(param1:*) : void {
         this.writableTextLayoutFormat().lineHeight = param1;
         this.formatChanged();
      }
      
      public function get breakOpportunity() : * {
         return this._format?this._format.breakOpportunity:undefined;
      }
      
      public function set breakOpportunity(param1:*) : void {
         this.writableTextLayoutFormat().breakOpportunity = param1;
         this.formatChanged();
      }
      
      public function get digitCase() : * {
         return this._format?this._format.digitCase:undefined;
      }
      
      public function set digitCase(param1:*) : void {
         this.writableTextLayoutFormat().digitCase = param1;
         this.formatChanged();
      }
      
      public function get digitWidth() : * {
         return this._format?this._format.digitWidth:undefined;
      }
      
      public function set digitWidth(param1:*) : void {
         this.writableTextLayoutFormat().digitWidth = param1;
         this.formatChanged();
      }
      
      public function get dominantBaseline() : * {
         return this._format?this._format.dominantBaseline:undefined;
      }
      
      public function set dominantBaseline(param1:*) : void {
         this.writableTextLayoutFormat().dominantBaseline = param1;
         this.formatChanged();
      }
      
      public function get kerning() : * {
         return this._format?this._format.kerning:undefined;
      }
      
      public function set kerning(param1:*) : void {
         this.writableTextLayoutFormat().kerning = param1;
         this.formatChanged();
      }
      
      public function get ligatureLevel() : * {
         return this._format?this._format.ligatureLevel:undefined;
      }
      
      public function set ligatureLevel(param1:*) : void {
         this.writableTextLayoutFormat().ligatureLevel = param1;
         this.formatChanged();
      }
      
      public function get alignmentBaseline() : * {
         return this._format?this._format.alignmentBaseline:undefined;
      }
      
      public function set alignmentBaseline(param1:*) : void {
         this.writableTextLayoutFormat().alignmentBaseline = param1;
         this.formatChanged();
      }
      
      public function get locale() : * {
         return this._format?this._format.locale:undefined;
      }
      
      public function set locale(param1:*) : void {
         this.writableTextLayoutFormat().locale = param1;
         this.formatChanged();
      }
      
      public function get typographicCase() : * {
         return this._format?this._format.typographicCase:undefined;
      }
      
      public function set typographicCase(param1:*) : void {
         this.writableTextLayoutFormat().typographicCase = param1;
         this.formatChanged();
      }
      
      public function get fontFamily() : * {
         return this._format?this._format.fontFamily:undefined;
      }
      
      public function set fontFamily(param1:*) : void {
         this.writableTextLayoutFormat().fontFamily = param1;
         this.formatChanged();
      }
      
      public function get textDecoration() : * {
         return this._format?this._format.textDecoration:undefined;
      }
      
      public function set textDecoration(param1:*) : void {
         this.writableTextLayoutFormat().textDecoration = param1;
         this.formatChanged();
      }
      
      public function get fontWeight() : * {
         return this._format?this._format.fontWeight:undefined;
      }
      
      public function set fontWeight(param1:*) : void {
         this.writableTextLayoutFormat().fontWeight = param1;
         this.formatChanged();
      }
      
      public function get fontStyle() : * {
         return this._format?this._format.fontStyle:undefined;
      }
      
      public function set fontStyle(param1:*) : void {
         this.writableTextLayoutFormat().fontStyle = param1;
         this.formatChanged();
      }
      
      public function get whiteSpaceCollapse() : * {
         return this._format?this._format.whiteSpaceCollapse:undefined;
      }
      
      public function set whiteSpaceCollapse(param1:*) : void {
         this.writableTextLayoutFormat().whiteSpaceCollapse = param1;
         this.formatChanged();
      }
      
      public function get renderingMode() : * {
         return this._format?this._format.renderingMode:undefined;
      }
      
      public function set renderingMode(param1:*) : void {
         this.writableTextLayoutFormat().renderingMode = param1;
         this.formatChanged();
      }
      
      public function get cffHinting() : * {
         return this._format?this._format.cffHinting:undefined;
      }
      
      public function set cffHinting(param1:*) : void {
         this.writableTextLayoutFormat().cffHinting = param1;
         this.formatChanged();
      }
      
      public function get fontLookup() : * {
         return this._format?this._format.fontLookup:undefined;
      }
      
      public function set fontLookup(param1:*) : void {
         this.writableTextLayoutFormat().fontLookup = param1;
         this.formatChanged();
      }
      
      public function get textRotation() : * {
         return this._format?this._format.textRotation:undefined;
      }
      
      public function set textRotation(param1:*) : void {
         this.writableTextLayoutFormat().textRotation = param1;
         this.formatChanged();
      }
      
      public function get textIndent() : * {
         return this._format?this._format.textIndent:undefined;
      }
      
      public function set textIndent(param1:*) : void {
         this.writableTextLayoutFormat().textIndent = param1;
         this.formatChanged();
      }
      
      public function get paragraphStartIndent() : * {
         return this._format?this._format.paragraphStartIndent:undefined;
      }
      
      public function set paragraphStartIndent(param1:*) : void {
         this.writableTextLayoutFormat().paragraphStartIndent = param1;
         this.formatChanged();
      }
      
      public function get paragraphEndIndent() : * {
         return this._format?this._format.paragraphEndIndent:undefined;
      }
      
      public function set paragraphEndIndent(param1:*) : void {
         this.writableTextLayoutFormat().paragraphEndIndent = param1;
         this.formatChanged();
      }
      
      public function get paragraphSpaceBefore() : * {
         return this._format?this._format.paragraphSpaceBefore:undefined;
      }
      
      public function set paragraphSpaceBefore(param1:*) : void {
         this.writableTextLayoutFormat().paragraphSpaceBefore = param1;
         this.formatChanged();
      }
      
      public function get paragraphSpaceAfter() : * {
         return this._format?this._format.paragraphSpaceAfter:undefined;
      }
      
      public function set paragraphSpaceAfter(param1:*) : void {
         this.writableTextLayoutFormat().paragraphSpaceAfter = param1;
         this.formatChanged();
      }
      
      public function get textAlign() : * {
         return this._format?this._format.textAlign:undefined;
      }
      
      public function set textAlign(param1:*) : void {
         this.writableTextLayoutFormat().textAlign = param1;
         this.formatChanged();
      }
      
      public function get textAlignLast() : * {
         return this._format?this._format.textAlignLast:undefined;
      }
      
      public function set textAlignLast(param1:*) : void {
         this.writableTextLayoutFormat().textAlignLast = param1;
         this.formatChanged();
      }
      
      public function get textJustify() : * {
         return this._format?this._format.textJustify:undefined;
      }
      
      public function set textJustify(param1:*) : void {
         this.writableTextLayoutFormat().textJustify = param1;
         this.formatChanged();
      }
      
      public function get justificationRule() : * {
         return this._format?this._format.justificationRule:undefined;
      }
      
      public function set justificationRule(param1:*) : void {
         this.writableTextLayoutFormat().justificationRule = param1;
         this.formatChanged();
      }
      
      public function get justificationStyle() : * {
         return this._format?this._format.justificationStyle:undefined;
      }
      
      public function set justificationStyle(param1:*) : void {
         this.writableTextLayoutFormat().justificationStyle = param1;
         this.formatChanged();
      }
      
      public function get direction() : * {
         return this._format?this._format.direction:undefined;
      }
      
      public function set direction(param1:*) : void {
         this.writableTextLayoutFormat().direction = param1;
         this.formatChanged();
      }
      
      public function get wordSpacing() : * {
         return this._format?this._format.wordSpacing:undefined;
      }
      
      public function set wordSpacing(param1:*) : void {
         this.writableTextLayoutFormat().wordSpacing = param1;
         this.formatChanged();
      }
      
      public function get tabStops() : * {
         return this._format?this._format.tabStops:undefined;
      }
      
      public function set tabStops(param1:*) : void {
         this.writableTextLayoutFormat().tabStops = param1;
         this.formatChanged();
      }
      
      public function get leadingModel() : * {
         return this._format?this._format.leadingModel:undefined;
      }
      
      public function set leadingModel(param1:*) : void {
         this.writableTextLayoutFormat().leadingModel = param1;
         this.formatChanged();
      }
      
      public function get columnGap() : * {
         return this._format?this._format.columnGap:undefined;
      }
      
      public function set columnGap(param1:*) : void {
         this.writableTextLayoutFormat().columnGap = param1;
         this.formatChanged();
      }
      
      public function get paddingLeft() : * {
         return this._format?this._format.paddingLeft:undefined;
      }
      
      public function set paddingLeft(param1:*) : void {
         this.writableTextLayoutFormat().paddingLeft = param1;
         this.formatChanged();
      }
      
      public function get paddingTop() : * {
         return this._format?this._format.paddingTop:undefined;
      }
      
      public function set paddingTop(param1:*) : void {
         this.writableTextLayoutFormat().paddingTop = param1;
         this.formatChanged();
      }
      
      public function get paddingRight() : * {
         return this._format?this._format.paddingRight:undefined;
      }
      
      public function set paddingRight(param1:*) : void {
         this.writableTextLayoutFormat().paddingRight = param1;
         this.formatChanged();
      }
      
      public function get paddingBottom() : * {
         return this._format?this._format.paddingBottom:undefined;
      }
      
      public function set paddingBottom(param1:*) : void {
         this.writableTextLayoutFormat().paddingBottom = param1;
         this.formatChanged();
      }
      
      public function get columnCount() : * {
         return this._format?this._format.columnCount:undefined;
      }
      
      public function set columnCount(param1:*) : void {
         this.writableTextLayoutFormat().columnCount = param1;
         this.formatChanged();
      }
      
      public function get columnWidth() : * {
         return this._format?this._format.columnWidth:undefined;
      }
      
      public function set columnWidth(param1:*) : void {
         this.writableTextLayoutFormat().columnWidth = param1;
         this.formatChanged();
      }
      
      public function get firstBaselineOffset() : * {
         return this._format?this._format.firstBaselineOffset:undefined;
      }
      
      public function set firstBaselineOffset(param1:*) : void {
         this.writableTextLayoutFormat().firstBaselineOffset = param1;
         this.formatChanged();
      }
      
      public function get verticalAlign() : * {
         return this._format?this._format.verticalAlign:undefined;
      }
      
      public function set verticalAlign(param1:*) : void {
         this.writableTextLayoutFormat().verticalAlign = param1;
         this.formatChanged();
      }
      
      public function get blockProgression() : * {
         return this._format?this._format.blockProgression:undefined;
      }
      
      public function set blockProgression(param1:*) : void {
         this.writableTextLayoutFormat().blockProgression = param1;
         this.formatChanged();
      }
      
      public function get lineBreak() : * {
         return this._format?this._format.lineBreak:undefined;
      }
      
      public function set lineBreak(param1:*) : void {
         this.writableTextLayoutFormat().lineBreak = param1;
         this.formatChanged();
      }
      
      public function get listStyleType() : * {
         return this._format?this._format.listStyleType:undefined;
      }
      
      public function set listStyleType(param1:*) : void {
         this.writableTextLayoutFormat().listStyleType = param1;
         this.formatChanged();
      }
      
      public function get listStylePosition() : * {
         return this._format?this._format.listStylePosition:undefined;
      }
      
      public function set listStylePosition(param1:*) : void {
         this.writableTextLayoutFormat().listStylePosition = param1;
         this.formatChanged();
      }
      
      public function get listAutoPadding() : * {
         return this._format?this._format.listAutoPadding:undefined;
      }
      
      public function set listAutoPadding(param1:*) : void {
         this.writableTextLayoutFormat().listAutoPadding = param1;
         this.formatChanged();
      }
      
      public function get clearFloats() : * {
         return this._format?this._format.clearFloats:undefined;
      }
      
      public function set clearFloats(param1:*) : void {
         this.writableTextLayoutFormat().clearFloats = param1;
         this.formatChanged();
      }
      
      public function get styleName() : * {
         return this._format?this._format.styleName:undefined;
      }
      
      public function set styleName(param1:*) : void {
         this.writableTextLayoutFormat().styleName = param1;
         this.styleSelectorChanged();
      }
      
      public function get linkNormalFormat() : * {
         return this._format?this._format.linkNormalFormat:undefined;
      }
      
      public function set linkNormalFormat(param1:*) : void {
         this.writableTextLayoutFormat().linkNormalFormat = param1;
         this.formatChanged();
      }
      
      public function get linkActiveFormat() : * {
         return this._format?this._format.linkActiveFormat:undefined;
      }
      
      public function set linkActiveFormat(param1:*) : void {
         this.writableTextLayoutFormat().linkActiveFormat = param1;
         this.formatChanged();
      }
      
      public function get linkHoverFormat() : * {
         return this._format?this._format.linkHoverFormat:undefined;
      }
      
      public function set linkHoverFormat(param1:*) : void {
         this.writableTextLayoutFormat().linkHoverFormat = param1;
         this.formatChanged();
      }
      
      public function get listMarkerFormat() : * {
         return this._format?this._format.listMarkerFormat:undefined;
      }
      
      public function set listMarkerFormat(param1:*) : void {
         this.writableTextLayoutFormat().listMarkerFormat = param1;
         this.formatChanged();
      }
      
      public function get format() : ITextLayoutFormat {
         return this._format;
      }
      
      public function set format(param1:ITextLayoutFormat) : void {
         if(param1 == this._format)
         {
            return;
         }
         var _loc2_:String = this.styleName;
         if(param1 == null)
         {
            this._format.clearStyles();
         }
         else
         {
            this.writableTextLayoutFormat().copy(param1);
         }
         this.formatChanged();
         if(_loc2_ != this.styleName)
         {
            this.styleSelectorChanged();
         }
      }
      
      tlf_internal function writableTextLayoutFormat() : FlowValueHolder {
         if(this._format == null)
         {
            this._format = new FlowValueHolder();
         }
         return this._format;
      }
      
      tlf_internal function formatChanged(param1:Boolean=true) : void {
         if(param1)
         {
            this.modelChanged(ModelChange.TEXTLAYOUT_FORMAT_CHANGED,this,0,this._textLength);
         }
         this._computedFormat = null;
      }
      
      tlf_internal function styleSelectorChanged() : void {
         this.modelChanged(ModelChange.STYLE_SELECTOR_CHANGED,this,0,this._textLength);
         this._computedFormat = null;
      }
      
      tlf_internal function get formatForCascade() : ITextLayoutFormat {
         var _loc2_:TextLayoutFormat = null;
         var _loc3_:ITextLayoutFormat = null;
         var _loc4_:TextLayoutFormat = null;
         var _loc1_:TextFlow = this.getTextFlow();
         if(_loc1_)
         {
            _loc2_ = _loc1_.getTextLayoutFormatStyle(this);
            if(_loc2_)
            {
               _loc3_ = this.format;
               if(_loc3_ == null)
               {
                  return _loc2_;
               }
               _loc4_ = new TextLayoutFormat();
               _loc4_.apply(_loc2_);
               _loc4_.apply(_loc3_);
               return _loc4_;
            }
         }
         return this._format;
      }
      
      public function get computedFormat() : ITextLayoutFormat {
         if(this._computedFormat == null)
         {
            this._computedFormat = this.doComputeTextLayoutFormat();
         }
         return this._computedFormat;
      }
      
      tlf_internal function doComputeTextLayoutFormat() : TextLayoutFormat {
         var _loc1_:TextLayoutFormat = this._parent?TextLayoutFormat(this._parent.computedFormat):null;
         return FlowElement.createTextLayoutFormatPrototype(this.formatForCascade,_loc1_);
      }
      
      tlf_internal function attributesChanged(param1:Boolean=true) : void {
         this.formatChanged(param1);
      }
      
      public function getStyle(param1:String) : * {
         if(TextLayoutFormat.description.hasOwnProperty(param1))
         {
            return this.computedFormat.getStyle(param1);
         }
         var _loc2_:TextFlow = this.getTextFlow();
         if(!_loc2_ || !_loc2_.formatResolver)
         {
            return this.computedFormat.getStyle(param1);
         }
         return this.getUserStyleWorker(param1);
      }
      
      tlf_internal function getUserStyleWorker(param1:String) : * {
         var _loc3_:* = undefined;
         if(this._format != null)
         {
            _loc3_ = this._format.getStyle(param1);
            if(_loc3_ !== undefined)
            {
               return _loc3_;
            }
         }
         var _loc2_:TextFlow = this.getTextFlow();
         if((_loc2_) && (_loc2_.formatResolver))
         {
            _loc3_ = _loc2_.formatResolver.resolveUserFormat(this,param1);
            if(_loc3_ !== undefined)
            {
               return _loc3_;
            }
         }
         return this._parent?this._parent.getUserStyleWorker(param1):undefined;
      }
      
      public function setStyle(param1:String, param2:*) : void {
         if(TextLayoutFormat.description[param1])
         {
            this[param1] = param2;
         }
         else
         {
            this.writableTextLayoutFormat().setStyle(param1,param2);
            this.formatChanged();
         }
      }
      
      public function clearStyle(param1:String) : void {
         this.setStyle(param1,undefined);
      }
      
      tlf_internal function modelChanged(param1:String, param2:FlowElement, param3:int, param4:int, param5:Boolean=true, param6:Boolean=true) : void {
         var _loc7_:TextFlow = this.getTextFlow();
         if(_loc7_)
         {
            _loc7_.processModelChanged(param1,param2,this.getAbsoluteStart() + param3,param4,param5,param6);
         }
      }
      
      tlf_internal function appendElementsForDelayedUpdate(param1:TextFlow, param2:String) : void {
      }
      
      tlf_internal function applyDelayedElementUpdate(param1:TextFlow, param2:Boolean, param3:Boolean) : void {
      }
      
      tlf_internal function getEffectivePaddingLeft() : Number {
         return this.computedFormat.paddingLeft == FormatValue.AUTO?0:this.computedFormat.paddingLeft;
      }
      
      tlf_internal function getEffectivePaddingRight() : Number {
         return this.computedFormat.paddingRight == FormatValue.AUTO?0:this.computedFormat.paddingRight;
      }
      
      tlf_internal function getEffectivePaddingTop() : Number {
         return this.computedFormat.paddingTop == FormatValue.AUTO?0:this.computedFormat.paddingTop;
      }
      
      tlf_internal function getEffectivePaddingBottom() : Number {
         return this.computedFormat.paddingBottom == FormatValue.AUTO?0:this.computedFormat.paddingBottom;
      }
      
      public function set tracking(param1:Object) : void {
         this.trackingRight = param1;
      }
      
      tlf_internal function applyWhiteSpaceCollapse(param1:String) : void {
         if(this.whiteSpaceCollapse !== undefined)
         {
            this.whiteSpaceCollapse = undefined;
         }
         this.setPrivateStyle(impliedElementString,undefined);
      }
      
      public function getAbsoluteStart() : int {
         var _loc1_:int = this._parentRelativeStart;
         var _loc2_:FlowElement = this._parent;
         while(_loc2_)
         {
            _loc1_ = _loc1_ + _loc2_._parentRelativeStart;
            _loc2_ = _loc2_._parent;
         }
         return _loc1_;
      }
      
      public function getElementRelativeStart(param1:FlowElement) : int {
         var _loc2_:int = this._parentRelativeStart;
         var _loc3_:FlowElement = this._parent;
         while((_loc3_) && !(_loc3_ == param1))
         {
            _loc2_ = _loc2_ + _loc3_._parentRelativeStart;
            _loc3_ = _loc3_._parent;
         }
         return _loc2_;
      }
      
      public function getTextFlow() : TextFlow {
         var _loc1_:FlowElement = this;
         while(_loc1_._parent != null)
         {
            _loc1_ = _loc1_._parent;
         }
         return _loc1_ as TextFlow;
      }
      
      public function getParagraph() : ParagraphElement {
         var _loc1_:ParagraphElement = null;
         var _loc2_:FlowElement = this;
         while(_loc2_)
         {
            _loc1_ = _loc2_ as ParagraphElement;
            if(_loc1_)
            {
               break;
            }
            _loc2_ = _loc2_._parent;
         }
         return _loc1_;
      }
      
      public function getParentByType(param1:Class) : FlowElement {
         var _loc2_:FlowElement = this._parent;
         while(_loc2_)
         {
            if(_loc2_ is param1)
            {
               return _loc2_;
            }
            _loc2_ = _loc2_._parent;
         }
         return null;
      }
      
      public function getPreviousSibling() : FlowElement {
         if(!this._parent)
         {
            return null;
         }
         var _loc1_:int = this._parent.getChildIndex(this);
         return _loc1_ == 0?null:this._parent.getChildAt(_loc1_-1);
      }
      
      public function getNextSibling() : FlowElement {
         if(!this._parent)
         {
            return null;
         }
         var _loc1_:int = this._parent.getChildIndex(this);
         return _loc1_ == this._parent.numChildren-1?null:this._parent.getChildAt(_loc1_ + 1);
      }
      
      public function getCharAtPosition(param1:int) : String {
         return null;
      }
      
      public function getCharCodeAtPosition(param1:int) : int {
         var _loc2_:String = this.getCharAtPosition(param1);
         return (_loc2_) && _loc2_.length > 0?_loc2_.charCodeAt(0):0;
      }
      
      tlf_internal function applyFunctionToElements(param1:Function) : Boolean {
         return param1(this);
      }
      
      tlf_internal function getEventMirror() : IEventDispatcher {
         return null;
      }
      
      tlf_internal function hasActiveEventMirror() : Boolean {
         return false;
      }
      
      private function updateRange(param1:int) : void {
         this.setParentRelativeStart(this._parentRelativeStart + param1);
      }
      
      tlf_internal function updateLengths(param1:int, param2:int, param3:Boolean) : void {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:FlowElement = null;
         this.setTextLength(this._textLength + param2);
         var _loc4_:FlowGroupElement = this._parent;
         if(_loc4_)
         {
            _loc5_ = _loc4_.getChildIndex(this) + 1;
            _loc6_ = _loc4_.numChildren;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc4_.getChildAt(_loc5_++);
               _loc7_.updateRange(param2);
            }
            _loc4_.updateLengths(param1,param2,param3);
         }
      }
      
      tlf_internal function getEnclosingController(param1:int) : ContainerController {
         var _loc2_:TextFlow = this.getTextFlow();
         if(_loc2_ == null || _loc2_.flowComposer == null)
         {
            return null;
         }
         var _loc3_:FlowElement = this;
         while((_loc3_) && (!(_loc3_ is ContainerFormattedElement) || ContainerFormattedElement(_loc3_).flowComposer == null))
         {
            _loc3_ = _loc3_._parent;
         }
         var _loc4_:IFlowComposer = ContainerFormattedElement(_loc3_).flowComposer;
         if(!_loc4_)
         {
            return null;
         }
         var _loc5_:int = ContainerFormattedElement(_loc3_).flowComposer.findControllerIndexAtPosition(this.getAbsoluteStart() + param1,false);
         return _loc5_ != -1?_loc4_.getControllerAt(_loc5_):null;
      }
      
      tlf_internal function deleteContainerText(param1:int, param2:int) : void {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:ContainerController = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:IFlowComposer = null;
         var _loc10_:* = 0;
         var _loc11_:ContainerController = null;
         if(this.getTextFlow())
         {
            _loc3_ = this.getAbsoluteStart() + param1;
            _loc4_ = _loc3_ - param2;
            while(param2 > 0)
            {
               _loc6_ = this.getEnclosingController(param1-1);
               if(!_loc6_)
               {
                  _loc6_ = this.getEnclosingController(param1 - param2);
                  if(_loc6_)
                  {
                     _loc9_ = _loc6_.flowComposer;
                     _loc10_ = _loc9_.getControllerIndex(_loc6_);
                     _loc11_ = _loc6_;
                     while(_loc10_ + 1 < _loc9_.numControllers && _loc6_.absoluteStart + _loc6_.textLength < param1)
                     {
                        _loc6_ = _loc9_.getControllerAt(_loc10_ + 1);
                        if(_loc6_.textLength)
                        {
                           _loc11_ = _loc6_;
                           break;
                        }
                        _loc10_++;
                     }
                  }
                  if(!_loc6_ || !_loc6_.textLength)
                  {
                     _loc6_ = _loc11_;
                  }
                  if(!_loc6_)
                  {
                     break;
                  }
               }
               _loc7_ = _loc6_.absoluteStart;
               if(_loc4_ < _loc7_)
               {
                  _loc5_ = _loc3_ - _loc7_ + 1;
               }
               else
               {
                  if(_loc4_ < _loc7_ + _loc6_.textLength)
                  {
                     _loc5_ = param2;
                  }
               }
               _loc8_ = _loc6_.textLength < _loc5_?_loc6_.textLength:_loc5_;
               if(_loc8_ <= 0)
               {
                  break;
               }
               ContainerController(_loc6_).setTextLengthOnly(_loc6_.textLength - _loc8_);
               param2 = param2 - _loc8_;
               _loc3_ = _loc3_ - _loc8_;
               param1 = param1 - _loc8_;
            }
         }
      }
      
      tlf_internal function normalizeRange(param1:uint, param2:uint) : void {
      }
      
      tlf_internal function quickCloneTextLayoutFormat(param1:FlowElement) : void {
         this._format = param1._format?new FlowValueHolder(param1._format):null;
         this._computedFormat = null;
      }
      
      tlf_internal function updateForMustUseComposer(param1:TextFlow) : Boolean {
         return false;
      }
   }
}
