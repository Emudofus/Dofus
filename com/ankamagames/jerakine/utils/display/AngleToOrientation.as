package com.ankamagames.jerakine.utils.display
{
    public class AngleToOrientation 
    {


        public static function angleToOrientation(radianAngle:Number):uint
        {
            var orientation:uint;
            switch (true)
            {
                case (((radianAngle > -((Math.PI / 8)))) && ((radianAngle <= (Math.PI / 8)))):
                    orientation = 0;
                    break;
                case (((radianAngle > -((Math.PI * (3 / 8))))) && ((radianAngle <= -((Math.PI / 8))))):
                    orientation = 7;
                    break;
                case (((radianAngle > -((Math.PI * (5 / 8))))) && ((radianAngle <= -((Math.PI * (3 / 8)))))):
                    orientation = 6;
                    break;
                case (((radianAngle > -((Math.PI * (7 / 8))))) && ((radianAngle <= -((Math.PI * (5 / 8)))))):
                    orientation = 5;
                    break;
                case (((radianAngle > (Math.PI * (7 / 8)))) || ((radianAngle <= -((Math.PI * (7 / 8)))))):
                    orientation = 4;
                    break;
                case (((radianAngle > (Math.PI * (5 / 8)))) && ((radianAngle <= (Math.PI * (7 / 8))))):
                    orientation = 3;
                    break;
                case (((radianAngle > (Math.PI * (3 / 8)))) && ((radianAngle <= (Math.PI * (5 / 8))))):
                    orientation = 2;
                    break;
                case (((radianAngle > (Math.PI / 8))) && ((radianAngle <= (Math.PI * (3 / 8))))):
                    orientation = 1;
                    break;
            };
            return (orientation);
        }


    }
}//package com.ankamagames.jerakine.utils.display

