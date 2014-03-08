package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public final class SubParagraphGroupElement extends SubParagraphGroupElementBase
   {
      
      public function SubParagraphGroupElement() {
         super();
      }
      
      override protected function get abstract() : Boolean {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String {
         return "g";
      }
      
      override tlf_internal function get precedence() : uint {
         return kMinSPGEPrecedence;
      }
      
      override tlf_internal function get allowNesting() : Boolean {
         return true;
      }
      
      override tlf_internal function mergeToPreviousIfPossible() : Boolean {
         var _loc1_:* = 0;
         var _loc2_:SubParagraphGroupElement = null;
         if((parent) && (!bindableElement) && !hasActiveEventMirror())
         {
            _loc1_ = parent.getChildIndex(this);
            if(_loc1_ != 0)
            {
               _loc2_ = parent.getChildAt(_loc1_-1) as SubParagraphGroupElement;
               if(_loc2_ == null || (_loc2_.hasActiveEventMirror()))
               {
                  return false;
               }
               if(equalStylesForMerge(_loc2_))
               {
                  parent.removeChildAt(_loc1_);
                  if(numChildren > 0)
                  {
                     _loc2_.replaceChildren(_loc2_.numChildren,_loc2_.numChildren,this.mxmlChildren);
                  }
                  return true;
               }
            }
         }
         return false;
      }
   }
}
