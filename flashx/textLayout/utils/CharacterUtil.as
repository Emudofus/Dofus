package flashx.textLayout.utils
{
   public final class CharacterUtil extends Object
   {
      
      public function CharacterUtil() {
         super();
      }
      
      public static function isHighSurrogate(param1:int) : Boolean {
         return param1 >= 55296 && param1 <= 56319;
      }
      
      public static function isLowSurrogate(param1:int) : Boolean {
         return param1 >= 56320 && param1 <= 57343;
      }
      
      private static var whiteSpaceObject:Object = createWhiteSpaceObject();
      
      private static function createWhiteSpaceObject() : Object {
         var _loc1_:Object = new Object();
         _loc1_[32] = true;
         _loc1_[5760] = true;
         _loc1_[6158] = true;
         _loc1_[8192] = true;
         _loc1_[8193] = true;
         _loc1_[8194] = true;
         _loc1_[8195] = true;
         _loc1_[8196] = true;
         _loc1_[8197] = true;
         _loc1_[8198] = true;
         _loc1_[8199] = true;
         _loc1_[8200] = true;
         _loc1_[8201] = true;
         _loc1_[8202] = true;
         _loc1_[8239] = true;
         _loc1_[8287] = true;
         _loc1_[12288] = true;
         _loc1_[8232] = true;
         _loc1_[8233] = true;
         _loc1_[9] = true;
         _loc1_[10] = true;
         _loc1_[11] = true;
         _loc1_[12] = true;
         _loc1_[13] = true;
         _loc1_[133] = true;
         _loc1_[160] = true;
         return _loc1_;
      }
      
      public static function isWhitespace(param1:int) : Boolean {
         return whiteSpaceObject[param1];
      }
   }
}
