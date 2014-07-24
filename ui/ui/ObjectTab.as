package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   
   public class ObjectTab extends Object
   {
      
      public function ObjectTab() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public function main(oParam:Object = null) : void {
      }
      
      public function onRelease(target:Object) : void {
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
      }
      
      public function unload() : void {
      }
   }
}
