package com.ankamagames.jerakine.types.enums
{

    public class Priority extends Object
    {
        public static const LOG:int = 10;
        public static const ULTIMATE_HIGHEST_DEPTH_OF_DOOM:int = 3;
        public static const HIGHEST:int = 2;
        public static const HIGH:int = 1;
        public static const NORMAL:int = 0;
        public static const LOW:int = -1;
        public static const LOWEST:int = -2;

        public function Priority()
        {
            return;
        }// end function

        public static function toString(param1:int) : String
        {
            switch(param1)
            {
                case LOG:
                {
                    return "LOG";
                }
                case ULTIMATE_HIGHEST_DEPTH_OF_DOOM:
                {
                    return "ULTIMATE_HIGHEST_DEPTH_OF_DOOM";
                }
                case HIGHEST:
                {
                    return "HIGHEST";
                }
                case HIGH:
                {
                    return "HIGH";
                }
                case NORMAL:
                {
                    return "NORMAL";
                }
                case LOW:
                {
                    return "LOW";
                }
                case LOWEST:
                {
                    return "LOWEST";
                }
                default:
                {
                    return "UNKNOW";
                    break;
                }
            }
        }// end function

        public static function fromString(param1:String) : int
        {
            switch(param1)
            {
                case "LOG":
                {
                    return LOG;
                }
                case "ULTIMATE_HIGHEST_DEPTH_OF_DOOM":
                {
                    return ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
                }
                case "HIGHEST":
                {
                    return HIGHEST;
                }
                case "HIGH":
                {
                    return HIGH;
                }
                case "NORMAL":
                {
                    return NORMAL;
                }
                case "LOW":
                {
                    return LOW;
                }
                case "LOWEST":
                {
                    return LOWEST;
                }
                default:
                {
                    return 666;
                    break;
                }
            }
        }// end function

    }
}
