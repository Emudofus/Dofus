package d2api
{
   public class SecurityApi extends Object
   {
      
      public function SecurityApi() {
         super();
      }
      
      public function askSecureModeCode(callback:Function) : void {
      }
      
      public function sendSecureModeCode(code:String, callback:Function, computerName:String = null) : void {
      }
      
      public function SecureModeisActive() : Boolean {
         return false;
      }
      
      public function setShieldLevel(level:uint) : void {
      }
      
      public function getShieldLevel() : uint {
         return 0;
      }
   }
}
