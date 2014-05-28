package flashx.textLayout.factory
{
   import flash.display.Sprite;
   import flashx.textLayout.compose.SimpleCompose;
   import flashx.textLayout.tlf_internal;
   import flash.geom.Rectangle;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.compose.ISWFContext;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLineValidity;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.elements.TextFlow;
   import flash.display.Shape;
   import flashx.textLayout.container.ScrollPolicy;
   
   use namespace tlf_internal;
   
   public class TextLineFactoryBase extends Object
   {
      
      public function TextLineFactoryBase() {
         super();
         this._containerController = new ContainerController(_tc);
         this._horizontalScrollPolicy = this._verticalScrollPolicy = String(ScrollPolicy.scrollPolicyPropertyDefinition.defaultValue);
      }
      
      private static var _tc:Sprite = new Sprite();
      
      private static var _savedFactoryComposer:SimpleCompose;
      
      tlf_internal  static var _factoryComposer:SimpleCompose;
      
      protected static var _truncationLineIndex:int;
      
      protected static var _pass0Lines:Array;
      
      tlf_internal  static function peekFactoryCompose() : SimpleCompose {
         if(_savedFactoryComposer == null)
         {
            _savedFactoryComposer = new SimpleCompose();
         }
         return _savedFactoryComposer;
      }
      
      tlf_internal  static function beginFactoryCompose() : SimpleCompose {
         var _loc1_:SimpleCompose = _factoryComposer;
         _factoryComposer = peekFactoryCompose();
         _savedFactoryComposer = null;
         return _loc1_;
      }
      
      tlf_internal  static function endFactoryCompose(param1:SimpleCompose) : void {
         _savedFactoryComposer = _factoryComposer;
         _factoryComposer = param1;
      }
      
      tlf_internal  static function getDefaultFlowComposerClass() : Class {
         return FactoryDisplayComposer;
      }
      
      private var _compositionBounds:Rectangle;
      
      private var _contentBounds:Rectangle;
      
      protected var _isTruncated:Boolean = false;
      
      private var _horizontalScrollPolicy:String;
      
      private var _verticalScrollPolicy:String;
      
      private var _truncationOptions:TruncationOptions;
      
      private var _containerController:ContainerController;
      
      private var _swfContext:ISWFContext;
      
      public function get compositionBounds() : Rectangle {
         return this._compositionBounds;
      }
      
      public function set compositionBounds(param1:Rectangle) : void {
         this._compositionBounds = param1;
      }
      
      public function getContentBounds() : Rectangle {
         return this._contentBounds;
      }
      
      protected function setContentBounds(param1:Rectangle) : void {
         this._contentBounds = param1;
         this._contentBounds.offset(this.compositionBounds.left,this.compositionBounds.top);
      }
      
      public function get swfContext() : ISWFContext {
         return this._swfContext;
      }
      
      public function set swfContext(param1:ISWFContext) : void {
         this._swfContext = param1;
      }
      
      public function get truncationOptions() : TruncationOptions {
         return this._truncationOptions;
      }
      
      public function set truncationOptions(param1:TruncationOptions) : void {
         this._truncationOptions = param1;
      }
      
      public function get isTruncated() : Boolean {
         return this._isTruncated;
      }
      
      public function get horizontalScrollPolicy() : String {
         return this._horizontalScrollPolicy;
      }
      
      public function set horizontalScrollPolicy(param1:String) : void {
         this._horizontalScrollPolicy = param1;
      }
      
      public function get verticalScrollPolicy() : String {
         return this._verticalScrollPolicy;
      }
      
      public function set verticalScrollPolicy(param1:String) : void {
         this._verticalScrollPolicy = param1;
      }
      
      protected function get containerController() : ContainerController {
         return this._containerController;
      }
      
      protected function callbackWithTextLines(param1:Function, param2:Number, param3:Number) : void {
         var _loc4_:TextLine = null;
         var _loc5_:TextBlock = null;
         for each (_loc4_ in _factoryComposer._lines)
         {
            _loc5_ = _loc4_.textBlock;
            if(_loc5_)
            {
               _loc5_.releaseLines(_loc5_.firstLine,_loc5_.lastLine);
            }
            _loc4_.userData = null;
            _loc4_.x = _loc4_.x + param2;
            _loc4_.y = _loc4_.y + param3;
            _loc4_.validity = TextLineValidity.STATIC;
            param1(_loc4_);
         }
      }
      
      protected function doesComposedTextFit(param1:int, param2:uint, param3:String) : Boolean {
         if(!(param1 == TruncationOptions.NO_LINE_COUNT_LIMIT) && _factoryComposer._lines.length > param1)
         {
            return false;
         }
         var _loc4_:Array = _factoryComposer._lines;
         if(!_loc4_.length)
         {
            return param2?false:true;
         }
         var _loc5_:TextLine = _loc4_[_loc4_.length-1] as TextLine;
         return _loc5_.userData + _loc5_.rawTextLength == param2;
      }
      
      protected function getNextTruncationPosition(param1:int, param2:Boolean=false) : int {
         param1--;
         var _loc3_:TextLine = _pass0Lines[_truncationLineIndex] as TextLine;
         while(!(param1 >= _loc3_.userData && param1 < _loc3_.userData + _loc3_.rawTextLength))
         {
            if(param1 < _loc3_.userData)
            {
               _loc3_ = _pass0Lines[--_truncationLineIndex] as TextLine;
            }
         }
         var _loc4_:int = param2?_loc3_.userData - _loc3_.textBlockBeginIndex:0;
         var _loc5_:int = _loc3_.getAtomIndexAtCharIndex(param1 - _loc4_);
         var _loc6_:int = _loc3_.getAtomTextBlockBeginIndex(_loc5_) + _loc4_;
         return _loc6_;
      }
      
      tlf_internal function createFlowComposer() : IFlowComposer {
         return new FactoryDisplayComposer();
      }
      
      tlf_internal function computeLastAllowedLineIndex(param1:int) : void {
         _truncationLineIndex = _factoryComposer._lines.length-1;
         if(!(param1 == TruncationOptions.NO_LINE_COUNT_LIMIT) && param1 <= _truncationLineIndex)
         {
            _truncationLineIndex = param1-1;
         }
      }
      
      tlf_internal function processBackgroundColors(param1:TextFlow, param2:Function, param3:Number, param4:Number, param5:Number, param6:Number) : * {
         var _loc7_:Shape = new Shape();
         param1.backgroundManager.drawAllRects(param1,_loc7_,param5,param6);
         _loc7_.x = param3;
         _loc7_.y = param4;
         param2(_loc7_);
         param1.clearBackgroundManager();
      }
   }
}
