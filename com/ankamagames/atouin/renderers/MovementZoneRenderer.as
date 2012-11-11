package com.ankamagames.atouin.renderers
{
    import com.ankamagames.atouin.enums.*;

    public class MovementZoneRenderer extends ZoneDARenderer
    {
        private var _showText:Boolean;
        private var _startAt:int;

        public function MovementZoneRenderer(param1:Boolean, param2:int = 1)
        {
            this._showText = param1;
            this._startAt = param2;
            strata = PlacementStrataEnums.STRATA_AREA;
            return;
        }// end function

        override protected function getText(param1:int) : String
        {
            if (this._showText)
            {
                return String(param1 + this._startAt);
            }
            return null;
        }// end function

    }
}
