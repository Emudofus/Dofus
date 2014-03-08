package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   import flash.text.engine.GroupElement;
   import flashx.textLayout.events.FlowElementEventDispatcher;
   import flash.events.IEventDispatcher;
   import flashx.textLayout.events.ModelChange;
   import flash.text.engine.ContentElement;
   import __AS3__.vec.Vector;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   use namespace tlf_internal;
   
   public class SubParagraphGroupElementBase extends FlowGroupElement
   {
      
      public function SubParagraphGroupElementBase() {
         super();
      }
      
      tlf_internal  static const kMaxSPGEPrecedence:uint = 1000;
      
      tlf_internal  static const kMinSPGEPrecedence:uint = 0;
      
      private var _groupElement:GroupElement;
      
      tlf_internal var _eventMirror:FlowElementEventDispatcher = null;
      
      override tlf_internal function createContentElement() : void {
         var _loc2_:FlowElement = null;
         if(this._groupElement)
         {
            return;
         }
         this._groupElement = new GroupElement(null);
         var _loc1_:* = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            _loc2_.createContentElement();
            _loc1_++;
         }
         if(parent)
         {
            parent.insertBlockElement(this,this._groupElement);
         }
      }
      
      override tlf_internal function releaseContentElement() : void {
         var _loc2_:FlowElement = null;
         if(this._groupElement == null)
         {
            return;
         }
         var _loc1_:* = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            _loc2_.releaseContentElement();
            _loc1_++;
         }
         this._groupElement = null;
         _computedFormat = null;
      }
      
      tlf_internal function get precedence() : uint {
         return kMaxSPGEPrecedence;
      }
      
      tlf_internal function get groupElement() : GroupElement {
         return this._groupElement;
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
      
      override tlf_internal function createContentAsGroup() : GroupElement {
         return this.groupElement;
      }
      
      override tlf_internal function removeBlockElement(param1:FlowElement, param2:ContentElement) : void {
         var _loc3_:int = this.getChildIndex(param1);
         this.groupElement.replaceElements(_loc3_,_loc3_ + 1,null);
      }
      
      override tlf_internal function insertBlockElement(param1:FlowElement, param2:ContentElement) : void {
         var _loc3_:* = 0;
         var _loc4_:Vector.<ContentElement> = null;
         var _loc5_:ParagraphElement = null;
         if(this.groupElement)
         {
            _loc3_ = this.getChildIndex(param1);
            _loc4_ = new Vector.<ContentElement>();
            _loc4_.push(param2);
            this.groupElement.replaceElements(_loc3_,_loc3_,_loc4_);
         }
         else
         {
            param1.releaseContentElement();
            _loc5_ = getParagraph();
            if(_loc5_)
            {
               _loc5_.createTextBlock();
            }
         }
      }
      
      override tlf_internal function hasBlockElement() : Boolean {
         return !(this.groupElement == null);
      }
      
      override tlf_internal function setParentAndRelativeStart(param1:FlowGroupElement, param2:int) : void {
         if(param1 == parent)
         {
            return;
         }
         if((parent) && (parent.hasBlockElement()) && (this.groupElement))
         {
            parent.removeBlockElement(this,this.groupElement);
         }
         if((param1) && (!param1.hasBlockElement()) && (this.groupElement))
         {
            param1.createContentElement();
         }
         super.setParentAndRelativeStart(param1,param2);
         if((parent) && (parent.hasBlockElement()))
         {
            if(!this.groupElement)
            {
               this.createContentElement();
            }
            else
            {
               parent.insertBlockElement(this,this.groupElement);
            }
         }
      }
      
      override public function replaceChildren(param1:int, param2:int, ... rest) : void {
         var _loc4_:Array = [param1,param2];
         super.replaceChildren.apply(this,_loc4_.concat(rest));
         var _loc5_:ParagraphElement = this.getParagraph();
         if(_loc5_)
         {
            _loc5_.ensureTerminatorAfterReplace();
         }
      }
      
      override tlf_internal function normalizeRange(param1:uint, param2:uint) : void {
         var _loc4_:FlowElement = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:FlowElement = null;
         var _loc8_:SpanElement = null;
         var _loc3_:int = findChildIndexAtPosition(param1);
         if(!(_loc3_ == -1) && _loc3_ < numChildren)
         {
            _loc4_ = getChildAt(_loc3_);
            param1 = param1 - _loc4_.parentRelativeStart;
            while(true)
            {
               _loc5_ = _loc4_.parentRelativeStart + _loc4_.textLength;
               _loc4_.normalizeRange(param1,param2 - _loc4_.parentRelativeStart);
               _loc6_ = _loc4_.parentRelativeStart + _loc4_.textLength;
               param2 = param2 + (_loc6_ - _loc5_);
               if(_loc4_.textLength == 0 && !_loc4_.bindableElement)
               {
                  this.replaceChildren(_loc3_,_loc3_ + 1);
               }
               else
               {
                  if(_loc4_.mergeToPreviousIfPossible())
                  {
                     _loc7_ = this.getChildAt(_loc3_-1);
                     _loc7_.normalizeRange(0,_loc7_.textLength);
                  }
                  else
                  {
                     _loc3_++;
                  }
               }
               if(_loc3_ == numChildren)
               {
                  break;
               }
               _loc4_ = getChildAt(_loc3_);
               if(_loc4_.parentRelativeStart > param2)
               {
                  break;
               }
               param1 = 0;
            }
         }
         if(numChildren == 0 && !(parent == null))
         {
            _loc8_ = new SpanElement();
            this.replaceChildren(0,0,_loc8_);
            _loc8_.normalizeRange(0,_loc8_.textLength);
         }
      }
      
      tlf_internal function get allowNesting() : Boolean {
         return false;
      }
      
      private function checkForNesting(param1:SubParagraphGroupElementBase) : Boolean {
         var _loc2_:* = 0;
         var _loc3_:Class = null;
         if(param1)
         {
            if(!param1.allowNesting)
            {
               _loc3_ = getDefinitionByName(getQualifiedClassName(param1)) as Class;
               if(this is _loc3_ || (this.getParentByType(_loc3_)))
               {
                  return false;
               }
            }
            _loc2_ = param1.numChildren-1;
            while(_loc2_ >= 0)
            {
               if(!this.checkForNesting(param1.getChildAt(_loc2_) as SubParagraphGroupElementBase))
               {
                  return false;
               }
               _loc2_--;
            }
         }
         return true;
      }
      
      override tlf_internal function canOwnFlowElement(param1:FlowElement) : Boolean {
         if(param1 is FlowLeafElement)
         {
            return true;
         }
         if(param1 is SubParagraphGroupElementBase && (this.checkForNesting(param1 as SubParagraphGroupElementBase)))
         {
            return true;
         }
         return false;
      }
      
      tlf_internal function acceptTextBefore() : Boolean {
         return true;
      }
      
      tlf_internal function acceptTextAfter() : Boolean {
         return true;
      }
   }
}
