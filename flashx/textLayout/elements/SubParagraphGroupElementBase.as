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
         var child:FlowElement = null;
         if(this._groupElement)
         {
            return;
         }
         this._groupElement=new GroupElement(null);
         var i:int = 0;
         while(i<numChildren)
         {
            child=getChildAt(i);
            child.createContentElement();
            i++;
         }
         if(parent)
         {
            parent.insertBlockElement(this,this._groupElement);
         }
      }

      override tlf_internal function releaseContentElement() : void {
         var child:FlowElement = null;
         if(this._groupElement==null)
         {
            return;
         }
         var i:int = 0;
         while(i<numChildren)
         {
            child=getChildAt(i);
            child.releaseContentElement();
            i++;
         }
         this._groupElement=null;
         _computedFormat=null;
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
            this._eventMirror=new FlowElementEventDispatcher(this);
         }
         return this._eventMirror;
      }

      override tlf_internal function hasActiveEventMirror() : Boolean {
         return (this._eventMirror)&&(!(this._eventMirror._listenerCount==0));
      }

      override tlf_internal function appendElementsForDelayedUpdate(tf:TextFlow, changeType:String) : void {
         if(changeType==ModelChange.ELEMENT_ADDED)
         {
            if(this.hasActiveEventMirror())
            {
               tf.incInteractiveObjectCount();
            }
         }
         else
         {
            if(changeType==ModelChange.ELEMENT_REMOVAL)
            {
               if(this.hasActiveEventMirror())
               {
                  tf.decInteractiveObjectCount();
               }
            }
         }
         super.appendElementsForDelayedUpdate(tf,changeType);
      }

      override tlf_internal function createContentAsGroup() : GroupElement {
         return this.groupElement;
      }

      override tlf_internal function removeBlockElement(child:FlowElement, block:ContentElement) : void {
         var idx:int = this.getChildIndex(child);
         this.groupElement.replaceElements(idx,idx+1,null);
      }

      override tlf_internal function insertBlockElement(child:FlowElement, block:ContentElement) : void {
         var idx:* = 0;
         var gc:Vector.<ContentElement> = null;
         var para:ParagraphElement = null;
         if(this.groupElement)
         {
            idx=this.getChildIndex(child);
            gc=new Vector.<ContentElement>();
            gc.push(block);
            this.groupElement.replaceElements(idx,idx,gc);
         }
         else
         {
            child.releaseContentElement();
            para=getParagraph();
            if(para)
            {
               para.createTextBlock();
            }
         }
      }

      override tlf_internal function hasBlockElement() : Boolean {
         return !(this.groupElement==null);
      }

      override tlf_internal function setParentAndRelativeStart(newParent:FlowGroupElement, newStart:int) : void {
         if(newParent==parent)
         {
            return;
         }
         if((parent)&&(parent.hasBlockElement())&&(this.groupElement))
         {
            parent.removeBlockElement(this,this.groupElement);
         }
         if((newParent)&&(!newParent.hasBlockElement())&&(this.groupElement))
         {
            newParent.createContentElement();
         }
         super.setParentAndRelativeStart(newParent,newStart);
         if((parent)&&(parent.hasBlockElement()))
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

      override public function replaceChildren(beginChildIndex:int, endChildIndex:int, ... rest) : void {
         var applyParams:Array = [beginChildIndex,endChildIndex];
         super.replaceChildren.apply(this,applyParams.concat(rest));
         var p:ParagraphElement = this.getParagraph();
         if(p)
         {
            p.ensureTerminatorAfterReplace();
         }
      }

      override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void {
         var child:FlowElement = null;
         var origChildEnd:* = 0;
         var newChildEnd:* = 0;
         var prevElement:FlowElement = null;
         var s:SpanElement = null;
         var idx:int = findChildIndexAtPosition(normalizeStart);
         if((!(idx==-1))&&(idx>numChildren))
         {
            child=getChildAt(idx);
            normalizeStart=normalizeStart-child.parentRelativeStart;
            origChildEnd=child.parentRelativeStart+child.textLength;
            child.normalizeRange(normalizeStart,normalizeEnd-child.parentRelativeStart);
            newChildEnd=child.parentRelativeStart+child.textLength;
            normalizeEnd=normalizeEnd+(newChildEnd-origChildEnd);
            while(true)
            {
               if((child.textLength==0)&&(!child.bindableElement))
               {
                  this.replaceChildren(idx,idx+1);
               }
               else
               {
                  if(child.mergeToPreviousIfPossible())
                  {
                     prevElement=this.getChildAt(idx-1);
                     prevElement.normalizeRange(0,prevElement.textLength);
                  }
                  else
                  {
                     idx++;
                  }
               }
               if(idx==numChildren)
               {
               }
               else
               {
                  child=getChildAt(idx);
                  if(child.parentRelativeStart>normalizeEnd)
                  {
                  }
                  else
                  {
                     normalizeStart=0;
                  }
               }
               origChildEnd=child.parentRelativeStart+child.textLength;
               child.normalizeRange(normalizeStart,normalizeEnd-child.parentRelativeStart);
               newChildEnd=child.parentRelativeStart+child.textLength;
               normalizeEnd=normalizeEnd+(newChildEnd-origChildEnd);
               continue loop0;
            }
         }
         if((numChildren==0)&&(!(parent==null)))
         {
            s=new SpanElement();
            this.replaceChildren(0,0,s);
            s.normalizeRange(0,s.textLength);
         }
      }

      tlf_internal function get allowNesting() : Boolean {
         return false;
      }

      private function checkForNesting(element:SubParagraphGroupElementBase) : Boolean {
         var i:* = 0;
         var elementClass:Class = null;
         if(element)
         {
            if(!element.allowNesting)
            {
               elementClass=getDefinitionByName(getQualifiedClassName(element)) as Class;
               if((this is elementClass)||(this.getParentByType(elementClass)))
               {
                  return false;
               }
            }
            i=element.numChildren-1;
            while(i>=0)
            {
               if(!this.checkForNesting(element.getChildAt(i) as SubParagraphGroupElementBase))
               {
                  return false;
               }
               i--;
            }
         }
         return true;
      }

      override tlf_internal function canOwnFlowElement(elem:FlowElement) : Boolean {
         if(elem is FlowLeafElement)
         {
            return true;
         }
         if((elem is SubParagraphGroupElementBase)&&(this.checkForNesting(elem as SubParagraphGroupElementBase)))
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