package com.ankamagames.jerakine.network.utils
{

    public class BooleanByteWrapper extends Object
    {

        public function BooleanByteWrapper()
        {
            return;
        }// end function

        public static function setFlag(param1:uint, param2:uint, param3:Boolean) : uint
        {
            switch(param2)
            {
                case 0:
                {
                    if (param3)
                    {
                        param1 = param1 | 1;
                    }
                    else
                    {
                        param1 = param1 & (255 - 1);
                    }
                    break;
                }
                case 1:
                {
                    if (param3)
                    {
                        param1 = param1 | 2;
                    }
                    else
                    {
                        param1 = param1 & 255 - 2;
                    }
                    break;
                }
                case 2:
                {
                    if (param3)
                    {
                        param1 = param1 | 4;
                    }
                    else
                    {
                        param1 = param1 & 255 - 4;
                    }
                    break;
                }
                case 3:
                {
                    if (param3)
                    {
                        param1 = param1 | 8;
                    }
                    else
                    {
                        param1 = param1 & 255 - 8;
                    }
                    break;
                }
                case 4:
                {
                    if (param3)
                    {
                        param1 = param1 | 16;
                    }
                    else
                    {
                        param1 = param1 & 255 - 16;
                    }
                    break;
                }
                case 5:
                {
                    if (param3)
                    {
                        param1 = param1 | 32;
                    }
                    else
                    {
                        param1 = param1 & 255 - 32;
                    }
                    break;
                }
                case 6:
                {
                    if (param3)
                    {
                        param1 = param1 | 64;
                    }
                    else
                    {
                        param1 = param1 & 255 - 64;
                    }
                    break;
                }
                case 7:
                {
                    if (param3)
                    {
                        param1 = param1 | 128;
                    }
                    else
                    {
                        param1 = param1 & 255 - 128;
                    }
                    break;
                }
                default:
                {
                    throw new Error("Bytebox overflow.");
                    break;
                }
            }
            return param1;
        }// end function

        public static function getFlag(param1:uint, param2:uint) : Boolean
        {
            switch(param2)
            {
                case 0:
                {
                    return (param1 & 1) != 0;
                }
                case 1:
                {
                    return (param1 & 2) != 0;
                }
                case 2:
                {
                    return (param1 & 4) != 0;
                }
                case 3:
                {
                    return (param1 & 8) != 0;
                }
                case 4:
                {
                    return (param1 & 16) != 0;
                }
                case 5:
                {
                    return (param1 & 32) != 0;
                }
                case 6:
                {
                    return (param1 & 64) != 0;
                }
                case 7:
                {
                    return (param1 & 128) != 0;
                }
                default:
                {
                    throw new Error("Bytebox overflow.");
                    break;
                }
            }
        }// end function

    }
}
