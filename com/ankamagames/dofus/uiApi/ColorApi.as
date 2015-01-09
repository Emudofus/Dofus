package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.jerakine.types.Color;

    [InstanciedApi]
    public class ColorApi implements IApi 
    {

        private var _module:UiModule;


        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [Trusted]
        public function destroy():void
        {
            this._module = null;
        }

        [Trusted]
        public function changeLightness(c:uint, value:Number):uint
        {
            return (Color.setHSLlightness(c, value));
        }

        [Trusted]
        public function changeSaturation(c:uint, saturation:Number):uint
        {
            return (Color.setHSVSaturation(c, saturation));
        }

        [Trusted]
        public function generateColorList(methode:int):Array
        {
            return (Color.generateColorList(methode));
        }


    }
}//package com.ankamagames.dofus.uiApi

