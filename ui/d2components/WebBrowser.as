package d2components
{
   public class WebBrowser extends GraphicContainer
   {
      
      public function WebBrowser() {
         super();
      }
      
      public function get cacheLife() : Number {
         return 0;
      }
      
      public function set cacheLife(value:Number) : void {
      }
      
      public function get cacheId() : String {
         return null;
      }
      
      public function set cacheId(value:String) : void {
      }
      
      public function set scrollCss(sUrl:Object) : void {
      }
      
      public function get scrollCss() : Object {
         return null;
      }
      
      public function set displayScrollBar(b:Boolean) : void {
      }
      
      public function get displayScrollBar() : Boolean {
         return false;
      }
      
      public function set scrollTopOffset(v:int) : void {
      }
      
      public function get finalized() : Boolean {
         return false;
      }
      
      public function set finalized(b:Boolean) : void {
      }
      
      public function get fromCache() : Boolean {
         return false;
      }
      
      public function get location() : String {
         return null;
      }
      
      public function finalize() : void {
      }
      
      public function setBlankLink(linkPattern:String, blank:Boolean) : void {
      }
      
      public function hasContent() : Boolean {
         return false;
      }
      
      public function load(urlRequest:Object) : void {
      }
      
      public function javascriptSetVar(varName:String, value:*) : void {
      }
      
      public function javascriptCall(fctName:String, ... params) : void {
      }
   }
}
