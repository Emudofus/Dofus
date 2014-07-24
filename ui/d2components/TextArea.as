package d2components
{
   public class TextArea extends Label
   {
      
      public function TextArea() {
         super();
      }
      
      public function get scrollBottomMargin() : int {
         return 0;
      }
      
      public function set scrollBottomMargin(value:int) : void {
      }
      
      public function get scrollTopMargin() : int {
         return 0;
      }
      
      public function set scrollTopMargin(value:int) : void {
      }
      
      public function set scrollCss(sUrl:Object) : void {
      }
      
      public function get scrollCss() : Object {
         return null;
      }
      
      public function set scrollPos(nValue:int) : void {
      }
      
      public function get hideScroll() : Boolean {
         return false;
      }
      
      public function set hideScroll(hideScroll:Boolean) : void {
      }
   }
}
