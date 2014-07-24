package d2api
{
   public class ConfigApi extends Object
   {
      
      public function ConfigApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getConfigProperty(configModuleName:String, propertyName:String) : * {
         return null;
      }
      
      public function setConfigProperty(configModuleName:String, propertyName:String, value:*) : void {
      }
      
      public function resetConfigProperty(configModuleName:String, propertyName:String) : void {
      }
      
      public function createOptionManager(name:String) : Object {
         return null;
      }
      
      public function getAllThemes() : Object {
         return null;
      }
      
      public function getCurrentTheme() : String {
         return null;
      }
      
      public function isOptionalFeatureActive(id:int) : Boolean {
         return false;
      }
      
      public function getServerConstant(id:int) : Object {
         return null;
      }
      
      public function getExternalNotificationOptions(pNotificationType:int) : Object {
         return null;
      }
      
      public function setExternalNotificationOptions(pNotificationType:int, pOptions:Object) : void {
      }
      
      public function setDebugMode(activate:Boolean) : void {
      }
      
      public function getDebugMode() : Boolean {
         return false;
      }
      
      public function debugFileExists() : Boolean {
         return false;
      }
   }
}
