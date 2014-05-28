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
         var _loc2_:TextFlow = null;
         var _loc1_:IListMarkerFormat = this.getUserStyleWorker(ListElement.LIST_MARKER_FORMAT_NAME) as IListMarkerFormat;
         if(_loc1_ == null)
         {
            _loc2_ = this.getTextFlow();
            if(_loc2_)
            {
               _loc1_ = _loc2_.configuration.defaultListMarkerFormat;
            }
         }
         return _loc1_;
      }
      
      tlf_internal function normalizeNeedsInitialParagraph() : Boolean {
         var _loc1_:FlowGroupElement = this;
         while(_loc1_)
         {
            _loc1_ = _loc1_.getChildAt(0) as FlowGroupElement;
            if(_loc1_ is ParagraphElement)
            {
               return false;
            }
            if(!(_loc1_ is DivElement))
            {
               return true;
            }
         }
         return true;
      }
      
      override tlf_internal function normalizeRange(param1:uint, param2:uint) : void {
         var _loc3_:ParagraphElement = null;
         super.normalizeRange(param1,param2);
         this._listNumberHint = int.MAX_VALUE;
         if(this.normalizeNeedsInitialParagraph())
         {
            _loc3_ = new ParagraphElement();
            _loc3_.replaceChildren(0,0,new SpanElement());
            replaceChildren(0,0,_loc3_);
            _loc3_.normalizeRange(0,_loc3_.textLength);
         }
      }
      
      tlf_internal function getListItemNumber(param1:IListMarkerFormat=null) : int {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:* = 0;
         var _loc5_:ListItemElement = null;
         if(this._listNumberHint == int.MAX_VALUE)
         {
            if(param1 == null)
            {
               param1 = this.computedListMarkerFormat();
            }
            _loc2_ = param1.counterReset;
            if((_loc2_) && (_loc2_.hasOwnProperty("ordered")))
            {
               this._listNumberHint = _loc2_.ordered;
            }
            else
            {
               _loc4_ = parent.getChildIndex(this);
               this._listNumberHint = 0;
               while(_loc4_ > 0)
               {
                  _loc4_--;
                  _loc5_ = parent.getChildAt(_loc4_) as ListItemElement;
                  if(_loc5_)
                  {
                     this._listNumberHint = _loc5_.getListItemNumber();
                     break;
                  }
               }
            }
            _loc3_ = param1.counterIncrement;
            this._listNumberHint = this._listNumberHint + ((_loc3_) && (_loc3_.hasOwnProperty("ordered"))?_loc3_.ordered:1);
         }
         return this._listNumberHint;
      }
   }
}
