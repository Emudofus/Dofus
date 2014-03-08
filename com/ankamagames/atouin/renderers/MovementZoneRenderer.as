package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.Atouin;
   
   public class MovementZoneRenderer extends ZoneDARenderer
   {
      
      public function MovementZoneRenderer(param1:Boolean, param2:int=1) {
         super();
         this._showText = param1;
         this._startAt = param2;
         _strata = PlacementStrataEnums.STRATA_AREA;
         currentStrata = Atouin.getInstance().options.transparentOverlayMode?PlacementStrataEnums.STRATA_NO_Z_ORDER:_strata;
      }
      
      private var _showText:Boolean;
      
      private var _startAt:int;
      
      override protected function getText(param1:int) : String {
         if(this._showText)
         {
            return String(param1 + this._startAt);
         }
         return null;
      }
   }
}
