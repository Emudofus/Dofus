package com.ankamagames.dofus.network.enums
{
   public class CharacterDeletionErrorEnum extends Object
   {
      
      public function CharacterDeletionErrorEnum() {
         super();
      }
      
      public static const DEL_ERR_NO_REASON:uint = 1;
      
      public static const DEL_ERR_TOO_MANY_CHAR_DELETION:uint = 2;
      
      public static const DEL_ERR_BAD_SECRET_ANSWER:uint = 3;
      
      public static const DEL_ERR_RESTRICED_ZONE:uint = 4;
   }
}
