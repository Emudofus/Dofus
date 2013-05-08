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
         

      public function Configuration(initializeWithDefaults:Boolean=true) {
         super();
         if(initializeWithDefaults)
         {
            this.initialize();
         }
      }

      tlf_internal  static function versionIsAtLeast(major:int, minor:int) : Boolean {
         var versionData:Array = Capabilities.version.split(" ")[1].split(",");
         return (int(versionData[0])<major)||(int(versionData[0])==major)&&(int(versionData[1])>=minor);
      }

      tlf_internal  static const playerEnablesArgoFeatures:Boolean = versionIsAtLeast(10,1);

      tlf_internal  static const playerEnablesSpicyFeatures:Boolean = (versionIsAtLeast(10,2))&&(new Sprite().hasOwnProperty("needsSoftKeyboard"));

      tlf_internal  static const hasTouchScreen:Boolean = (playerEnablesArgoFeatures)&&(!(Capabilities["touchScreenType"]=="none"));

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
         var scratchFormat:TextLayoutFormat = null;
         this._manageTabKey=false;
         this._manageEnterKey=true;
         this._overflowPolicy=OverflowPolicy.FIT_DESCENDERS;
         this._enableAccessibility=false;
         this._releaseLineCreationData=false;
         this._focusedSelectionFormat=new SelectionFormat(16777215,1,BlendMode.DIFFERENCE);
         this._unfocusedSelectionFormat=new SelectionFormat(16777215,0,BlendMode.DIFFERENCE,16777215,0.0,BlendMode.DIFFERENCE,0);
         this._inactiveSelectionFormat=this._unfocusedSelectionFormat;
         scratchFormat=new TextLayoutFormat();
         scratchFormat.textDecoration=TextDecoration.UNDERLINE;
         scratchFormat.color=255;
         this._defaultLinkNormalFormat=scratchFormat;
         var listMarkerFormat:ListMarkerFormat = new ListMarkerFormat();
         listMarkerFormat.paragraphEndIndent=4;
         this._defaultListMarkerFormat=listMarkerFormat;
         scratchFormat=new TextLayoutFormat();
         scratchFormat.lineBreak=FormatValue.INHERIT;
         scratchFormat.paddingLeft=FormatValue.INHERIT;
         scratchFormat.paddingRight=FormatValue.INHERIT;
         scratchFormat.paddingTop=FormatValue.INHERIT;
         scratchFormat.paddingBottom=FormatValue.INHERIT;
         scratchFormat.verticalAlign=FormatValue.INHERIT;
         scratchFormat.columnCount=FormatValue.INHERIT;
         scratchFormat.columnCount=FormatValue.INHERIT;
         scratchFormat.columnGap=FormatValue.INHERIT;
         scratchFormat.columnWidth=FormatValue.INHERIT;
         this._textFlowInitialFormat=scratchFormat;
         this._scrollDragDelay=35;
         this._scrollDragPixels=20;
         this._scrollPagePercentage=7/8;
         this._scrollMouseWheelMultiplier=20;
         this._flowComposerClass=StandardFlowComposer;
      }

      private var _immutableClone:IConfiguration;

      tlf_internal function getImmutableClone() : IConfiguration {
         var clonedConifg:Configuration = null;
         if(!this._immutableClone)
         {
            clonedConifg=this.clone();
            this._immutableClone=clonedConifg;
            clonedConifg._immutableClone=clonedConifg;
         }
         return this._immutableClone;
      }

      public function clone() : Configuration {
         var config:Configuration = new Configuration(false);
         config.defaultLinkActiveFormat=this.defaultLinkActiveFormat;
         config.defaultLinkHoverFormat=this.defaultLinkHoverFormat;
         config.defaultLinkNormalFormat=this.defaultLinkNormalFormat;
         config.defaultListMarkerFormat=this.defaultListMarkerFormat;
         config.textFlowInitialFormat=this._textFlowInitialFormat;
         config.focusedSelectionFormat=this._focusedSelectionFormat;
         config.unfocusedSelectionFormat=this._unfocusedSelectionFormat;
         config.inactiveSelectionFormat=this._inactiveSelectionFormat;
         config.manageTabKey=this._manageTabKey;
         config.manageEnterKey=this._manageEnterKey;
         config.overflowPolicy=this._overflowPolicy;
         config.enableAccessibility=this._enableAccessibility;
         config.releaseLineCreationData=this._releaseLineCreationData;
         config.scrollDragDelay=this._scrollDragDelay;
         config.scrollDragPixels=this._scrollDragPixels;
         config.scrollPagePercentage=this._scrollPagePercentage;
         config.scrollMouseWheelMultiplier=this._scrollMouseWheelMultiplier;
         config.flowComposerClass=this._flowComposerClass;
         config._inlineGraphicResolverFunction=this._inlineGraphicResolverFunction;
         return config;
      }

      public function get manageTabKey() : Boolean {
         return this._manageTabKey;
      }

      public function set manageTabKey(val:Boolean) : void {
         this._manageTabKey=val;
         this._immutableClone=null;
      }

      public function get manageEnterKey() : Boolean {
         return this._manageEnterKey;
      }

      public function set manageEnterKey(val:Boolean) : void {
         this._manageEnterKey=val;
         this._immutableClone=null;
      }

      public function get overflowPolicy() : String {
         return this._overflowPolicy;
      }

      public function set overflowPolicy(value:String) : void {
         this._overflowPolicy=value;
      }

      public function get defaultLinkNormalFormat() : ITextLayoutFormat {
         return this._defaultLinkNormalFormat;
      }

      public function set defaultLinkNormalFormat(val:ITextLayoutFormat) : void {
         this._defaultLinkNormalFormat=val;
         this._immutableClone=null;
      }

      public function get defaultListMarkerFormat() : IListMarkerFormat {
         return this._defaultListMarkerFormat;
      }

      public function set defaultListMarkerFormat(val:IListMarkerFormat) : void {
         this._defaultListMarkerFormat=val;
         this._immutableClone=null;
      }

      public function get defaultLinkHoverFormat() : ITextLayoutFormat {
         return this._defaultLinkHoverFormat;
      }

      public function set defaultLinkHoverFormat(val:ITextLayoutFormat) : void {
         this._defaultLinkHoverFormat=val;
         this._immutableClone=null;
      }

      public function get defaultLinkActiveFormat() : ITextLayoutFormat {
         return this._defaultLinkActiveFormat;
      }

      public function set defaultLinkActiveFormat(val:ITextLayoutFormat) : void {
         this._defaultLinkActiveFormat=val;
         this._immutableClone=null;
      }

      public function get textFlowInitialFormat() : ITextLayoutFormat {
         return this._textFlowInitialFormat;
      }

      public function set textFlowInitialFormat(val:ITextLayoutFormat) : void {
         this._textFlowInitialFormat=val;
         this._immutableClone=null;
      }

      public function get focusedSelectionFormat() : SelectionFormat {
         return this._focusedSelectionFormat;
      }

      public function set focusedSelectionFormat(val:SelectionFormat) : void {
         if(val!=null)
         {
            this._focusedSelectionFormat=val;
            this._immutableClone=null;
         }
      }

      public function get unfocusedSelectionFormat() : SelectionFormat {
         return this._unfocusedSelectionFormat;
      }

      public function set unfocusedSelectionFormat(val:SelectionFormat) : void {
         if(val!=null)
         {
            this._unfocusedSelectionFormat=val;
            this._immutableClone=null;
         }
      }

      public function get inactiveSelectionFormat() : SelectionFormat {
         return this._inactiveSelectionFormat;
      }

      public function set inactiveSelectionFormat(val:SelectionFormat) : void {
         if(val!=null)
         {
            this._inactiveSelectionFormat=val;
            this._immutableClone=null;
         }
      }

      public function get scrollDragDelay() : Number {
         return this._scrollDragDelay;
      }

      public function set scrollDragDelay(val:Number) : void {
         if(val>0)
         {
            this._scrollDragDelay=val;
            this._immutableClone=null;
         }
      }

      public function get scrollDragPixels() : Number {
         return this._scrollDragPixels;
      }

      public function set scrollDragPixels(val:Number) : void {
         if(val>0)
         {
            this._scrollDragPixels=val;
            this._immutableClone=null;
         }
      }

      public function get scrollPagePercentage() : Number {
         return this._scrollPagePercentage;
      }

      public function set scrollPagePercentage(val:Number) : void {
         if(val>0)
         {
            this._scrollPagePercentage=val;
            this._immutableClone=null;
         }
      }

      public function get scrollMouseWheelMultiplier() : Number {
         return this._scrollMouseWheelMultiplier;
      }

      public function set scrollMouseWheelMultiplier(val:Number) : void {
         if(val>0)
         {
            this._scrollMouseWheelMultiplier=val;
            this._immutableClone=null;
         }
      }

      public function get flowComposerClass() : Class {
         return this._flowComposerClass;
      }

      public function set flowComposerClass(val:Class) : void {
         this._flowComposerClass=val;
         this._immutableClone=null;
      }

      public function get enableAccessibility() : Boolean {
         return this._enableAccessibility;
      }

      public function set enableAccessibility(val:Boolean) : void {
         this._enableAccessibility=val;
         this._immutableClone=null;
      }

      public function get releaseLineCreationData() : Boolean {
         return this._releaseLineCreationData;
      }

      public function set releaseLineCreationData(val:Boolean) : void {
         this._releaseLineCreationData=val;
         this._immutableClone=null;
      }

      public function get inlineGraphicResolverFunction() : Function {
         return this._inlineGraphicResolverFunction;
      }

      public function set inlineGraphicResolverFunction(val:Function) : void {
         this._inlineGraphicResolverFunction=val;
         this._immutableClone=null;
      }
   }

}