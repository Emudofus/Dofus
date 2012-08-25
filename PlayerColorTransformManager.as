package 
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.dofus.types.entities.*;
    import flash.geom.*;
    import gs.*;

    class PlayerColorTransformManager extends Object
    {
        private var _offSetValue:Number;
        private var _alphaValue:Number;
        private var _player:AnimatedCharacter;

        function PlayerColorTransformManager(param1:AnimatedCharacter)
        {
            this._player = param1;
            this._alphaValue = param1.alpha;
            this.offSetValue = 0;
            return;
        }// end function

        public function set offSetValue(param1:Number) : void
        {
            this._offSetValue = param1;
            if (Atouin.getInstance().options.transparentOverlayMode)
            {
                this._player.transform.colorTransform = new ColorTransform(1, 1, 1, this._alphaValue != 1 ? (this._alphaValue) : (AtouinConstants.OVERLAY_MODE_ALPHA), param1, param1, param1, 0);
            }
            else
            {
                this._player.transform.colorTransform = new ColorTransform(1, 1, 1, this._alphaValue, param1, param1, param1, 0);
            }
            return;
        }// end function

        public function get offSetValue() : Number
        {
            return this._offSetValue;
        }// end function

        public function enlightPlayer() : void
        {
            TweenMax.to(this, 0.7, {offSetValue:50, yoyo:1});
            return;
        }// end function

    }
}
