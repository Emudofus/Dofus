package flashx.textLayout.edit
{
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.formats.Category;
   
   use namespace tlf_internal;
   
   public class ElementRange extends Object
   {
      
      public function ElementRange() {
         super();
      }
      
      public static function createElementRange(param1:TextFlow, param2:int, param3:int) : ElementRange {
         var _loc4_:ElementRange = new ElementRange();
         if(param2 == param3)
         {
            _loc4_.absoluteStart = _loc4_.absoluteEnd = param2;
            _loc4_.firstLeaf = param1.findLeaf(_loc4_.absoluteStart);
            _loc4_.firstParagraph = _loc4_.firstLeaf.getParagraph();
            adjustForLeanLeft(_loc4_);
            _loc4_.lastLeaf = _loc4_.firstLeaf;
            _loc4_.lastParagraph = _loc4_.firstParagraph;
         }
         else
         {
            if(param2 < param3)
            {
               _loc4_.absoluteStart = param2;
               _loc4_.absoluteEnd = param3;
            }
            else
            {
               _loc4_.absoluteStart = param3;
               _loc4_.absoluteEnd = param2;
            }
            _loc4_.firstLeaf = param1.findLeaf(_loc4_.absoluteStart);
            _loc4_.lastLeaf = param1.findLeaf(_loc4_.absoluteEnd);
            if(_loc4_.lastLeaf == null && _loc4_.absoluteEnd == param1.textLength || _loc4_.absoluteEnd == _loc4_.lastLeaf.getAbsoluteStart())
            {
               _loc4_.lastLeaf = param1.findLeaf(_loc4_.absoluteEnd-1);
            }
            _loc4_.firstParagraph = _loc4_.firstLeaf.getParagraph();
            _loc4_.lastParagraph = _loc4_.lastLeaf.getParagraph();
            if(_loc4_.absoluteEnd == _loc4_.lastParagraph.getAbsoluteStart() + _loc4_.lastParagraph.textLength-1)
            {
               _loc4_.absoluteEnd++;
               _loc4_.lastLeaf = _loc4_.lastParagraph.getLastLeaf();
            }
         }
         _loc4_.textFlow = param1;
         return _loc4_;
      }
      
      private static function adjustForLeanLeft(param1:ElementRange) : void {
         var _loc2_:FlowLeafElement = null;
         if(param1.firstLeaf.getAbsoluteStart() == param1.absoluteStart)
         {
            _loc2_ = param1.firstLeaf.getPreviousLeaf(param1.firstParagraph);
            if((_loc2_) && _loc2_.getParagraph() == param1.firstLeaf.getParagraph())
            {
               if((!(_loc2_.parent is SubParagraphGroupElementBase) || ((_loc2_.parent as SubParagraphGroupElementBase).acceptTextAfter())) && (!(param1.firstLeaf.parent is SubParagraphGroupElementBase) || _loc2_.parent === param1.firstLeaf.parent))
               {
                  param1.firstLeaf = _loc2_;
               }
            }
         }
      }
      
      private var _absoluteStart:int;
      
      private var _absoluteEnd:int;
      
      private var _firstLeaf:FlowLeafElement;
      
      private var _lastLeaf:FlowLeafElement;
      
      private var _firstParagraph:ParagraphElement;
      
      private var _lastParagraph:ParagraphElement;
      
      private var _textFlow:TextFlow;
      
      public function get absoluteStart() : int {
         return this._absoluteStart;
      }
      
      public function set absoluteStart(param1:int) : void {
         this._absoluteStart = param1;
      }
      
      public function get absoluteEnd() : int {
         return this._absoluteEnd;
      }
      
      public function set absoluteEnd(param1:int) : void {
         this._absoluteEnd = param1;
      }
      
      public function get firstLeaf() : FlowLeafElement {
         return this._firstLeaf;
      }
      
      public function set firstLeaf(param1:FlowLeafElement) : void {
         this._firstLeaf = param1;
      }
      
      public function get lastLeaf() : FlowLeafElement {
         return this._lastLeaf;
      }
      
      public function set lastLeaf(param1:FlowLeafElement) : void {
         this._lastLeaf = param1;
      }
      
      public function get firstParagraph() : ParagraphElement {
         return this._firstParagraph;
      }
      
      public function set firstParagraph(param1:ParagraphElement) : void {
         this._firstParagraph = param1;
      }
      
      public function get lastParagraph() : ParagraphElement {
         return this._lastParagraph;
      }
      
      public function set lastParagraph(param1:ParagraphElement) : void {
         this._lastParagraph = param1;
      }
      
      public function get textFlow() : TextFlow {
         return this._textFlow;
      }
      
      public function set textFlow(param1:TextFlow) : void {
         this._textFlow = param1;
      }
      
      public function get containerFormat() : ITextLayoutFormat {
         var _loc1_:ContainerController = null;
         var _loc3_:* = 0;
         var _loc2_:IFlowComposer = this._textFlow.flowComposer;
         if(_loc2_)
         {
            _loc3_ = _loc2_.findControllerIndexAtPosition(this.absoluteStart);
            if(_loc3_ != -1)
            {
               _loc1_ = _loc2_.getControllerAt(_loc3_);
            }
         }
         return _loc1_?_loc1_.computedFormat:this._textFlow.computedFormat;
      }
      
      public function get paragraphFormat() : ITextLayoutFormat {
         return this.firstParagraph.computedFormat;
      }
      
      public function get characterFormat() : ITextLayoutFormat {
         return this.firstLeaf.computedFormat;
      }
      
      public function getCommonCharacterFormat() : TextLayoutFormat {
         var _loc1_:FlowLeafElement = this.firstLeaf;
         var _loc2_:TextLayoutFormat = new TextLayoutFormat(_loc1_.computedFormat);
         while(_loc1_ != this.lastLeaf)
         {
            _loc1_ = _loc1_.getNextLeaf();
            _loc2_.removeClashing(_loc1_.computedFormat);
         }
         return Property.extractInCategory(TextLayoutFormat,TextLayoutFormat.description,_loc2_,Category.CHARACTER,false) as TextLayoutFormat;
      }
      
      public function getCommonParagraphFormat() : TextLayoutFormat {
         var _loc1_:ParagraphElement = this.firstParagraph;
         var _loc2_:TextLayoutFormat = new TextLayoutFormat(_loc1_.computedFormat);
         while(_loc1_ != this.lastParagraph)
         {
            _loc1_ = this._textFlow.findAbsoluteParagraph(_loc1_.getAbsoluteStart() + _loc1_.textLength);
            _loc2_.removeClashing(_loc1_.computedFormat);
         }
         return Property.extractInCategory(TextLayoutFormat,TextLayoutFormat.description,_loc2_,Category.PARAGRAPH,false) as TextLayoutFormat;
      }
      
      public function getCommonContainerFormat() : TextLayoutFormat {
         var _loc1_:IFlowComposer = this._textFlow.flowComposer;
         if(!_loc1_)
         {
            return null;
         }
         var _loc2_:int = _loc1_.findControllerIndexAtPosition(this.absoluteStart);
         if(_loc2_ == -1)
         {
            return null;
         }
         var _loc3_:ContainerController = _loc1_.getControllerAt(_loc2_);
         var _loc4_:TextLayoutFormat = new TextLayoutFormat(_loc3_.computedFormat);
         while(_loc3_.absoluteStart + _loc3_.textLength < this.absoluteEnd)
         {
            _loc2_++;
            if(_loc2_ == _loc1_.numControllers)
            {
               break;
            }
            _loc3_ = _loc1_.getControllerAt(_loc2_);
            _loc4_.removeClashing(_loc3_.computedFormat);
         }
         return Property.extractInCategory(TextLayoutFormat,TextLayoutFormat.description,_loc4_,Category.CONTAINER,false) as TextLayoutFormat;
      }
   }
}
