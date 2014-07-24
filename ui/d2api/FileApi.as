package d2api
{
   import d2utils.ModuleFilestream;
   
   public class FileApi extends Object
   {
      
      public function FileApi() {
         super();
      }
      
      public function loadXmlFile(url:String, loadSuccessCallBack:Function, loadErrorCallBack:Function = null) : void {
      }
      
      public function trustedLoadXmlFile(url:String, loadSuccessCallBack:Function, loadErrorCallBack:Function = null) : void {
      }
      
      public function openFile(url:String, openMode:String = "update") : ModuleFilestream {
         return null;
      }
      
      public function deleteFile(url:String) : void {
      }
      
      public function deleteDir(url:String, recursive:Boolean = true) : void {
      }
      
      public function getDirectoryContent(url:String = null, hideFiles:Boolean = false, hideDirectories:Boolean = false) : Object {
         return null;
      }
      
      public function isDirectory(url:String) : Boolean {
         return false;
      }
      
      public function createDirectory(url:String) : void {
      }
      
      public function getAvaibleSpace() : uint {
         return 0;
      }
      
      public function getUsedSpace() : uint {
         return 0;
      }
      
      public function getMaxSpace() : uint {
         return 0;
      }
      
      public function getUsedFileCount() : uint {
         return 0;
      }
      
      public function getMaxFileCount() : uint {
         return 0;
      }
   }
}
