package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.property.Property;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.text.engine.ContentElement;
   import flash.system.Capabilities;
   import flashx.textLayout.formats.FormatValue;
   import flash.text.engine.TextRotation;
   import flashx.textLayout.formats.Float;
   import flash.display.Sprite;
   import flash.text.engine.GraphicElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.events.ModelChange;
   import flash.events.ErrorEvent;
   import flashx.textLayout.events.StatusChangeEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.display.LoaderInfo;
   import flash.net.URLRequest;
   import flash.display.Shape;
   import flash.text.engine.TextLine;
   import flash.text.engine.ElementFormat;
   import flash.text.engine.TextBaseline;
   import flash.geom.Rectangle;
   import flashx.textLayout.compose.ISWFContext;
   import flash.text.engine.FontMetrics;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.formats.JustificationRule;
   
   use namespace tlf_internal;
   
   public final class InlineGraphicElement extends FlowLeafElement
   {
      
      public function InlineGraphicElement(param1:String="") {
         super();
         this.okToUpdateHeightAndWidth = false;
         this._measuredWidth = 0;
         this._measuredHeight = 0;
         this.internalSetWidth(undefined);
         this.internalSetHeight(undefined);
         this._graphicStatus = InlineGraphicElementStatus.LOAD_PENDING;
         setTextLength(1);
         _text = param1 == ""?graphicElementText:param1;
      }
      
      private static const graphicElementText:String = String.fromCharCode(ContentElement.GRAPHIC_ELEMENT);
      
      private static const LOAD_INITIATED:String = "loadInitiated";
      
      private static const OPEN_RECEIVED:String = "openReceived";
      
      private static const LOAD_COMPLETE:String = "loadComplete";
      
      private static const EMBED_LOADED:String = "embedLoaded";
      
      private static const DISPLAY_OBJECT:String = "displayObject";
      
      private static const NULL_GRAPHIC:String = "nullGraphic";
      
      private static var isMac:Boolean = Capabilities.os.search("Mac OS") > -1;
      
      tlf_internal  static const heightPropertyDefinition:Property = Property.NewNumberOrPercentOrEnumProperty("height",FormatValue.AUTO,false,null,0,32000,"0%","1000000%",FormatValue.AUTO);
      
      tlf_internal  static const widthPropertyDefinition:Property = Property.NewNumberOrPercentOrEnumProperty("width",FormatValue.AUTO,false,null,0,32000,"0%","1000000%",FormatValue.AUTO);
      
      tlf_internal  static const rotationPropertyDefinition:Property = Property.NewEnumStringProperty("rotation",TextRotation.ROTATE_0,false,null,TextRotation.ROTATE_0,TextRotation.ROTATE_90,TextRotation.ROTATE_180,TextRotation.ROTATE_270);
      
      tlf_internal  static const floatPropertyDefinition:Property = Property.NewEnumStringProperty("float",Float.NONE,false,null,Float.NONE,Float.LEFT,Float.RIGHT,Float.START,Float.END);
      
      private static function recursiveShutDownGraphic(param1:DisplayObject) : void {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:* = 0;
         if(param1 is Loader)
         {
            Loader(param1).unloadAndStop();
         }
         else
         {
            if(param1)
            {
               _loc2_ = param1 as DisplayObjectContainer;
               if(_loc2_)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_.numChildren)
                  {
                     recursiveShutDownGraphic(_loc2_.getChildAt(_loc3_));
                     _loc3_++;
                  }
               }
               if(param1 is MovieClip)
               {
                  MovieClip(param1).stop();
               }
            }
         }
      }
      
      private var _source:Object;
      
      private var _graphic:DisplayObject;
      
      private var _placeholderGraphic:Sprite;
      
      private var _elementWidth:Number;
      
      private var _elementHeight:Number;
      
      private var _graphicStatus:Object;
      
      private var okToUpdateHeightAndWidth:Boolean;
      
      private var _width;
      
      private var _height;
      
      private var _measuredWidth:Number;
      
      private var _measuredHeight:Number;
      
      private var _float;
      
      override tlf_internal function createContentElement() : void {
         if(_blockElement)
         {
            return;
         }
         var _loc1_:GraphicElement = new GraphicElement();
         _blockElement = _loc1_;
         this.updateContentElement();
         super.createContentElement();
      }
      
      private function updateContentElement() : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc1_:GraphicElement = _blockElement as GraphicElement;
         if(!this._placeholderGraphic)
         {
            this._placeholderGraphic = new Sprite();
         }
         _loc1_.graphic = this._placeholderGraphic;
         if(this.effectiveFloat != Float.NONE)
         {
            if(_loc1_.elementHeight != 0)
            {
               _loc1_.elementHeight = 0;
            }
            if(_loc1_.elementWidth != 0)
            {
               _loc1_.elementWidth = 0;
            }
         }
         else
         {
            _loc2_ = this.elementHeightWithMarginsAndPadding();
            if(_loc1_.elementHeight != _loc2_)
            {
               _loc1_.elementHeight = _loc2_;
            }
            _loc3_ = this.elementWidthWithMarginsAndPadding();
            if(_loc1_.elementWidth != _loc3_)
            {
               _loc1_.elementWidth = _loc3_;
            }
         }
      }
      
      override public function get computedFormat() : ITextLayoutFormat {
         var _loc1_:* = _computedFormat == null;
         if((_loc1_) && (_blockElement))
         {
            this.updateContentElement();
         }
         return _computedFormat;
      }
      
      tlf_internal function elementWidthWithMarginsAndPadding() : Number {
         var _loc1_:TextFlow = getTextFlow();
         if(!_loc1_)
         {
            return this.elementWidth;
         }
         var _loc2_:Number = _loc1_.computedFormat.blockProgression == BlockProgression.RL?getEffectivePaddingTop() + getEffectivePaddingBottom():getEffectivePaddingLeft() + getEffectivePaddingRight();
         return this.elementWidth + _loc2_;
      }
      
      tlf_internal function elementHeightWithMarginsAndPadding() : Number {
         var _loc1_:TextFlow = getTextFlow();
         if(!_loc1_)
         {
            return this.elementWidth;
         }
         var _loc2_:Number = _loc1_.computedFormat.blockProgression == BlockProgression.RL?getEffectivePaddingLeft() + getEffectivePaddingRight():getEffectivePaddingTop() + getEffectivePaddingBottom();
         return this.elementHeight + _loc2_;
      }
      
      public function get graphic() : DisplayObject {
         return this._graphic;
      }
      
      private function setGraphic(param1:DisplayObject) : void {
         this._graphic = param1;
      }
      
      tlf_internal function get placeholderGraphic() : Sprite {
         return this._placeholderGraphic;
      }
      
      tlf_internal function get elementWidth() : Number {
         return this._elementWidth;
      }
      
      tlf_internal function set elementWidth(param1:Number) : void {
         this._elementWidth = param1;
         if(_blockElement)
         {
            (_blockElement as GraphicElement).elementWidth = this.effectiveFloat != Float.NONE?0:this.elementWidthWithMarginsAndPadding();
         }
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength,true,false);
      }
      
      tlf_internal function get elementHeight() : Number {
         return this._elementHeight;
      }
      
      tlf_internal function set elementHeight(param1:Number) : void {
         this._elementHeight = param1;
         if(_blockElement)
         {
            (_blockElement as GraphicElement).elementHeight = this.effectiveFloat != Float.NONE?0:this.elementHeightWithMarginsAndPadding();
         }
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength,true,false);
      }
      
      public function get status() : String {
         switch(this._graphicStatus)
         {
            case LOAD_INITIATED:
            case OPEN_RECEIVED:
               return InlineGraphicElementStatus.LOADING;
            case LOAD_COMPLETE:
            case EMBED_LOADED:
            case DISPLAY_OBJECT:
            case NULL_GRAPHIC:
               return InlineGraphicElementStatus.READY;
            case InlineGraphicElementStatus.LOAD_PENDING:
            case InlineGraphicElementStatus.SIZE_PENDING:
               return String(this._graphicStatus);
            default:
               return InlineGraphicElementStatus.ERROR;
         }
      }
      
      private function changeGraphicStatus(param1:Object) : void {
         var _loc4_:TextFlow = null;
         var _loc2_:String = this.status;
         this._graphicStatus = param1;
         var _loc3_:String = this.status;
         if(!(_loc2_ == _loc3_) || param1 is ErrorEvent)
         {
            _loc4_ = getTextFlow();
            if(_loc4_)
            {
               if(_loc3_ == InlineGraphicElementStatus.SIZE_PENDING)
               {
                  _loc4_.processAutoSizeImageLoaded(this);
               }
               _loc4_.dispatchEvent(new StatusChangeEvent(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE,false,false,this,_loc3_,param1 as ErrorEvent));
            }
         }
      }
      
      public function get width() : * {
         return this._width;
      }
      
      public function set width(param1:*) : void {
         this.internalSetWidth(param1);
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
      }
      
      public function get measuredWidth() : Number {
         return this._measuredWidth;
      }
      
      public function get actualWidth() : Number {
         return this.elementWidth;
      }
      
      private function widthIsComputed() : Boolean {
         return this.internalWidth is String;
      }
      
      private function get internalWidth() : Object {
         return this._width === undefined?widthPropertyDefinition.defaultValue:this._width;
      }
      
      private function computeWidth() : Number {
         var _loc1_:* = NaN;
         if(this.internalWidth == FormatValue.AUTO)
         {
            if(this.internalHeight == FormatValue.AUTO)
            {
               return this._measuredWidth;
            }
            if(this._measuredHeight == 0 || this._measuredWidth == 0)
            {
               return 0;
            }
            _loc1_ = this.heightIsComputed()?this.computeHeight():Number(this.internalHeight);
            return _loc1_ / this._measuredHeight * this._measuredWidth;
         }
         return widthPropertyDefinition.computeActualPropertyValue(this.internalWidth,this._measuredWidth);
      }
      
      private function internalSetWidth(param1:*) : void {
         this._width = widthPropertyDefinition.setHelper(this.width,param1);
         this.elementWidth = this.widthIsComputed()?0:Number(this.internalWidth);
         if((this.okToUpdateHeightAndWidth) && (this.graphic))
         {
            if(this.widthIsComputed())
            {
               this.elementWidth = this.computeWidth();
            }
            this.graphic.width = this.elementWidth;
            if(this.internalHeight == FormatValue.AUTO)
            {
               this.elementHeight = this.computeHeight();
               this.graphic.height = this.elementHeight;
            }
         }
      }
      
      public function get height() : * {
         return this._height;
      }
      
      public function set height(param1:*) : void {
         this.internalSetHeight(param1);
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
      }
      
      private function get internalHeight() : Object {
         return this._height === undefined?heightPropertyDefinition.defaultValue:this._height;
      }
      
      tlf_internal function get computedFloat() : * {
         if(this._float === undefined)
         {
            return floatPropertyDefinition.defaultValue;
         }
         return this._float;
      }
      
      private var _effectiveFloat:String;
      
      tlf_internal function get effectiveFloat() : * {
         return this._effectiveFloat?this._effectiveFloat:this.computedFloat;
      }
      
      tlf_internal function setEffectiveFloat(param1:String) : void {
         if(this._effectiveFloat != param1)
         {
            this._effectiveFloat = param1;
            if(_blockElement)
            {
               this.updateContentElement();
            }
         }
      }
      
      public function get float() : * {
         return this._float;
      }
      
      public function set float(param1:*) : * {
         var param1:* = floatPropertyDefinition.setHelper(this.float,param1) as String;
         if(this._float != param1)
         {
            this._float = param1;
            if(_blockElement)
            {
               this.updateContentElement();
            }
            modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
         }
      }
      
      public function get measuredHeight() : Number {
         return this._measuredHeight;
      }
      
      public function get actualHeight() : Number {
         return this.elementHeight;
      }
      
      private function heightIsComputed() : Boolean {
         return this.internalHeight is String;
      }
      
      private function computeHeight() : Number {
         var _loc1_:* = NaN;
         if(this.internalHeight == FormatValue.AUTO)
         {
            if(this.internalWidth == FormatValue.AUTO)
            {
               return this._measuredHeight;
            }
            if(this._measuredHeight == 0 || this._measuredWidth == 0)
            {
               return 0;
            }
            _loc1_ = this.widthIsComputed()?this.computeWidth():Number(this.internalWidth);
            return _loc1_ / this._measuredWidth * this._measuredHeight;
         }
         return heightPropertyDefinition.computeActualPropertyValue(this.internalHeight,this._measuredHeight);
      }
      
      private function internalSetHeight(param1:*) : void {
         this._height = heightPropertyDefinition.setHelper(this.height,param1);
         this.elementHeight = this.heightIsComputed()?0:Number(this.internalHeight);
         if((this.okToUpdateHeightAndWidth) && !(this.graphic == null))
         {
            if(this.heightIsComputed())
            {
               this.elementHeight = this.computeHeight();
            }
            this.graphic.height = this.elementHeight;
            if(this.internalWidth == FormatValue.AUTO)
            {
               this.elementWidth = this.computeWidth();
               this.graphic.width = this.elementWidth;
            }
         }
      }
      
      private function loadCompleteHandler(param1:Event) : void {
         this.removeDefaultLoadHandlers(this.graphic as Loader);
         this.okToUpdateHeightAndWidth = true;
         var _loc2_:DisplayObject = this.graphic;
         this._measuredWidth = _loc2_.width;
         this._measuredHeight = _loc2_.height;
         if(!this.widthIsComputed())
         {
            _loc2_.width = this.elementWidth;
         }
         if(!this.heightIsComputed())
         {
            _loc2_.height = this.elementHeight;
         }
         if(param1 is IOErrorEvent)
         {
            this.changeGraphicStatus(param1);
         }
         else
         {
            if((this.widthIsComputed()) || (this.heightIsComputed()))
            {
               _loc2_.visible = false;
               this.changeGraphicStatus(InlineGraphicElementStatus.SIZE_PENDING);
            }
            else
            {
               this.changeGraphicStatus(LOAD_COMPLETE);
            }
         }
      }
      
      private function openHandler(param1:Event) : void {
         this.changeGraphicStatus(OPEN_RECEIVED);
      }
      
      private function addDefaultLoadHandlers(param1:Loader) : void {
         var _loc2_:LoaderInfo = param1.contentLoaderInfo;
         _loc2_.addEventListener(Event.OPEN,this.openHandler,false,0,true);
         _loc2_.addEventListener(Event.COMPLETE,this.loadCompleteHandler,false,0,true);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.loadCompleteHandler,false,0,true);
      }
      
      private function removeDefaultLoadHandlers(param1:Loader) : void {
         param1.contentLoaderInfo.removeEventListener(Event.OPEN,this.openHandler);
         param1.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         param1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadCompleteHandler);
      }
      
      public function get source() : Object {
         return this._source;
      }
      
      public function set source(param1:Object) : void {
         this.stop(true);
         this._source = param1;
         this.changeGraphicStatus(InlineGraphicElementStatus.LOAD_PENDING);
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
      }
      
      override tlf_internal function applyDelayedElementUpdate(param1:TextFlow, param2:Boolean, param3:Boolean) : void {
         var source:Object = null;
         var elem:DisplayObject = null;
         var inlineGraphicResolver:Function = null;
         var loader:Loader = null;
         var myPattern:RegExp = null;
         var src:String = null;
         var pictURLReq:URLRequest = null;
         var cls:Class = null;
         var textFlow:TextFlow = param1;
         var okToUnloadGraphics:Boolean = param2;
         var hasController:Boolean = param3;
         if(textFlow != this.getTextFlow())
         {
            hasController = false;
         }
         if(this._graphicStatus == InlineGraphicElementStatus.LOAD_PENDING)
         {
            if(hasController)
            {
               source = this._source;
               if(source is String)
               {
                  inlineGraphicResolver = textFlow.configuration.inlineGraphicResolverFunction;
                  if(inlineGraphicResolver != null)
                  {
                     source = inlineGraphicResolver(this);
                  }
               }
               if(source is String || source is URLRequest)
               {
                  this.okToUpdateHeightAndWidth = false;
                  loader = new Loader();
                  try
                  {
                     this.addDefaultLoadHandlers(loader);
                     if(source is String)
                     {
                        myPattern = new RegExp("\\\\","g");
                        src = source as String;
                        src = src.replace(myPattern,"/");
                        if(isMac)
                        {
                           pictURLReq = new URLRequest(encodeURI(src));
                        }
                        else
                        {
                           pictURLReq = new URLRequest(src);
                        }
                        loader.load(pictURLReq);
                     }
                     else
                     {
                        loader.load(URLRequest(source));
                     }
                     this.setGraphic(loader);
                     this.changeGraphicStatus(LOAD_INITIATED);
                  }
                  catch(e:Error)
                  {
                     removeDefaultLoadHandlers(loader);
                     elem = new Shape();
                     changeGraphicStatus(NULL_GRAPHIC);
                  }
               }
               else
               {
                  if(source is Class)
                  {
                     cls = source as Class;
                     elem = DisplayObject(new cls());
                     this.changeGraphicStatus(EMBED_LOADED);
                  }
                  else
                  {
                     if(source is DisplayObject)
                     {
                        elem = DisplayObject(source);
                        this.changeGraphicStatus(DISPLAY_OBJECT);
                     }
                     else
                     {
                        elem = new Shape();
                        this.changeGraphicStatus(NULL_GRAPHIC);
                     }
                  }
               }
               if(source is String || source is URLRequest)
               {
                  if(this._graphicStatus != LOAD_INITIATED)
                  {
                     this.okToUpdateHeightAndWidth = true;
                     this._measuredWidth = elem?elem.width:0;
                     this._measuredHeight = elem?elem.height:0;
                     if(this.widthIsComputed())
                     {
                        if(elem)
                        {
                           elem.width = this.elementWidth = this.computeWidth();
                        }
                        else
                        {
                           this.elementWidth = 0;
                        }
                     }
                     else
                     {
                        elem.width = Number(this.width);
                     }
                     if(this.heightIsComputed())
                     {
                        if(elem)
                        {
                           elem.height = this.elementHeight = this.computeHeight();
                        }
                        else
                        {
                           this.elementHeight = 0;
                        }
                     }
                     else
                     {
                        elem.height = Number(this.height);
                     }
                     this.setGraphic(elem);
                  }
               }
               else
               {
                  if(this._graphicStatus != LOAD_INITIATED)
                  {
                     this.okToUpdateHeightAndWidth = true;
                     this._measuredWidth = elem?elem.width:0;
                     this._measuredHeight = elem?elem.height:0;
                     if(this.widthIsComputed())
                     {
                        if(elem)
                        {
                           elem.width = this.elementWidth = this.computeWidth();
                        }
                        else
                        {
                           this.elementWidth = 0;
                        }
                     }
                     else
                     {
                        elem.width = Number(this.width);
                     }
                     if(this.heightIsComputed())
                     {
                        if(elem)
                        {
                           elem.height = this.elementHeight = this.computeHeight();
                        }
                        else
                        {
                           this.elementHeight = 0;
                        }
                     }
                     else
                     {
                        elem.height = Number(this.height);
                     }
                     this.setGraphic(elem);
                  }
               }
            }
         }
         else
         {
            if(this._graphicStatus == InlineGraphicElementStatus.SIZE_PENDING)
            {
               this.updateAutoSizes();
               this.graphic.visible = true;
               this.changeGraphicStatus(LOAD_COMPLETE);
            }
            if(!hasController)
            {
               this.stop(okToUnloadGraphics);
            }
         }
      }
      
      override tlf_internal function updateForMustUseComposer(param1:TextFlow) : Boolean {
         this.applyDelayedElementUpdate(param1,false,true);
         return !(this.status == InlineGraphicElementStatus.READY);
      }
      
      private function updateAutoSizes() : void {
         if(this.widthIsComputed())
         {
            this.elementWidth = this.computeWidth();
            this.graphic.width = this.elementWidth;
         }
         if(this.heightIsComputed())
         {
            this.elementHeight = this.computeHeight();
            this.graphic.height = this.elementHeight;
         }
      }
      
      tlf_internal function stop(param1:Boolean) : Boolean {
         var loader:Loader = null;
         var okToUnloadGraphics:Boolean = param1;
         if(this._graphicStatus == OPEN_RECEIVED || this._graphicStatus == LOAD_INITIATED)
         {
            loader = this.graphic as Loader;
            try
            {
               loader.close();
            }
            catch(e:Error)
            {
            }
            this.removeDefaultLoadHandlers(loader);
         }
         if(this._graphicStatus != DISPLAY_OBJECT)
         {
            if(okToUnloadGraphics)
            {
               recursiveShutDownGraphic(this.graphic);
               this.setGraphic(null);
            }
            if(this.widthIsComputed())
            {
               this.elementWidth = 0;
            }
            if(this.heightIsComputed())
            {
               this.elementHeight = 0;
            }
            this.changeGraphicStatus(InlineGraphicElementStatus.LOAD_PENDING);
         }
         return true;
      }
      
      override tlf_internal function getEffectiveFontSize() : Number {
         if(this.effectiveFloat != Float.NONE)
         {
            return 0;
         }
         var _loc1_:Number = super.getEffectiveFontSize();
         return Math.max(_loc1_,this.elementHeightWithMarginsAndPadding());
      }
      
      override tlf_internal function getEffectiveLineHeight(param1:String) : Number {
         if(this.effectiveFloat != Float.NONE)
         {
            return 0;
         }
         return super.getEffectiveLineHeight(param1);
      }
      
      tlf_internal function getTypographicAscent(param1:TextLine) : Number {
         var _loc3_:String = null;
         if(this.effectiveFloat != Float.NONE)
         {
            return 0;
         }
         var _loc2_:Number = this.elementHeightWithMarginsAndPadding();
         if(this._computedFormat.dominantBaseline != FormatValue.AUTO)
         {
            _loc3_ = this._computedFormat.dominantBaseline;
         }
         else
         {
            _loc3_ = this.getParagraph().getEffectiveDominantBaseline();
         }
         var _loc4_:ElementFormat = _blockElement?_blockElement.elementFormat:computeElementFormat();
         var _loc5_:String = _loc4_.alignmentBaseline == TextBaseline.USE_DOMINANT_BASELINE?_loc3_:_loc4_.alignmentBaseline;
         var _loc6_:Number = 0;
         if(_loc3_ == TextBaseline.IDEOGRAPHIC_CENTER)
         {
            _loc6_ = _loc6_ + _loc2_ / 2;
         }
         else
         {
            if(_loc3_ == TextBaseline.IDEOGRAPHIC_BOTTOM || _loc3_ == TextBaseline.DESCENT || _loc3_ == TextBaseline.ROMAN)
            {
               _loc6_ = _loc6_ + _loc2_;
            }
         }
         _loc6_ = _loc6_ + (param1.getBaselinePosition(TextBaseline.ROMAN) - param1.getBaselinePosition(_loc5_));
         _loc6_ = _loc6_ + _loc4_.baselineShift;
         return _loc6_;
      }
      
      override tlf_internal function getCSSInlineBox(param1:String, param2:TextLine, param3:ParagraphElement=null, param4:ISWFContext=null) : Rectangle {
         if(this.effectiveFloat != Float.NONE)
         {
            return null;
         }
         var _loc5_:Rectangle = new Rectangle();
         _loc5_.top = -this.getTypographicAscent(param2);
         _loc5_.height = this.elementHeightWithMarginsAndPadding();
         _loc5_.width = this.elementWidth;
         return _loc5_;
      }
      
      override tlf_internal function updateIMEAdornments(param1:TextLine, param2:String, param3:String) : void {
         if(this.effectiveFloat == Float.NONE)
         {
            super.updateIMEAdornments(param1,param2,param3);
         }
      }
      
      override tlf_internal function updateAdornments(param1:TextLine, param2:String) : int {
         if(this.effectiveFloat == Float.NONE)
         {
            return super.updateAdornments(param1,param2);
         }
         return 0;
      }
      
      override public function shallowCopy(param1:int=0, param2:int=-1) : FlowElement {
         if(param2 == -1)
         {
            param2 = textLength;
         }
         var _loc3_:InlineGraphicElement = super.shallowCopy(param1,param2) as InlineGraphicElement;
         _loc3_.source = this.source;
         _loc3_.width = this.width;
         _loc3_.height = this.height;
         _loc3_.float = this.float;
         return _loc3_;
      }
      
      override protected function get abstract() : Boolean {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String {
         return "img";
      }
      
      override tlf_internal function appendElementsForDelayedUpdate(param1:TextFlow, param2:String) : void {
         if(param2 == ModelChange.ELEMENT_ADDED)
         {
            param1.incGraphicObjectCount();
         }
         else
         {
            if(param2 == ModelChange.ELEMENT_REMOVAL)
            {
               param1.decGraphicObjectCount();
            }
         }
         if(!(this.status == InlineGraphicElementStatus.READY) || param2 == ModelChange.ELEMENT_REMOVAL)
         {
            param1.appendOneElementForUpdate(this);
         }
      }
      
      override tlf_internal function calculateStrikeThrough(param1:TextLine, param2:String, param3:FontMetrics) : Number {
         var _loc6_:* = NaN;
         var _loc7_:TextFlowLine = null;
         var _loc8_:* = 0;
         if(!this.graphic || !(this.status == InlineGraphicElementStatus.READY))
         {
            return super.calculateStrikeThrough(param1,param2,param3);
         }
         var _loc4_:Number = 0;
         var _loc5_:DisplayObjectContainer = this._placeholderGraphic.parent;
         if(_loc5_)
         {
            if(param2 != BlockProgression.RL)
            {
               _loc4_ = this.placeholderGraphic.parent.y + (this.elementHeight / 2 + Number(getEffectivePaddingTop()));
            }
            else
            {
               _loc6_ = getEffectivePaddingRight();
               _loc7_ = param1.userData as TextFlowLine;
               _loc8_ = this.getAbsoluteStart() - _loc7_.absoluteStart;
               if(param1.getAtomTextRotation(_loc8_) != TextRotation.ROTATE_0)
               {
                  _loc4_ = this._placeholderGraphic.parent.x - (this.elementHeight / 2 + _loc6_);
               }
               else
               {
                  _loc4_ = this._placeholderGraphic.parent.x - (this.elementWidth / 2 + _loc6_);
               }
            }
         }
         return param2 == BlockProgression.TB?_loc4_:-_loc4_;
      }
      
      override tlf_internal function calculateUnderlineOffset(param1:Number, param2:String, param3:FontMetrics, param4:TextLine) : Number {
         if(!this.graphic || !(this.status == InlineGraphicElementStatus.READY))
         {
            return super.calculateUnderlineOffset(param1,param2,param3,param4);
         }
         var _loc5_:ParagraphElement = this.getParagraph();
         var _loc6_:Number = 0;
         var _loc7_:DisplayObjectContainer = this._placeholderGraphic.parent;
         if(_loc7_)
         {
            if(param2 == BlockProgression.TB)
            {
               _loc6_ = _loc7_.y + this.elementHeightWithMarginsAndPadding();
            }
            else
            {
               if(_loc5_.computedFormat.locale.toLowerCase().indexOf("zh") == 0)
               {
                  _loc6_ = _loc7_.x - this.elementHeightWithMarginsAndPadding();
                  _loc6_ = _loc6_ - (param3.underlineOffset + param3.underlineThickness / 2);
                  return _loc6_;
               }
               _loc6_ = _loc7_.x - getEffectivePaddingLeft();
            }
         }
         _loc6_ = _loc6_ + (param3.underlineOffset + param3.underlineThickness / 2);
         var _loc8_:String = _loc5_.getEffectiveJustificationRule();
         if(_loc8_ == JustificationRule.EAST_ASIAN)
         {
            _loc6_ = _loc6_ + 1;
         }
         return _loc6_;
      }
   }
}
