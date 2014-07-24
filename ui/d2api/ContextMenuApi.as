package d2api
{
   import d2data.ContextMenuData;
   
   public class ContextMenuApi extends Object
   {
      
      public function ContextMenuApi() {
         super();
      }
      
      public function registerMenuMaker(makerName:String, makerClass:Class) : void {
      }
      
      public function create(data:*, makerName:String = null, makerParams:Object = null) : ContextMenuData {
         return null;
      }
      
      public function getMenuMaker(makerName:String) : Object {
         return null;
      }
   }
}
