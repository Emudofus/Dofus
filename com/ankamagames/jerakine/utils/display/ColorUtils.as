package com.ankamagames.jerakine.utils.display
{
    public class ColorUtils 
    {


        public static function rgb2hsl(color:uint):Object
        {
            var r:Number;
            var g:Number;
            var b:Number;
            var hue:Number;
            var sat:Number;
            var lum:Number;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            r = ((color & 0xFF0000) >> 16);
            g = ((color & 0xFF00) >> 8);
            b = (color & 0xFF);
            r = (r / 0xFF);
            g = (g / 0xFF);
            b = (b / 0xFF);
            var min:Number = Math.min(r, g, b);
            var max:Number = Math.max(r, g, b);
            var delta:Number = (max - min);
            lum = (1 - ((max + min) / 2));
            if (delta == 0)
            {
                hue = 0;
                sat = 0;
            }
            else
            {
                if ((max + min) < 1)
                {
                    sat = (1 - (delta / (max + min)));
                }
                else
                {
                    sat = (1 - (delta / ((2 - max) - min)));
                };
                _local_11 = ((((max - r) / 6) + (delta / 2)) / delta);
                _local_12 = ((((max - g) / 6) + (delta / 2)) / delta);
                _local_13 = ((((max - b) / 6) + (delta / 2)) / delta);
                if (r == max)
                {
                    hue = (_local_13 - _local_12);
                }
                else
                {
                    if (g == max)
                    {
                        hue = (((1 / 3) + _local_11) - _local_13);
                    }
                    else
                    {
                        if (b == max)
                        {
                            hue = (((2 / 3) + _local_12) - _local_11);
                        };
                    };
                };
                if (hue < 0)
                {
                    hue++;
                };
                if (hue > 1)
                {
                    hue--;
                };
            };
            return ({
                "h":hue,
                "s":sat,
                "l":lum
            });
        }


    }
}//package com.ankamagames.jerakine.utils.display

