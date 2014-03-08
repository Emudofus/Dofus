package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   import flash.system.Capabilities;
   import flash.display.Sprite;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.IListMarkerFormat;
   import flashx.textLayout.edit.SelectionFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flash.display.BlendMode;
   import flashx.textLayout.formats.TextDecoration;
   import flashx.textLayout.formats.ListMarkerFormat;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.compose.StandardFlowComposer;
   
   use namespace tlf_internal;
   
   public class Configuration extends Object implements IConfiguration
   {
      
      public function Configuration(param1:Boolean=true) {
         super();
         if(param1)
         {
            this.initialize();
         }
      }
      
      tlf_internal  static function versionIsAtLeast(param1:int, param2:int) : Boolean {
         var _loc3_:Array = Capabilities.version.split(" ")[1].split(",");
         return int(_loc3_[0]) > param1 || int(_loc3_[0]) == param1 && int(_loc3_[1]) >= param2;
      }
      
      tlf_internal  static const playerEnablesArgoFeatures:Boolean = versionIsAtLeast(10,1);
      
      tlf_internal  static const playerEnablesSpicyFeatures:Boolean = (versionIsAtLeast(10,2)) && (new Sprite().hasOwnProperty("needsSoftKeyboard"));
      
      tlf_internal  static const hasTouchScreen:Boolean = (playerEnablesArgoFeatures) && !(Capabilities["touchScreenType"] == "none");
      
      tlf_internal  static function get debugCodeEnabled() : Boolean {
         return false;
      }
      
      private var _manageTabKey:Boolean;
      
      private var _manageEnterKey:Boolean;
      
      private var _overflowPolicy:String;
      
      private var _enableAccessibility:Boolean;
      
      private var _releaseLineCreationData:Boolean;
      
      private var _defaultLinkNormalFormat:ITextLayoutFormat;
      
      private var _defaultLinkActiveFormat:ITextLayoutFormat;
      
      private var _defaultLinkHoverFormat:ITextLayoutFormat;
      
      private var _defaultListMarkerFormat:IListMarkerFormat;
      
      private var _textFlowInitialFormat:ITextLayoutFormat;
      
      private var _focusedSelectionFormat:SelectionFormat;
      
      private var _unfocusedSelectionFormat:SelectionFormat;
      
      private var _inactiveSelectionFormat:SelectionFormat;
      
      private var _scrollDragDelay:Number;
      
      private var _scrollDragPixels:Number;
      
      private var _scrollPagePercentage:Number;
      
      private var _scrollMouseWheelMultiplier:Number;
      
      private var _flowComposerClass:Class;
      
      private var _inlineGraphicResolverFunction:Function;
      
      private function initialize() : void {
         var _loc1_:TextLayoutFormat = null;
         this._manageTabKey = false;
         this._manageEnterKey = true;
         this._overflowPolicy = OverflowPolicy.FIT_DESCENDERS;
         this._enableAccessibility = false;
         this._releaseLineCreationData = false;
         this._focusedSelectionFormat = new SelectionFormat(16777215,1,BlendMode.DIFFERENCE);
         this._unfocusedSelectionFormat = new SelectionFormat(16777215,0,BlendMode.DIFFERENCE,16777215,0.0,BlendMode.DIFFERENCE,0);
         this._inactiveSelectionFormat = this._unfocusedSelectionFormat;
         _loc1_ = new TextLayoutFormat();
         _loc1_.textDecoration = TextDecoration.UNDERLINE;
         _loc1_.color = 255;
         this._defaultLinkNormalFormat = _loc1_;
         var _loc2_:ListMarkerFormat = new ListMarkerFormat();
         _loc2_.paragraphEndIndent = 4;
         this._defaultListMarkerFormat = _loc2_;
         _loc1_ = new TextLayoutFormat();
         _loc1_.lineBreak = FormatValue.INHERIT;
         _loc1_.paddingLeft = FormatValue.INHERIT;
         _loc1_.paddingRight = FormatValue.INHERIT;
         _loc1_.paddingTop = FormatValue.INHERIT;
         _loc1_.paddingBottom = FormatValue.INHERIT;
         _loc1_.verticalAlign = FormatValue.INHERIT;
         _loc1_.columnCount = FormatValue.INHERIT;
         _loc1_.columnCount = FormatValue.INHERIT;
         _loc1_.columnGap = FormatValue.INHERIT;
         _loc1_.columnWidth = FormatValue.INHERIT;
         this._textFlowInitialFormat = _loc1_;
         this._scrollDragDelay = 35;
         this._scrollDragPixels = 20;
         this._scrollPagePercentage = 7 / 8;
         this._scrollMouseWheelMultiplier = 20;
         this._flowComposerClass = StandardFlowComposer;
      }
      
      private var _immutableClone:IConfiguration;
      
      tlf_internal function getImmutableClone() : IConfiguration {
         var _loc1_:Configuration = null;
         if(!this._immutableClone)
         {
            _loc1_ = this.clone();
            this._immutableClone = _loc1_;
            _loc1_._immutableClone = _loc1_;
         }
         return this._immutableClone;
      }
      
      public function clone() : Configuration {
         var _loc1_:Configuration = new Configuration(false);
         _loc1_.defaultLinkActiveFormat = this.defaultLinkActiveFormat;
         _loc1_.defaultLinkHoverFormat = this.defaultLinkHoverFormat;
         _loc1_.defaultLinkNormalFormat = this.defaultLinkNormalFormat;
         _loc1_.defaultListMarkerFormat = this.defaultListMarkerFormat;
         _loc1_.textFlowInitialFormat = this._textFlowInitialFormat;
         _loc1_.focusedSelectionFormat = this._focusedSelectionFormat;
         _loc1_.unfocusedSelectionFormat = this._unfocusedSelectionFormat;
         _loc1_.inactiveSelectionFormat = this._inactiveSelectionFormat;
         _loc1_.manageTabKey = this._manageTabKey;
         _loc1_.manageEnterKey = this._manageEnterKey;
         _loc1_.overflowPolicy = this._overflowPolicy;
         _loc1_.enableAccessibility = this._enableAccessibility;
         _loc1_.releaseLineCreationData = this._releaseLineCreationData;
         _loc1_.scrollDragDelay = this._scrollDragDelay;
         _loc1_.scrollDragPixels = this._scrollDragPixels;
         _loc1_.scrollPagePercentage = this._scrollPagePercentage;
         _loc1_.scrollMouseWheelMultiplier = this._scrollMouseWheelMultiplier;
         _loc1_.flowComposerClass = this._flowComposerClass;
         _loc1_._inlineGraphicResolverFunction = this._inlineGraphicResolverFunction;
         return _loc1_;
      }
      
      public function get manageTabKey() : Boolean {
         return this._manageTabKey;
      }
      
      public function set manageTabKey(param1:Boolean) : void {
         this._manageTabKey = param1;
         this._immutableClone = null;
      }
      
      public function get manageEnterKey() : Boolean {
         return this._manageEnterKey;
      }
      
      public function set manageEnterKey(param1:Boolean) : void {
         this._manageEnterKey = param1;
         this._immutableClone = null;
      }
      
      public function get overflowPolicy() : String {
         return this._overflowPolicy;
      }
      
      public function set overflowPolicy(param1:String) : void {
         this._overflowPolicy = param1;
      }
      
      public function get defaultLinkNormalFormat() : ITextLayoutFormat {
         return this._defaultLinkNormalFormat;
      }
      
      public function set defaultLinkNormalFormat(param1:ITextLayoutFormat) : void {
         this._defaultLinkNormalFormat = param1;
         this._immutableClone = null;
      }
      
      public function get defaultListMarkerFormat() : IListMarkerFormat {
         return this._defaultListMarkerFormat;
      }
      
      public function set defaultListMarkerFormat(param1:IListMarkerFormat) : void {
         this._defaultListMarkerFormat = param1;
         this._immutableClone = null;
      }
      
      public function get defaultLinkHoverFormat() : ITextLayoutFormat {
         return this._defaultLinkHoverFormat;
      }
      
      public function set defaultLinkHoverFormat(param1:ITextLayoutFormat) : void {
         this._defaultLinkHoverFormat = param1;
         this._immutableClone = null;
      }
      
      public function get defaultLinkActiveFormat() : ITextLayoutFormat {
         return this._defaultLinkActiveFormat;
      }
      
      public function set defaultLinkActiveFormat(param1:ITextLayoutFormat) : void {
         this._defaultLinkActiveFormat = param1;
         this._immutableClone = null;
      }
      
      public function get textFlowInitialFormat() : ITextLayoutFormat {
         return this._textFlowInitialFormat;
      }
      
      public function set textFlowInitialFormat(param1:ITextLayoutFormat) : void {
         this._textFlowInitialFormat = param1;
         this._immutableClone = null;
      }
      
      public function get focusedSelectionFormat() : SelectionFormat {
         return this._focusedSelectionFormat;
      }
      
      public function set focusedSelectionFormat(param1:SelectionFormat) : void {
         if(param1 != null)
         {
            this._focusedSelectionFormat = param1;
            this._immutableClone = null;
         }
      }
      
      public function get unfocusedSelectionFormat() : SelectionFormat {
         return this._unfocusedSelectionFormat;
      }
      
      public function set unfocusedSelectionFormat(param1:SelectionFormat) : void {
         if(param1 != null)
         {
            this._unfocusedSelectionFormat = param1;
            this._immutableClone = null;
         }
      }
      
      public function get inactiveSelectionFormat() : SelectionFormat {
         return this._inactiveSelectionFormat;
      }
      
      public function set inactiveSelectionFormat(param1:SelectionFormat) : void {
         if(param1 != null)
         {
            this._inactiveSelectionFormat = param1;
            this._immutableClone = null;
         }
      }
      
      public function get scrollDragDelay() : Number {
         return this._scrollDragDelay;
      }
      
      public function set scrollDragDelay(param1:Number) : void {
         if(param1 > 0)
         {
            this._scrollDragDelay = param1;
            this._immutableClone = null;
         }
      }
      
      public function get scrollDragPixels() : Number {
         return this._scrollDragPixels;
      }
      
      public function set scrollDragPixels(param1:Number) : void {
         if(param1 > 0)
         {
            this._scrollDragPixels = param1;
            this._immutableClone = null;
         }
      }
      
      public function get scrollPagePercentage() : Number {
         return this._scrollPagePercentage;
      }
      
      public function set scrollPagePercentage(param1:Number) : void {
         if(param1 > 0)
         {
            this._scrollPagePercentage = param1;
            this._immutableClone = null;
         }
      }
      
      public function get scrollMouseWheelMultiplier() : Number {
         return this._scrollMouseWheelMultiplier;
      }
      
      public function set scrollMouseWheelMultiplier(param1:Number) : void {
         if(param1 > 0)
         {
            this._scrollMouseWheelMultiplier = param1;
            this._immutableClone = null;
         }
      }
      
      public function get flowComposerClass() : Class {
         return this._flowComposerClass;
      }
      
      public function set flowComposerClass(param1:Class) : void {
         this._flowComposerClass = param1;
         this._immutableClone = null;
      }
      
      public function get enableAccessibility() : Boolean {
         return this._enableAccessibility;
      }
      
      public function set enableAccessibility(param1:Boolean) : void {
         this._enableAccessibility = param1;
         this._immutableClone = null;
      }
      
      public function get releaseLineCreationData() : Boolean {
         return this._releaseLineCreationData;
      }
      
      public function set releaseLineCreationData(param1:Boolean) : void {
         this._releaseLineCreationData = param1;
         this._immutableClone = null;
      }
      
      public function get inlineGraphicResolverFunction() : Function {
         return this._inlineGraphicResolverFunction;
      }
      
      public function set inlineGraphicResolverFunction(param1:Function) : void {
         this._inlineGraphicResolverFunction = param1;
         this._immutableClone = null;
      }
   }
}
