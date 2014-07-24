package d2api
{
   import d2data.Mount;
   import d2data.ItemWrapper;
   
   public class MountApi extends Object
   {
      
      public function MountApi() {
         super();
      }
      
      public function getRiderEntityLook(look:*) : Object {
         return null;
      }
      
      public function getMount(modelId:uint) : Mount {
         return null;
      }
      
      public function getStableList() : Object {
         return null;
      }
      
      public function getPaddockList() : Object {
         return null;
      }
      
      public function getInventoryList() : Object {
         return null;
      }
      
      public function getCurrentPaddock() : Object {
         return null;
      }
      
      public function isCertificateValid(certificate:ItemWrapper) : Boolean {
         return false;
      }
   }
}
