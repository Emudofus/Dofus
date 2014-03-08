package com.ankamagames.dofus.kernel
{
   public final class PanicMessages extends Object
   {
      
      public function PanicMessages() {
         super();
      }
      
      public static const CONFIG_LOADING_FAILED:uint = 1;
      
      public static const I18N_LOADING_FAILED:uint = 2;
      
      public static const WRONG_CONTEXT_CREATED:uint = 3;
      
      public static const PROTOCOL_TOO_OLD:uint = 4;
      
      public static const PROTOCOL_TOO_NEW:uint = 5;
      
      public static function getMessage(param1:uint, param2:Array) : String {
         var errorId:uint = param1;
         var args:Array = param2;
         var errorMsg:String = "";
         try
         {
            switch(errorId)
            {
               case CONFIG_LOADING_FAILED:
                  errorMsg = "The Kernel was unable to load the main configuration file.\n" + "Your client installation may be corrupted.";
                  break;
               case I18N_LOADING_FAILED:
                  errorMsg = "The Kernel was unable to load the localization file.\n" + "Your client installation may be corrupted.\n\n" + "The requested language was \'" + args[0] + "\'.";
                  break;
               case WRONG_CONTEXT_CREATED:
                  errorMsg = "A wrong or unexpected game context (id " + args[0] + ") has been created.";
                  break;
               case PROTOCOL_TOO_OLD:
                  errorMsg = "The client protocol version (which is " + args[0] + ") is too old for the server.\n" + "The server needs protocol version " + args[1] + ".";
                  break;
               case PROTOCOL_TOO_NEW:
                  errorMsg = "The client protocol version (which is " + args[0] + ") is too new for the server.\n" + "The server can handle clients up to protocol version " + args[1] + ".";
                  break;
               default:
                  errorMsg = "Unknown error " + errorId;
            }
         }
         catch(e:Error)
         {
            errorMsg = "There was an error, and the error system failed to display that error.";
         }
         return errorMsg + "\n\n" + "Please contact the Ankama Games support with this error message.\n" + "http://support.ankama-games.com/";
      }
   }
}
