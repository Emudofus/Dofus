package d2components
{
   public class ScrollContainer extends GraphicContainer
   {
      
      public function ScrollContainer() {
         super();
      }
      
      public function set finalized(b:Boolean) : void {
      }
      
      public function get finalized() : Boolean {
         return false;
      }
      
      public function set scrollbarCss(sValue:Object) : void {
      }
      
      public function get verticalScrollSpeed() : Number {
         return 0;
      }
      
      public function set verticalScrollSpeed(speed:Number) : void {
      }
      
      public function set verticalScrollbarValue(value:int) : void {
      }
      
      public function get verticalScrollbarValue() : int {
         return 0;
      }
      
      public function get useHorizontalScroll() : Boolean {
         return false;
      }
      
      public function set useHorizontalScroll(yes:Boolean) : void {
      }
      
      public function get horizontalScrollSpeed() : Number {
         return 0;
      }
      
      public function set horizontalScrollSpeed(speed:Number) : void {
      }
      
      public function set horizontalScrollbarValue(value:int) : void {
      }
      
      public function get horizontalScrollbarValue() : int {
         return 0;
      }
      
      public function finalize() : void {
      }
   }
}
