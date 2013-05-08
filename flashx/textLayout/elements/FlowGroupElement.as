package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   import flash.utils.getQualifiedClassName;
   import flash.text.engine.ContentElement;
   import flash.text.engine.GroupElement;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.compose.FlowDamageType;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.FormatValue;

   use namespace tlf_internal;

   public class FlowGroupElement extends FlowElement
   {
         

      public function FlowGroupElement() {
         super();
         this._numChildren=0;
      }

      private static function getNestedArgCount(obj:Object) : uint {
         return obj is Array?obj.length:1;
      }

      private static function getNestedArg(obj:Object, index:uint) : FlowElement {
         return (obj is Array?obj[index]:obj) as FlowElement;
      }

      private var _childArray:Array;

      private var _singleChild:FlowElement;

      private var _numChildren:int;

      override public function deepCopy(startPos:int=0, endPos:int=-1) : FlowElement {
         var newFlowElement:FlowElement = null;
         var child:FlowElement = null;
         var possiblyEmptyFlowElement:FlowElement = null;
         if(endPos==-1)
         {
            endPos=textLength;
         }
         var retFlow:FlowGroupElement = shallowCopy(startPos,endPos) as FlowGroupElement;
         var idx:int = 0;
         while(idx<this._numChildren)
         {
            child=this.getChildAt(idx);
            if((startPos-child.parentRelativeStart>child.textLength)&&(endPos-child.parentRelativeStart<0))
            {
               newFlowElement=child.deepCopy(startPos-child.parentRelativeStart,endPos-child.parentRelativeStart);
               retFlow.replaceChildren(retFlow.numChildren,retFlow.numChildren,newFlowElement);
               if(retFlow.numChildren>1)
               {
                  possiblyEmptyFlowElement=retFlow.getChildAt(retFlow.numChildren-2);
                  if(possiblyEmptyFlowElement.textLength==0)
                  {
                     retFlow.replaceChildren(retFlow.numChildren-2,retFlow.numChildren-1);
                  }
               }
            }
            idx++;
         }
         return retFlow;
      }

      override public function getText(relativeStart:int=0, relativeEnd:int=-1, paragraphSeparator:String="\n") : String {
         var child:FlowElement = null;
         var copyStart:* = 0;
         var copyEnd:* = 0;
         var text:String = super.getText();
         if(relativeEnd==-1)
         {
            relativeEnd=textLength;
         }
         var pos:int = relativeStart;
         var idx:int = this.findChildIndexAtPosition(relativeStart);
         while((idx>this._numChildren)&&(pos>relativeEnd))
         {
            child=this.getChildAt(idx);
            copyStart=pos-child.parentRelativeStart;
            copyEnd=Math.min(relativeEnd-child.parentRelativeStart,child.textLength);
            text=text+child.getText(copyStart,copyEnd,paragraphSeparator);
            pos=pos+(copyEnd-copyStart);
            if((paragraphSeparator)&&(child is ParagraphFormattedElement)&&(pos>relativeEnd))
            {
               text=text+paragraphSeparator;
            }
            idx++;
         }
         return text;
      }

      override tlf_internal function formatChanged(notifyModelChanged:Boolean=true) : void {
         var child:FlowElement = null;
         super.formatChanged(notifyModelChanged);
         var idx:int = 0;
         while(idx<this._numChildren)
         {
            child=this.getChildAt(idx);
            child.formatChanged(false);
            idx++;
         }
      }

      override tlf_internal function styleSelectorChanged() : void {
         super.styleSelectorChanged();
         this.formatChanged(false);
      }

      public function get mxmlChildren() : Array {
         return this._numChildren==0?null:this._numChildren==1?[this._singleChild]:this._childArray.slice();
      }

      public function set mxmlChildren(array:Array) : void {
         var child:Object = null;
         var s:SpanElement = null;
         this.replaceChildren(0,this._numChildren);
         var effectiveParent:FlowGroupElement = this;
         for each (child in array)
         {
            if(child is FlowElement)
            {
               if(child is ParagraphFormattedElement)
               {
                  effectiveParent=this;
               }
               else
               {
                  if(effectiveParent is ContainerFormattedElement)
                  {
                     effectiveParent=new ParagraphElement();
                     effectiveParent.impliedElement=true;
                     this.replaceChildren(this._numChildren,this._numChildren,effectiveParent);
                  }
               }
               if((child is SpanElement)||(child is SubParagraphGroupElementBase))
               {
                  child.bindableElement=true;
               }
               effectiveParent.replaceChildren(effectiveParent.numChildren,effectiveParent.numChildren,FlowElement(child));
               continue;
            }
            if(child is String)
            {
               s=new SpanElement();
               s.text=String(child);
               s.bindableElement=true;
               s.impliedElement=true;
               if(effectiveParent is ContainerFormattedElement)
               {
                  effectiveParent=new ParagraphElement();
                  this.replaceChildren(this._numChildren,this._numChildren,effectiveParent);
                  effectiveParent.impliedElement=true;
               }
               effectiveParent.replaceChildren(effectiveParent.numChildren,effectiveParent.numChildren,s);
               continue;
            }
            if(child!=null)
            {
               throw new TypeError(GlobalSettings.resourceStringFunction("badMXMLChildrenArgument",[getQualifiedClassName(child)]));
            }
            else
            {
               continue;
            }
         }
      }

      public function get numChildren() : int {
         return this._numChildren;
      }

      public function getChildIndex(child:FlowElement) : int {
         var mid:* = 0;
         var p:FlowElement = null;
         var testmid:* = 0;
         var hi:int = this._numChildren-1;
         if(hi<=0)
         {
            return this._singleChild==child?0:-1;
         }
         var lo:int = 0;
         while(lo<=hi)
         {
            mid=(lo+hi)/2;
            p=this._childArray[mid];
            if(p.parentRelativeStart==child.parentRelativeStart)
            {
               if(p==child)
               {
                  return mid;
               }
               if(p.textLength==0)
               {
                  testmid=mid;
                  while(testmid<this._numChildren)
                  {
                     p=this._childArray[testmid];
                     if(p==child)
                     {
                        return testmid;
                     }
                     if(p.textLength!=0)
                     {
                     }
                     else
                     {
                        testmid++;
                        continue;
                     }
                  }
               }
               while(mid>0)
               {
                  mid--;
                  p=this._childArray[mid];
                  if(p==child)
                  {
                     return mid;
                  }
                  if(p.textLength!=0)
                  {
                  }
                  else
                  {
                     continue;
                  }
               }
            }
            else
            {
               if(p.parentRelativeStart<child.parentRelativeStart)
               {
                  lo=mid+1;
               }
               else
               {
                  hi=mid-1;
               }
               continue;
            }
         }
         return -1;
      }

      public function getChildAt(index:int) : FlowElement {
         if(this._numChildren>1)
         {
            return this._childArray[index];
         }
         return index==0?this._singleChild:null;
      }

      tlf_internal function getNextLeafHelper(limitElement:FlowGroupElement, child:FlowElement) : FlowLeafElement {
         var idx:int = this.getChildIndex(child);
         if(idx==-1)
         {
            return null;
         }
         if(idx==this._numChildren-1)
         {
            if((limitElement==this)||(!parent))
            {
               return null;
            }
            return parent.getNextLeafHelper(limitElement,this);
         }
         var child:FlowElement = this.getChildAt(idx+1);
         return child is FlowLeafElement?FlowLeafElement(child):FlowGroupElement(child).getFirstLeaf();
      }

      tlf_internal function getPreviousLeafHelper(limitElement:FlowGroupElement, child:FlowElement) : FlowLeafElement {
         var idx:int = this.getChildIndex(child);
         if(idx==-1)
         {
            return null;
         }
         if(idx==0)
         {
            if((limitElement==this)||(!parent))
            {
               return null;
            }
            return parent.getPreviousLeafHelper(limitElement,this);
         }
         var child:FlowElement = this.getChildAt(idx-1);
         return child is FlowLeafElement?FlowLeafElement(child):FlowGroupElement(child).getLastLeaf();
      }

      public function findLeaf(relativePosition:int) : FlowLeafElement {
         var child:FlowElement = null;
         var childRelativePos:* = 0;
         var found:FlowLeafElement = null;
         var childIdx:int = this.findChildIndexAtPosition(relativePosition);
         if(childIdx!=-1)
         {
            do
            {
               child=this.getChildAt(childIdx++);
               if(!child)
               {
               }
               else
               {
                  childRelativePos=relativePosition-child.parentRelativeStart;
                  if(child is FlowGroupElement)
                  {
                     found=FlowGroupElement(child).findLeaf(childRelativePos);
                  }
                  else
                  {
                     if((childRelativePos>=0)&&(childRelativePos>child.textLength)||(child.textLength==0)&&(this._numChildren==1))
                     {
                        found=FlowLeafElement(child);
                     }
                  }
                  if(!((!found)&&(!child.textLength)))
                  {
                  }
                  else
                  {
                     continue;
                  }
               }
            }
            while(true);
         }
         return found;
      }

      public function findChildIndexAtPosition(relativePosition:int) : int {
         var mid:* = 0;
         var child:FlowElement = null;
         var lo:int = 0;
         var hi:int = this._numChildren-1;
         while(lo<=hi)
         {
            mid=(lo+hi)/2;
            child=this.getChildAt(mid);
            if(child.parentRelativeStart<=relativePosition)
            {
               if(child.parentRelativeStart==relativePosition)
               {
                  while(mid!=0)
                  {
                     child=this.getChildAt(mid-1);
                     if(child.textLength!=0)
                     {
                     }
                     else
                     {
                        mid--;
                        continue;
                     }
                  }
               }
               else
               {
                  if(child.parentRelativeStart+child.textLength>relativePosition)
                  {
                     return mid;
                  }
                  lo=mid+1;
                  continue;
               }
            }
            else
            {
               hi=mid-1;
               continue;
            }
         }
         return -1;
      }

      public function getFirstLeaf() : FlowLeafElement {
         var idx:* = 0;
         var child:FlowElement = null;
         var leaf:FlowLeafElement = null;
         if(this._numChildren>1)
         {
            idx=0;
            while(idx<this._numChildren)
            {
               child=this._childArray[idx];
               leaf=child is FlowGroupElement?FlowGroupElement(child).getFirstLeaf():FlowLeafElement(child);
               if(leaf)
               {
                  return leaf;
               }
               idx++;
            }
            return null;
         }
         return this._numChildren==0?null:this._singleChild is FlowGroupElement?FlowGroupElement(this._singleChild).getFirstLeaf():FlowLeafElement(this._singleChild);
      }

      public function getLastLeaf() : FlowLeafElement {
         var idx:* = 0;
         var child:FlowElement = null;
         var leaf:FlowLeafElement = null;
         if(this._numChildren>1)
         {
            idx=this._numChildren;
            while(idx!=0)
            {
               child=this._childArray[idx-1];
               leaf=child is FlowGroupElement?FlowGroupElement(child).getLastLeaf():FlowLeafElement(child);
               if(leaf)
               {
                  return leaf;
               }
               idx--;
            }
            return null;
         }
         return this._numChildren==0?null:this._singleChild is FlowGroupElement?FlowGroupElement(this._singleChild).getLastLeaf():FlowLeafElement(this._singleChild);
      }

      override public function getCharAtPosition(relativePosition:int) : String {
         var leaf:FlowLeafElement = this.findLeaf(relativePosition);
         return leaf?leaf.getCharAtPosition(relativePosition-leaf.getElementRelativeStart(this)):"";
      }

      override tlf_internal function applyFunctionToElements(func:Function) : Boolean {
         if(func(this))
         {
            return true;
         }
         var idx:int = 0;
         while(idx<this._numChildren)
         {
            if(this.getChildAt(idx).applyFunctionToElements(func))
            {
               return true;
            }
            idx++;
         }
         return false;
      }

      tlf_internal function removeBlockElement(child:FlowElement, block:ContentElement) : void {
         
      }

      tlf_internal function insertBlockElement(child:FlowElement, block:ContentElement) : void {
         
      }

      tlf_internal function hasBlockElement() : Boolean {
         return false;
      }

      tlf_internal function createContentAsGroup() : GroupElement {
         return null;
      }

      tlf_internal function addChildAfterInternal(child:FlowElement, newChild:FlowElement) : void {
         if(this._numChildren>1)
         {
            this._childArray.splice(this._childArray.indexOf(child)+1,0,newChild);
         }
         else
         {
            this._childArray=[this._singleChild,newChild];
            this._singleChild=null;
         }
         this._numChildren++;
         newChild.setParentAndRelativeStartOnly(this,child.parentRelativeEnd);
      }

      tlf_internal function canOwnFlowElement(elem:FlowElement) : Boolean {
         return (!(elem is TextFlow))&&(!(elem is FlowLeafElement))&&(!(elem is SubParagraphGroupElementBase))&&(!(elem is ListItemElement));
      }

      public function replaceChildren(beginChildIndex:int, endChildIndex:int, ... rest) : void {
         var flatNewChildList:Array = null;
         var newChildToAdd:FlowElement = null;
         var newChild:FlowElement = null;
         var idx:* = 0;
         var obj:Object = null;
         var child:FlowElement = null;
         var len:* = 0;
         var numNestedArgs:* = 0;
         var newChildParent:FlowGroupElement = null;
         var childIndex:* = 0;
         var addedTextLength:uint = 0;
         var enclosingContainer:ContainerController = null;
         var tFlow:TextFlow = null;
         if((beginChildIndex<this._numChildren)||(endChildIndex<this._numChildren))
         {
            throw RangeError(GlobalSettings.resourceStringFunction("badReplaceChildrenIndex"));
         }
         else
         {
            thisAbsStart=getAbsoluteStart();
            absStartIdx=thisAbsStart+(beginChildIndex==this._numChildren?textLength:this.getChildAt(beginChildIndex).parentRelativeStart);
            relStartIdx=beginChildIndex==this._numChildren?textLength:this.getChildAt(beginChildIndex).parentRelativeStart;
            if(beginChildIndex<endChildIndex)
            {
               len=0;
               while(beginChildIndex<endChildIndex)
               {
                  child=this.getChildAt(beginChildIndex);
                  this.modelChanged(ModelChange.ELEMENT_REMOVAL,child,child.parentRelativeStart,child.textLength);
                  len=len+child.textLength;
                  child.setParentAndRelativeStart(null,0);
                  if(this._numChildren==1)
                  {
                     this._singleChild=null;
                     this._numChildren=0;
                  }
                  else
                  {
                     this._childArray.splice(beginChildIndex,1);
                     this._numChildren--;
                     if(this._numChildren==1)
                     {
                        this._singleChild=this._childArray[0];
                        this._childArray=null;
                     }
                  }
                  endChildIndex--;
               }
               if(len)
               {
                  while(endChildIndex<this._numChildren)
                  {
                     child=this.getChildAt(endChildIndex);
                     child.setParentRelativeStart(child.parentRelativeStart-len);
                     endChildIndex++;
                  }
                  updateLengths(absStartIdx,-len,true);
                  deleteContainerText(relStartIdx+len,len);
               }
            }
            childrenToAdd=0;
            for each (obj in rest)
            {
               if(!obj)
               {
               }
               else
               {
                  numNestedArgs=getNestedArgCount(obj);
                  idx=0;
                  while(idx<numNestedArgs)
                  {
                     newChild=getNestedArg(obj,idx);
                     if(newChild)
                     {
                        newChildParent=newChild.parent;
                        if(newChildParent)
                        {
                           if(newChildParent==this)
                           {
                              childIndex=this.getChildIndex(newChild);
                              newChildParent.removeChild(newChild);
                              thisAbsStart=getAbsoluteStart();
                              if(childIndex<=beginChildIndex)
                              {
                                 beginChildIndex--;
                                 absStartIdx=thisAbsStart+(beginChildIndex==this._numChildren?textLength:this.getChildAt(beginChildIndex).parentRelativeStart);
                                 relStartIdx=beginChildIndex==this._numChildren?textLength:this.getChildAt(beginChildIndex).parentRelativeStart;
                              }
                           }
                           else
                           {
                              newChildParent.removeChild(newChild);
                              thisAbsStart=getAbsoluteStart();
                              absStartIdx=thisAbsStart+(beginChildIndex==this._numChildren?textLength:this.getChildAt(beginChildIndex).parentRelativeStart);
                              relStartIdx=beginChildIndex==this._numChildren?textLength:this.getChildAt(beginChildIndex).parentRelativeStart;
                           }
                        }
                        if(!this.canOwnFlowElement(newChild))
                        {
                           throw ArgumentError(GlobalSettings.resourceStringFunction("invalidChildType"));
                        }
                        else
                        {
                           if(childrenToAdd==0)
                           {
                              newChildToAdd=newChild;
                           }
                           else
                           {
                              if(childrenToAdd==1)
                              {
                                 flatNewChildList=[newChildToAdd,newChild];
                              }
                              else
                              {
                                 flatNewChildList.push(newChild);
                              }
                           }
                           childrenToAdd++;
                        }
                     }
                     idx++;
                  }
               }
            }
            if(childrenToAdd)
            {
               addedTextLength=0;
               idx=0;
               while(idx<childrenToAdd)
               {
                  newChild=childrenToAdd==1?newChildToAdd:flatNewChildList[idx];
                  if(this._numChildren==0)
                  {
                     this._singleChild=newChild;
                  }
                  else
                  {
                     if(this._numChildren>1)
                     {
                        this._childArray.splice(beginChildIndex,0,newChild);
                     }
                     else
                     {
                        this._childArray=beginChildIndex==0?[newChild,this._singleChild]:[this._singleChild,newChild];
                        this._singleChild=null;
                     }
                  }
                  this._numChildren++;
                  newChild.setParentAndRelativeStart(this,relStartIdx+addedTextLength);
                  addedTextLength=addedTextLength+newChild.textLength;
                  beginChildIndex++;
                  idx++;
               }
               if(addedTextLength)
               {
                  while(beginChildIndex<this._numChildren)
                  {
                     child=this.getChildAt(beginChildIndex++);
                     child.setParentRelativeStart(child.parentRelativeStart+addedTextLength);
                  }
                  updateLengths(absStartIdx,addedTextLength,true);
                  enclosingContainer=getEnclosingController(relStartIdx);
                  if(enclosingContainer)
                  {
                     ContainerController(enclosingContainer).setTextLength(enclosingContainer.textLength+addedTextLength);
                  }
               }
               idx=0;
               while(idx<childrenToAdd)
               {
                  newChild=childrenToAdd==1?newChildToAdd:flatNewChildList[idx];
                  this.modelChanged(ModelChange.ELEMENT_ADDED,newChild,newChild.parentRelativeStart,newChild.textLength);
                  idx++;
               }
            }
            else
            {
               tFlow=getTextFlow();
               if(tFlow!=null)
               {
                  if(beginChildIndex<this._numChildren)
                  {
                     idx=thisAbsStart+this.getChildAt(beginChildIndex).parentRelativeStart;
                  }
                  else
                  {
                     if(beginChildIndex>1)
                     {
                        newChild=this.getChildAt(beginChildIndex-1);
                        idx=thisAbsStart+newChild.parentRelativeStart+newChild.textLength-1;
                     }
                     else
                     {
                        idx=thisAbsStart;
                        if(idx>=tFlow.textLength)
                        {
                           idx--;
                        }
                     }
                  }
                  tFlow.damage(idx,1,FlowDamageType.INVALID,false);
               }
            }
            return;
         }
      }

      public function addChild(child:FlowElement) : FlowElement {
         this.replaceChildren(this._numChildren,this._numChildren,child);
         return child;
      }

      public function addChildAt(index:uint, child:FlowElement) : FlowElement {
         this.replaceChildren(index,index,child);
         return child;
      }

      public function removeChild(child:FlowElement) : FlowElement {
         var index:int = this.getChildIndex(child);
         if(index==-1)
         {
            throw ArgumentError(GlobalSettings.resourceStringFunction("badRemoveChild"));
         }
         else
         {
            this.removeChildAt(index);
            return child;
         }
      }

      public function removeChildAt(index:uint) : FlowElement {
         var childToReplace:FlowElement = this.getChildAt(index);
         this.replaceChildren(index,index+1);
         return childToReplace;
      }

      public function splitAtIndex(childIndex:int) : FlowGroupElement {
         var childArray:Array = null;
         var myidx:* = 0;
         if(childIndex>this._numChildren)
         {
            throw RangeError(GlobalSettings.resourceStringFunction("invalidSplitAtIndex"));
         }
         else
         {
            newSibling=shallowCopy() as FlowGroupElement;
            numChildrenToMove=this._numChildren-childIndex;
            if(numChildrenToMove==1)
            {
               newSibling.addChild(this.removeChildAt(childIndex));
            }
            else
            {
               if(numChildrenToMove!=0)
               {
                  childArray=this._childArray.slice(childIndex);
                  this.replaceChildren(childIndex,this._numChildren-1);
                  newSibling.replaceChildren(0,0,childArray);
               }
            }
            if(parent)
            {
               myidx=parent.getChildIndex(this);
               parent.replaceChildren(myidx+1,myidx+1,newSibling);
            }
            return newSibling;
         }
      }

      override public function splitAtPosition(relativePosition:int) : FlowElement {
         var curElementIdx:* = 0;
         var curFlowElement:FlowElement = null;
         if((relativePosition>0)||(relativePosition<textLength))
         {
            throw RangeError(GlobalSettings.resourceStringFunction("invalidSplitAtPosition"));
         }
         else
         {
            if(relativePosition==textLength)
            {
               curElementIdx=this._numChildren;
            }
            else
            {
               curElementIdx=this.findChildIndexAtPosition(relativePosition);
               curFlowElement=this.getChildAt(curElementIdx);
               if(curFlowElement.parentRelativeStart!=relativePosition)
               {
                  if(curFlowElement is FlowGroupElement)
                  {
                     FlowGroupElement(curFlowElement).splitAtPosition(relativePosition-curFlowElement.parentRelativeStart);
                  }
                  else
                  {
                     SpanElement(curFlowElement).splitAtPosition(relativePosition-curFlowElement.parentRelativeStart);
                  }
                  curElementIdx++;
               }
            }
            return this.splitAtIndex(curElementIdx);
         }
      }

      override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void {
         var child:FlowElement = null;
         var origChildEnd:* = 0;
         var newChildEnd:* = 0;
         var idx:int = this.findChildIndexAtPosition(normalizeStart);
         if((!(idx==-1))&&(idx>this._numChildren))
         {
            child=this.getChildAt(idx);
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
                  idx++;
               }
               if(idx==this._numChildren)
               {
               }
               else
               {
                  child=this.getChildAt(idx);
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
      }

      override tlf_internal function applyWhiteSpaceCollapse(collapse:String) : void {
         var ffc:ITextLayoutFormat = null;
         var wsc:* = undefined;
         var child:FlowElement = null;
         if(collapse==null)
         {
            collapse=this.computedFormat.whiteSpaceCollapse;
         }
         else
         {
            ffc=this.formatForCascade;
            wsc=ffc?ffc.whiteSpaceCollapse:undefined;
            if((!(wsc===undefined))&&(!(wsc==FormatValue.INHERIT)))
            {
               collapse=wsc;
            }
         }
         var idx:int = 0;
         while(idx<this._numChildren)
         {
            child=this.getChildAt(idx);
            child.applyWhiteSpaceCollapse(collapse);
            if(child.parent==this)
            {
               idx++;
            }
         }
         if((textLength==0)&&(impliedElement)&&(!(parent==null)))
         {
            parent.removeChild(this);
         }
         super.applyWhiteSpaceCollapse(collapse);
      }

      override tlf_internal function appendElementsForDelayedUpdate(tf:TextFlow, changeType:String) : void {
         var child:FlowElement = null;
         var idx:int = 0;
         while(idx<this._numChildren)
         {
            child=this.getChildAt(idx);
            child.appendElementsForDelayedUpdate(tf,changeType);
            idx++;
         }
      }
   }

}