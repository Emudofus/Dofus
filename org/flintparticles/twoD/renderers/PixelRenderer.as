package org.flintparticles.twoD.renderers
{
    import flash.geom.*;
    import org.flintparticles.twoD.particles.*;

    public class PixelRenderer extends BitmapRenderer
    {

        public function PixelRenderer(param1:Rectangle)
        {
            super(param1);
            return;
        }// end function

        override protected function drawParticle(param1:Particle2D) : void
        {
            _bitmapData.setPixel32(Math.round(param1.x - _canvas.x), Math.round(param1.y - _canvas.y), param1.color);
            return;
        }// end function

    }
}
