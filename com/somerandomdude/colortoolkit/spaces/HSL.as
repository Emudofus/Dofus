package com.somerandomdude.colortoolkit.spaces
{
    import com.somerandomdude.colortoolkit.CoreColor;

    public class HSL extends CoreColor implements IColorSpace 
    {

        private var _hue:Number;
        private var _saturation:Number;
        private var _lightness:Number;

        public function HSL(hue:Number=0, saturation:Number=0, lightness:Number=0)
        {
            this._hue = Math.min(360, Math.max(hue, 0));
            this._saturation = Math.min(100, Math.max(saturation, 0));
            this._lightness = Math.min(100, Math.max(lightness, 0));
            this._color = this.generateColorFromHSL(this._hue, this._saturation, this._lightness);
        }

        public function get hue():Number
        {
            return (this._hue);
        }

        public function set hue(value:Number):void
        {
            this._hue = Math.min(360, Math.max(value, 0));
            this._color = this.generateColorFromHSL(this._hue, this._saturation, this._lightness);
        }

        public function get saturation():Number
        {
            return (this._saturation);
        }

        public function set saturation(value:Number):void
        {
            this._saturation = Math.min(100, Math.max(value, 0));
            this._color = this.generateColorFromHSL(this._hue, this._saturation, this._lightness);
        }

        public function get lightness():Number
        {
            return (this._lightness);
        }

        public function set lightness(value:Number):void
        {
            this._lightness = Math.min(100, Math.max(value, 0));
            this._color = this.generateColorFromHSL(this._hue, this._saturation, this._lightness);
        }

        public function get color():Number
        {
            return (this._color);
        }

        public function set color(value:Number):void
        {
            this._color = value;
            var hsl:HSL = this.generateColorFromHex(value);
            this._hue = hsl.hue;
            this._saturation = hsl.saturation;
            this._lightness = hsl.lightness;
        }

        public function clone():IColorSpace
        {
            return (new HSL(this._hue, this._saturation, this._lightness));
        }

        private function generateColorFromHex(color:int):HSL
        {
            var h:Number;
            var s:Number;
            var l:Number;
            var _local_10:Number;
            var r:Number = ((color >> 16) & 0xFF);
            var g:Number = ((color >> 8) & 0xFF);
            var b:Number = (color & 0xFF);
            r = (r / 0xFF);
            g = (g / 0xFF);
            b = (b / 0xFF);
            var max:Number = Math.max(r, g, b);
            var min:Number = Math.min(r, g, b);
            l = ((max + min) / 2);
            s = l;
            h = s;
            if (max == min)
            {
                s = 0;
                h = s;
            }
            else
            {
                _local_10 = (max - min);
                s = (((l > 0.5)) ? (_local_10 / ((2 - max) - min)) : (_local_10 / (max + min)));
                switch (max)
                {
                    case r:
                        h = (((g - b) / _local_10) + (((g < b)) ? 6 : 0));
                        break;
                    case g:
                        h = (((b - r) / _local_10) + 2);
                        break;
                    case b:
                        h = (((r - g) / _local_10) + 4);
                        break;
                };
                h = (h / 6);
            };
            h = Math.round((h * 360));
            s = Math.round((s * 100));
            l = Math.round((l * 100));
            return (new HSL(h, s, l));
        }

        private function generateColorFromHSL(hue:Number, saturation:Number, lightness:Number):int
        {
            var r:Number;
            var g:Number;
            var b:Number;
            var q:Number;
            var p:Number;
            hue = (hue / 360);
            saturation = (saturation / 100);
            lightness = (lightness / 100);
            if (saturation == 0)
            {
                var _local_5 = lightness;
                b = _local_5;
                g = _local_5;
                r = _local_5;
            }
            else
            {
                var hue2rgb:Function = function (p:Number, q:Number, t:Number):Number
                {
                    if (t < 0)
                    {
                        t = (t + 1);
                    };
                    if (t > 1)
                    {
                        t = (t - 1);
                    };
                    if (t < (1 / 6))
                    {
                        return ((p + (((q - p) * 6) * t)));
                    };
                    if (t < (1 / 2))
                    {
                        return (q);
                    };
                    if (t < (2 / 3))
                    {
                        return ((p + (((q - p) * ((2 / 3) - t)) * 6)));
                    };
                    return (p);
                };
                q = (((lightness < 0.5)) ? (lightness * (1 + saturation)) : ((lightness + saturation) - (lightness * saturation)));
                p = ((2 * lightness) - q);
                r = hue2rgb(p, q, (hue + (1 / 3)));
                g = hue2rgb(p, q, hue);
                b = hue2rgb(p, q, (hue - (1 / 3)));
            };
            r = Math.floor((r * 0xFF));
            g = Math.floor((g * 0xFF));
            b = Math.floor((b * 0xFF));
            return ((((r << 16) ^ (g << 8)) ^ b));
        }


    }
}//package com.somerandomdude.colortoolkit.spaces

