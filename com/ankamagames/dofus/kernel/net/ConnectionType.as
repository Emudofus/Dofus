package com.ankamagames.dofus.kernel.net
{
   public final class ConnectionType extends Object
   {
      
      public function ConnectionType() {
         super();
      }
      
      public static const DISCONNECTED:String = "disconnected";
      
      public static const TO_LOGIN_SERVER:String = "server_login";
      
      public static const TO_GAME_SERVER:String = "server_game";
      
      public static const TO_KOLI_SERVER:String = "server_koli";
   }
}
