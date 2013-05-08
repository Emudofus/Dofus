package flashx.textLayout
{

   use namespace tlf_internal;

   public class TextLayoutVersion extends Object
   {
         

      public function TextLayoutVersion() {
         super();
      }

      public static const CURRENT_VERSION:uint = 33554432;

      public static const VERSION_2_0:uint = 33554432;

      public static const VERSION_1_0:uint = 16777216;

      public static const VERSION_1_1:uint = 16842752;

      tlf_internal  static const BUILD_NUMBER:String = "232 (759049)";

      tlf_internal  static const BRANCH:String = "2.0";

      public static const AUDIT_ID:String = "<AdobeIP 0000486>";

      tlf_internal  static function getVersionString(version:uint) : String {
         var major:uint = version>>24&255;
         var minor:uint = version>>16&255;
         var update:uint = version&65535;
         return major.toString()+"."+minor.toString()+"."+update.toString();
      }

      public function dontStripAuditID() : String {
         return AUDIT_ID;
      }
   }

}