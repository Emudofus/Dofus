package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   import flash.text.engine.TextLine;
   import flash.geom.Rectangle;
   import flashx.textLayout.formats.BlockProgression;
   import flash.text.engine.TextRotation;

   use namespace tlf_internal;

   public final class TCYElement extends SubParagraphGroupElementBase
   {
         

      public function TCYElement() {
         super();
      }



      override tlf_internal function createContentElement() : void {
         super.createContentElement();
         this.updateTCYRotation();
      }

      override protected function get abstract() : Boolean {
         return false;
      }

      override tlf_internal function get defaultTypeName() : String {
         return "tcy";
      }

      override tlf_internal function get precedence() : uint {
         return 100;
      }

      override tlf_internal function mergeToPreviousIfPossible() : Boolean {
         var myidx:* = 0;
         var prevEl:TCYElement = null;
         var xferEl:FlowElement = null;
         if((parent)&&(!bindableElement))
         {
            myidx=parent.getChildIndex(this);
            if(myidx!=0)
            {
               prevEl=parent.getChildAt(myidx-1) as TCYElement;
               if(prevEl)
               {
                  while(this.numChildren>0)
                  {
                     xferEl=this.getChildAt(0);
                     replaceChildren(0,1);
                     prevEl.replaceChildren(prevEl.numChildren,prevEl.numChildren,xferEl);
                  }
                  parent.replaceChildren(myidx,myidx+1);
                  return true;
               }
            }
         }
         return false;
      }

      override tlf_internal function acceptTextBefore() : Boolean {
         return false;
      }

      override tlf_internal function setParentAndRelativeStart(newParent:FlowGroupElement, newStart:int) : void {
         super.setParentAndRelativeStart(newParent,newStart);
         this.updateTCYRotation();
      }

      override tlf_internal function formatChanged(notifyModelChanged:Boolean=true) : void {
         super.formatChanged(notifyModelChanged);
         this.updateTCYRotation();
      }

      tlf_internal function calculateAdornmentBounds(spg:SubParagraphGroupElementBase, tLine:TextLine, blockProgression:String, spgRect:Rectangle) : void {
         var curChild:FlowElement = null;
         var curFlowLeaf:FlowLeafElement = null;
         var curBounds:Rectangle = null;
         var childCount:int = 0;
         while(childCount<spg.numChildren)
         {
            curChild=spg.getChildAt(childCount) as FlowElement;
            curFlowLeaf=curChild as FlowLeafElement;
            if((!curFlowLeaf)&&(curChild is SubParagraphGroupElementBase))
            {
               this.calculateAdornmentBounds(curChild as SubParagraphGroupElementBase,tLine,blockProgression,spgRect);
               childCount++;
            }
            else
            {
               curBounds=null;
               if(!(curFlowLeaf is InlineGraphicElement))
               {
                  curBounds=curFlowLeaf.getSpanBoundsOnLine(tLine,blockProgression)[0];
               }
               else
               {
                  curBounds=(curFlowLeaf as InlineGraphicElement).graphic.getBounds(tLine);
               }
               if(childCount!=0)
               {
                  if(curBounds.top<spgRect.top)
                  {
                     spgRect.top=curBounds.top;
                  }
                  if(curBounds.bottom>spgRect.bottom)
                  {
                     spgRect.bottom=curBounds.bottom;
                  }
                  if(spgRect.x>curBounds.x)
                  {
                     spgRect.x=curBounds.x;
                  }
               }
               else
               {
                  spgRect.top=curBounds.top;
                  spgRect.bottom=curBounds.bottom;
                  spgRect.x=curBounds.x;
               }
               childCount++;
            }
         }
      }

      private function updateTCYRotation() : void {
         var contElement:ContainerFormattedElement = getAncestorWithContainer();
         if(groupElement)
         {
            groupElement.textRotation=(contElement)&&(contElement.computedFormat.blockProgression==BlockProgression.RL)?TextRotation.ROTATE_270:TextRotation.ROTATE_0;
         }
      }
   }

}