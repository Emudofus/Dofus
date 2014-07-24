package d2enums
{
   public class ServerStatusEnum extends Object
   {
      
      public function ServerStatusEnum() {
         super();
      }
      
      public static const STATUS_UNKNOWN:uint = 0;
      
      public static const OFFLINE:uint = 1;
      
      public static const STARTING:uint = 2;
      
      public static const ONLINE:uint = 3;
      
      public static const NOJOIN:uint = 4;
      
      public static const SAVING:uint = 5;
      
      public static const STOPING:uint = 6;
      
      public static const FULL:uint = 7;
   }
}
