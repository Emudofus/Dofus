package d2components
{
   public class SwfApplication extends GraphicContainer
   {
      
      public function SwfApplication() {
         super();
      }
      
      public function set uri(v:Object) : void {
      }
      
      public function get uri() : Object {
         return null;
      }
      
      public function get loadedHandler() : Function {
         return new Function();
      }
      
      public function set loadedHandler(v:Function) : void {
      }
      
      public function get loadErrorHandler() : Function {
         return new Function();
      }
      
      public function set loadErrorHandler(v:Function) : void {
      }
      
      public function get loadProgressHandler() : Function {
         return new Function();
      }
      
      public function set loadProgressHandler(v:Function) : void {
      }
      
      public function bindApi(propertyName:String, value:*) : Boolean {
         return false;
      }
   }
}
