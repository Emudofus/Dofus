package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.formats.WhiteSpaceCollapse;
   
   use namespace tlf_internal;
   
   public class SpecialCharacterElement extends SpanElement
   {
      
      public function SpecialCharacterElement() {
         super();
         whiteSpaceCollapse = WhiteSpaceCollapse.PRESERVE;
      }
      
      override tlf_internal function mergeToPreviousIfPossible() : Boolean {
         var _loc1_:* = 0;
         var _loc2_:SpanElement = null;
         var _loc3_:SpanElement = null;
         var _loc4_:* = 0;
         if(parent)
         {
            _loc1_ = parent.getChildIndex(this);
            if(_loc1_ != 0)
            {
               _loc3_ = parent.getChildAt(_loc1_-1) as SpanElement;
               if(!(_loc3_ == null) && _loc3_ is SpanElement && (TextLayoutFormat.isEqual(_loc3_.format,format)))
               {
                  _loc4_ = _loc3_.textLength;
                  _loc3_.replaceText(_loc4_,_loc4_,this.text);
                  parent.replaceChildren(_loc1_,_loc1_ + 1);
                  return true;
               }
            }
            _loc2_ = new SpanElement();
            _loc2_.text = this.text;
            _loc2_.format = format;
            parent.replaceChildren(_loc1_,_loc1_ + 1,_loc2_);
            _loc2_.normalizeRange(0,_loc2_.textLength);
            return false;
         }
         return false;
      }
   }
}
