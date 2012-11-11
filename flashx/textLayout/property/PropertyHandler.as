package flashx.textLayout.property
{

    public class PropertyHandler extends Object
    {

        public function PropertyHandler()
        {
            return;
        }// end function

        public function get customXMLStringHandler() : Boolean
        {
            return false;
        }// end function

        public function toXMLString(param1:Object) : String
        {
            return null;
        }// end function

        public function owningHandlerCheck(param1)
        {
            return undefined;
        }// end function

        public function setHelper(param1)
        {
            return param1;
        }// end function

        public static function createRange(param1:Array) : Object
        {
            var _loc_2:* = new Object();
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2[param1[_loc_3]] = null;
                _loc_3++;
            }
            return _loc_2;
        }// end function

    }
}
