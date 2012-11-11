package com.ankamagames.jerakine.json
{

    public class JSON extends Object
    {

        public function JSON()
        {
            return;
        }// end function

        public static function encode(param1:Object, param2:uint = 0, param3:Boolean = false) : String
        {
            return new JSONEncoder(param1, param2, param3).getString();
        }// end function

        public static function decode(param1:String, param2:Boolean = true)
        {
            return new JSONDecoder(param1, param2).getValue();
        }// end function

    }
}
