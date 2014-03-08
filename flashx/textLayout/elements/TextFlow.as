package flashx.textLayout.elements
{
   import flash.events.IEventDispatcher;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.edit.ISelectionManager;
   import flash.events.EventDispatcher;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.compose.ISWFContext;
   import flashx.textLayout.compose.FlowComposerBase;
   import flash.text.engine.TextLineValidity;
   import flashx.textLayout.events.DamageEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.compose.StandardFlowComposer;
   
   use namespace tlf_internal;
   
   public class TextFlow extends ContainerFormattedElement implements IEventDispatcher
   {
      
      public function TextFlow(param1:IConfiguration=null) {
         super();
         this.initializeForConstructor(param1);
      }
      
      public static var defaultConfiguration:Configuration = new Configuration();
      
      private static var _nextGeneration:uint = 1;
      
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
      
      private function initializeForConstructor(param1:IConfiguration) : void {
         if(param1 == null)
         {
            param1 = defaultConfiguration;
         }
         this._configuration = Configuration(param1).getImmutableClone();
         format = this._configuration.textFlowInitialFormat;
         if(this._configuration.flowComposerClass)
         {
            this.flowComposer = new this._configuration.flowComposerClass();
         }
         this._generation = _nextGeneration++;
         this._interactiveObjectCount = 0;
         this._graphicObjectCount = 0;
      }
      
      override public function shallowCopy(param1:int=0, param2:int=-1) : FlowElement {
         var _loc3_:TextFlow = super.shallowCopy(param1,param2) as TextFlow;
         _loc3_._configuration = this._configuration;
         _loc3_._generation = _nextGeneration++;
         if(this.formatResolver)
         {
            _loc3_.formatResolver = this.formatResolver.getResolverForNewFlow(this,_loc3_);
         }
         if((_loc3_.flowComposer) && (this.flowComposer))
         {
            _loc3_.flowComposer.swfContext = this.flowComposer.swfContext;
         }
         return _loc3_;
      }
      
      tlf_internal function get interactiveObjectCount() : int {
         return this._interactiveObjectCount;
      }
      
      tlf_internal function incInteractiveObjectCount() : void {
         this._interactiveObjectCount++;
      }
      
      tlf_internal function decInteractiveObjectCount() : void {
         this._interactiveObjectCount--;
      }
      
      tlf_internal function get graphicObjectCount() : int {
         return this._graphicObjectCount;
      }
      
      tlf_internal function incGraphicObjectCount() : void {
         this._graphicObjectCount++;
      }
      
      tlf_internal function decGraphicObjectCount() : void {
         this._graphicObjectCount--;
      }
      
      public function get configuration() : IConfiguration {
         return this._configuration;
      }
      
      public function get interactionManager() : ISelectionManager {
         return this._interactionManager;
      }
      
      public function set interactionManager(param1:ISelectionManager) : void {
         if(this._interactionManager != param1)
         {
            if(this._interactionManager)
            {
               this._interactionManager.textFlow = null;
            }
            this._interactionManager = param1;
            if(this._interactionManager)
            {
               this._interactionManager.textFlow = this;
               this.normalize();
            }
            if(this.flowComposer)
            {
               this.flowComposer.interactionManagerChanged(param1);
            }
         }
      }
      
      override public function get flowComposer() : IFlowComposer {
         return this._flowComposer;
      }
      
      public function set flowComposer(param1:IFlowComposer) : void {
         this.changeFlowComposer(param1,true);
      }
      
      tlf_internal function changeFlowComposer(param1:IFlowComposer, param2:Boolean) : void {
         var _loc4_:ISWFContext = null;
         var _loc5_:ISWFContext = null;
         var _loc6_:* = 0;
         var _loc3_:IFlowComposer = this._flowComposer;
         if(this._flowComposer != param1)
         {
            _loc4_ = FlowComposerBase.computeBaseSWFContext(this._flowComposer?this._flowComposer.swfContext:null);
            _loc5_ = FlowComposerBase.computeBaseSWFContext(param1?param1.swfContext:null);
            if(this._flowComposer)
            {
               _loc6_ = 0;
               while(_loc6_ < this._flowComposer.numControllers)
               {
                  this._flowComposer.getControllerAt(_loc6_++).clearSelectionShapes();
               }
               this._flowComposer.setRootElement(null);
            }
            this._flowComposer = param1;
            if(this._flowComposer)
            {
               this._flowComposer.setRootElement(this);
            }
            if(textLength)
            {
               this.damage(getAbsoluteStart(),textLength,TextLineValidity.INVALID,false);
            }
            if(_loc4_ != _loc5_)
            {
               this.invalidateAllFormats();
            }
            if(this._flowComposer == null)
            {
               if(param2)
               {
                  this.unloadGraphics();
               }
            }
            else
            {
               if(_loc3_ == null)
               {
                  this.prepareGraphicsForLoad();
               }
            }
         }
      }
      
      tlf_internal function unloadGraphics() : void {
         if(this._graphicObjectCount)
         {
            applyFunctionToElements(function(param1:FlowElement):Boolean
            {
               if(param1 is InlineGraphicElement)
               {
                  (param1 as InlineGraphicElement).stop(true);
               }
               return false;
            });
         }
      }
      
      tlf_internal function prepareGraphicsForLoad() : void {
         if(this._graphicObjectCount)
         {
            appendElementsForDelayedUpdate(this,null);
         }
      }
      
      public function getElementByID(param1:String) : FlowElement {
         var rslt:FlowElement = null;
         var idName:String = param1;
         applyFunctionToElements(function(param1:FlowElement):Boolean
         {
            if(param1.id == idName)
            {
               rslt = param1;
               return true;
            }
            return false;
         });
         return rslt;
      }
      
      public function getElementsByStyleName(param1:String) : Array {
         var a:Array = null;
         var styleNameValue:String = param1;
         a = new Array();
         applyFunctionToElements(function(param1:FlowElement):Boolean
         {
            if(param1.styleName == styleNameValue)
            {
               a.push(param1);
            }
            return false;
         });
         return a;
      }
      
      public function getElementsByTypeName(param1:String) : Array {
         var a:Array = null;
         var typeNameValue:String = param1;
         a = new Array();
         applyFunctionToElements(function(param1:FlowElement):Boolean
         {
            if(param1.typeName == typeNameValue)
            {
               a.push(param1);
            }
            return false;
         });
         return a;
      }
      
      override protected function get abstract() : Boolean {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String {
         return "TextFlow";
      }
      
      override tlf_internal function updateLengths(param1:int, param2:int, param3:Boolean) : void {
         var _loc4_:* = 0;
         if(this.normalizeStart != -1)
         {
            _loc4_ = param1 < this.normalizeStart?param1:this.normalizeStart;
            if(_loc4_ < this.normalizeStart)
            {
               this.normalizeLen = this.normalizeLen + (this.normalizeStart - _loc4_);
            }
            this.normalizeLen = this.normalizeLen + param2;
            this.normalizeStart = _loc4_;
         }
         else
         {
            this.normalizeStart = param1;
            this.normalizeLen = param2;
         }
         if(this.normalizeLen < 0)
         {
            this.normalizeLen = 0;
         }
         if((param3) && (this._flowComposer))
         {
            this._flowComposer.updateLengths(param1,param2);
            super.updateLengths(param1,param2,false);
         }
         else
         {
            super.updateLengths(param1,param2,param3);
         }
      }
      
      override public function set mxmlChildren(param1:Array) : void {
         super.mxmlChildren = param1;
         this.normalize();
         applyWhiteSpaceCollapse(null);
      }
      
      tlf_internal function applyUpdateElements(param1:Boolean) : Boolean {
         var _loc2_:* = false;
         var _loc3_:Object = null;
         if(this._elemsToUpdate)
         {
            _loc2_ = (this.flowComposer) && !(this.flowComposer.numControllers == 0);
            for (_loc3_ in this._elemsToUpdate)
            {
               (_loc3_ as FlowElement).applyDelayedElementUpdate(this,param1,_loc2_);
            }
            if(_loc2_)
            {
               this._elemsToUpdate = null;
               return true;
            }
         }
         return false;
      }
      
      override tlf_internal function preCompose() : void {
         do
         {
               this.normalize();
            }while(this.applyUpdateElements(true));
            
         }
         
         tlf_internal function damage(param1:int, param2:int, param3:String, param4:Boolean=true) : void {
            var _loc5_:uint = 0;
            if(param4)
            {
               if(this.normalizeStart == -1)
               {
                  this.normalizeStart = param1;
                  this.normalizeLen = param2;
               }
               else
               {
                  if(param1 < this.normalizeStart)
                  {
                     _loc5_ = this.normalizeLen;
                     _loc5_ = this.normalizeStart + this.normalizeLen - param1;
                     if(param2 > _loc5_)
                     {
                        _loc5_ = param2;
                     }
                     this.normalizeStart = param1;
                     this.normalizeLen = _loc5_;
                  }
                  else
                  {
                     if(this.normalizeStart + this.normalizeLen > param1)
                     {
                        if(param1 + param2 > this.normalizeStart + this.normalizeLen)
                        {
                           this.normalizeLen = param1 + param2 - this.normalizeStart;
                        }
                     }
                     else
                     {
                        this.normalizeLen = param1 + param2 - this.normalizeStart;
                     }
                  }
               }
               if(this.normalizeStart + this.normalizeLen > textLength)
               {
                  this.normalizeLen = textLength - this.normalizeStart;
               }
            }
            if(this._flowComposer)
            {
               this._flowComposer.damage(param1,param2,param3);
            }
            if(this.hasEventListener(DamageEvent.DAMAGE))
            {
               this.dispatchEvent(new DamageEvent(DamageEvent.DAMAGE,false,false,this,param1,param2));
            }
         }
         
         tlf_internal function findAbsoluteParagraph(param1:int) : ParagraphElement {
            var _loc2_:FlowElement = findLeaf(param1);
            return _loc2_?_loc2_.getParagraph():null;
         }
         
         tlf_internal function findAbsoluteFlowGroupElement(param1:int) : FlowGroupElement {
            var _loc2_:FlowElement = findLeaf(param1);
            return _loc2_.parent;
         }
         
         public function addEventListener(param1:String, param2:Function, param3:Boolean=false, param4:int=0, param5:Boolean=false) : void {
            if(!this._eventDispatcher)
            {
               this._eventDispatcher = new EventDispatcher(this);
            }
            this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
         }
         
         public function dispatchEvent(param1:Event) : Boolean {
            if(!this._eventDispatcher)
            {
               return true;
            }
            return this._eventDispatcher.dispatchEvent(param1);
         }
         
         public function hasEventListener(param1:String) : Boolean {
            if(!this._eventDispatcher)
            {
               return false;
            }
            return this._eventDispatcher.hasEventListener(param1);
         }
         
         public function removeEventListener(param1:String, param2:Function, param3:Boolean=false) : void {
            if(!this._eventDispatcher)
            {
               return;
            }
            this._eventDispatcher.removeEventListener(param1,param2,param3);
         }
         
         public function willTrigger(param1:String) : Boolean {
            if(!this._eventDispatcher)
            {
               return false;
            }
            return this._eventDispatcher.willTrigger(param1);
         }
         
         private var _elemsToUpdate:Dictionary;
         
         tlf_internal function appendOneElementForUpdate(param1:FlowElement) : void {
            if(this._elemsToUpdate == null)
            {
               this._elemsToUpdate = new Dictionary();
            }
            this._elemsToUpdate[param1] = null;
         }
         
         tlf_internal function mustUseComposer() : Boolean {
            var _loc2_:Object = null;
            if(this._interactiveObjectCount != 0)
            {
               return true;
            }
            if(this._elemsToUpdate == null || this._elemsToUpdate.length == 0)
            {
               return false;
            }
            this.normalize();
            var _loc1_:* = false;
            for (_loc2_ in this._elemsToUpdate)
            {
               if((_loc2_ as FlowElement).updateForMustUseComposer(this))
               {
                  _loc1_ = true;
               }
            }
            return _loc1_;
         }
         
         tlf_internal function processModelChanged(param1:String, param2:Object, param3:int, param4:int, param5:Boolean, param6:Boolean) : void {
            if(param2 is FlowElement)
            {
               (param2 as FlowElement).appendElementsForDelayedUpdate(this,param1);
            }
            if(param6)
            {
               this._generation = _nextGeneration++;
            }
            if(param4 > 0 || param1 == ModelChange.ELEMENT_ADDED)
            {
               this.damage(param3,param4,TextLineValidity.INVALID,param5);
            }
            if(this.formatResolver)
            {
               switch(param1)
               {
                  case ModelChange.ELEMENT_REMOVAL:
                  case ModelChange.ELEMENT_ADDED:
                  case ModelChange.STYLE_SELECTOR_CHANGED:
                     this.formatResolver.invalidate(param2);
                     param2.formatChanged(false);
                     break;
               }
            }
         }
         
         public function get generation() : uint {
            return this._generation;
         }
         
         tlf_internal function setGeneration(param1:uint) : void {
            this._generation = param1;
         }
         
         tlf_internal function processAutoSizeImageLoaded(param1:InlineGraphicElement) : void {
            if(this.flowComposer)
            {
               param1.appendElementsForDelayedUpdate(this,null);
            }
         }
         
         tlf_internal function normalize() : void {
            var _loc1_:* = 0;
            if(this.normalizeStart != -1)
            {
               _loc1_ = this.normalizeStart + (this.normalizeLen == 0?1:this.normalizeLen);
               normalizeRange(this.normalizeStart == 0?this.normalizeStart:this.normalizeStart-1,_loc1_);
               this.normalizeStart = -1;
               this.normalizeLen = 0;
            }
         }
         
         private var _hostFormatHelper:HostFormatHelper;
         
         public function get hostFormat() : ITextLayoutFormat {
            return this._hostFormatHelper?this._hostFormatHelper.format:null;
         }
         
         public function set hostFormat(param1:ITextLayoutFormat) : void {
            if(param1 == null)
            {
               this._hostFormatHelper = null;
            }
            else
            {
               if(this._hostFormatHelper == null)
               {
                  this._hostFormatHelper = new HostFormatHelper();
               }
               this._hostFormatHelper.format = param1;
            }
            formatChanged();
         }
         
         override tlf_internal function doComputeTextLayoutFormat() : TextLayoutFormat {
            var _loc1_:TextLayoutFormat = this._hostFormatHelper?this._hostFormatHelper.getComputedPrototypeFormat():null;
            return FlowElement.createTextLayoutFormatPrototype(formatForCascade,_loc1_);
         }
         
         tlf_internal function getTextLayoutFormatStyle(param1:Object) : TextLayoutFormat {
            if(this._formatResolver == null)
            {
               return null;
            }
            var _loc2_:ITextLayoutFormat = this._formatResolver.resolveFormat(param1);
            if(_loc2_ == null)
            {
               return null;
            }
            var _loc3_:TextLayoutFormat = _loc2_ as TextLayoutFormat;
            return _loc3_?_loc3_:new TextLayoutFormat(_loc2_);
         }
         
         tlf_internal function get backgroundManager() : BackgroundManager {
            return this._backgroundManager;
         }
         
         tlf_internal function clearBackgroundManager() : void {
            this._backgroundManager = null;
         }
         
         tlf_internal function getBackgroundManager() : BackgroundManager {
            if(!this._backgroundManager && this.flowComposer is StandardFlowComposer)
            {
               this._backgroundManager = (this.flowComposer as StandardFlowComposer).createBackgroundManager();
            }
            return this._backgroundManager;
         }
         
         public function get formatResolver() : IFormatResolver {
            return this._formatResolver;
         }
         
         public function set formatResolver(param1:IFormatResolver) : void {
            if(this._formatResolver != param1)
            {
               if(this._formatResolver)
               {
                  this._formatResolver.invalidateAll(this);
               }
               this._formatResolver = param1;
               if(this._formatResolver)
               {
                  this._formatResolver.invalidateAll(this);
               }
               formatChanged(true);
            }
         }
         
         public function invalidateAllFormats() : void {
            if(this._formatResolver)
            {
               this._formatResolver.invalidateAll(this);
            }
            formatChanged(true);
         }
      }
   }
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   class HostFormatHelper extends Object
   {
      
      function HostFormatHelper() {
         super();
      }
      
      private var _format:ITextLayoutFormat;
      
      private var _computedPrototypeFormat:TextLayoutFormat;
      
      public function get format() : ITextLayoutFormat {
         return this._format;
      }
      
      public function set format(param1:ITextLayoutFormat) : void {
         this._format = param1;
         this._computedPrototypeFormat = null;
      }
      
      public function getComputedPrototypeFormat() : TextLayoutFormat {
         var _loc1_:ITextLayoutFormat = null;
         if(this._computedPrototypeFormat == null)
         {
            if(this._format is TextLayoutFormat || this._format is TextLayoutFormat)
            {
               _loc1_ = this._format;
            }
            else
            {
               _loc1_ = new TextLayoutFormat(this._format);
            }
            this._computedPrototypeFormat = FlowElement.createTextLayoutFormatPrototype(_loc1_,null);
         }
         return this._computedPrototypeFormat;
      }
   }
