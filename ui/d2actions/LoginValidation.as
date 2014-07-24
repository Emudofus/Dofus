package d2actions
{
   public class LoginValidation extends Object implements IAction
   {
      
      public function LoginValidation(username:String, password:String, autoSelectServer:Boolean, serverId:uint = 0) {
         super();
         this._params = [username,password,autoSelectServer,serverId];
      }
      
      public static const NEED_INTERACTION:Boolean = false;
      
      public static const NEED_CONFIRMATION:Boolean = false;
      
      public static const MAX_USE_PER_FRAME:int = 1;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
