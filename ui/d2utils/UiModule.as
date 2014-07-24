package d2utils
{
   public class UiModule extends Object
   {
      
      public function UiModule() {
         super();
      }
      
      public function set loader(l:Object) : void {
      }
      
      public function get instanceId() : uint {
         return 0;
      }
      
      public function get id() : String {
         return null;
      }
      
      public function get name() : String {
         return null;
      }
      
      public function get version() : String {
         return null;
      }
      
      public function get gameVersion() : String {
         return null;
      }
      
      public function get author() : String {
         return null;
      }
      
      public function get shortDescription() : String {
         return null;
      }
      
      public function get description() : String {
         return null;
      }
      
      public function get iconUri() : Object {
         return null;
      }
      
      public function get script() : String {
         return null;
      }
      
      public function get shortcuts() : String {
         return null;
      }
      
      public function get uis() : Object {
         return null;
      }
      
      public function get trusted() : Boolean {
         return false;
      }
      
      public function set trusted(v:Boolean) : void {
      }
      
      public function get enable() : Boolean {
         return false;
      }
      
      public function set enable(v:Boolean) : void {
      }
      
      public function get rootPath() : String {
         return null;
      }
      
      public function get storagePath() : String {
         return null;
      }
      
      public function get cachedFiles() : Object {
         return null;
      }
      
      public function get apiList() : Object {
         return null;
      }
      
      public function set applicationDomain(appDomain:Object) : void {
      }
      
      public function get applicationDomain() : Object {
         return null;
      }
      
      public function get mainClass() : Object {
         return null;
      }
      
      public function set mainClass(instance:Object) : void {
      }
      
      public function get groups() : Object {
         return null;
      }
      
      public function get rawXml() : Object {
         return null;
      }
      
      public function addUiGroup(groupName:String, exclusive:Boolean, permanent:Boolean) : void {
      }
      
      public function getUi(name:String) : UiData {
         return null;
      }
      
      public function toString() : String {
         return null;
      }
      
      public function destroy() : void {
      }
      
      public function usedApiList(callBack:Function) : void {
      }
      
      public function usedHookList(callBack:Function) : void {
      }
      
      public function usedActionList(callBack:Function) : void {
      }
   }
}
