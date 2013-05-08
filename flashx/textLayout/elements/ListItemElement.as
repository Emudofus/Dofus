package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.formats.IListMarkerFormat;

   use namespace tlf_internal;

   public final class ListItemElement extends ContainerFormattedElement
   {
         

      public function ListItemElement() {
         super();
      }



      tlf_internal var _listNumberHint:int = 2.147483647E9;

      override protected function get abstract() : Boolean {
         return false;
      }

      override tlf_internal function get defaultTypeName() : String {
         return "li";
      }

      tlf_internal function computedListMarkerFormat() : IListMarkerFormat {
         var tf:TextFlow = null;
         var format:IListMarkerFormat = this.getUserStyleWorker(ListElement.LIST_MARKER_FORMAT_NAME) as IListMarkerFormat;
         if(format==null)
         {
            tf=this.getTextFlow();
            if(tf)
            {
               format=tf.configuration.defaultListMarkerFormat;
            }
         }
         return format;
      }

      tlf_internal function normalizeNeedsInitialParagraph() : Boolean {
         var p:FlowGroupElement = this;
         while(p)
         {
            p=p.getChildAt(0) as FlowGroupElement;
            if(p is ParagraphElement)
            {
               return false;
            }
            if(!(p is DivElement))
            {
               return true;
            }
         }
         return true;
      }

      override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void {
         var p:ParagraphElement = null;
         super.normalizeRange(normalizeStart,normalizeEnd);
         this._listNumberHint=int.MAX_VALUE;
         if(this.normalizeNeedsInitialParagraph())
         {
            p=new ParagraphElement();
            p.replaceChildren(0,0,new SpanElement());
            replaceChildren(0,0,p);
            p.normalizeRange(0,p.textLength);
         }
      }

      tlf_internal function getListItemNumber(listMarkerFormat:IListMarkerFormat=null) : int {
         var counterReset:Object = null;
         var counterIncrement:Object = null;
         var idx:* = 0;
         var sibling:ListItemElement = null;
         if(this._listNumberHint==int.MAX_VALUE)
         {
            if(listMarkerFormat==null)
            {
               listMarkerFormat=this.computedListMarkerFormat();
            }
            counterReset=listMarkerFormat.counterReset;
            if((counterReset)&&(counterReset.hasOwnProperty("ordered")))
            {
               this._listNumberHint=counterReset.ordered;
            }
            else
            {
               idx=parent.getChildIndex(this);
               this._listNumberHint=0;
               while(idx>0)
               {
                  idx--;
                  sibling=parent.getChildAt(idx) as ListItemElement;
                  if(sibling)
                  {
                     this._listNumberHint=sibling.getListItemNumber();
                  }
                  else
                  {
                     continue;
                  }
               }
            }
            counterIncrement=listMarkerFormat.counterIncrement;
            this._listNumberHint=this._listNumberHint+((counterIncrement)&&(counterIncrement.hasOwnProperty("ordered"))?counterIncrement.ordered:1);
         }
         return this._listNumberHint;
      }
   }

}