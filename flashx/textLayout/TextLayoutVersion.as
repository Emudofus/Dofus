package flashx.textLayout
{

    public class TextLayoutVersion extends Object
    {
        public static const CURRENT_VERSION:uint = 33554432;
        public static const VERSION_2_0:uint = 33554432;
        public static const VERSION_1_0:uint = 16777216;
        public static const VERSION_1_1:uint = 16842752;
        static const BUILD_NUMBER:String = "232 (759049)";
        static const BRANCH:String = "2.0";
        public static const AUDIT_ID:String = "<AdobeIP 0000486>";

        public function TextLayoutVersion()
        {
            return;
        }// end function

        public function dontStripAuditID() : String
        {
            return AUDIT_ID;
        }// end function

        static function getVersionString(param1:uint) : String
        {
            var _loc_2:* = param1 >> 24 & 255;
            var _loc_3:* = param1 >> 16 & 255;
            var _loc_4:* = param1 & 65535;
            return _loc_2.toString() + "." + _loc_3.toString() + "." + _loc_4.toString();
        }// end function

    }
}
